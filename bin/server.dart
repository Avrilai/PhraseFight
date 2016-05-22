library server;

import 'package:force/force_serverside.dart';
import 'dart:async';
import 'dart:math';

part 'gfycat_data.dart';
part 'Player.dart';
part 'Soldier.dart';
part 'TextObject.dart';
part 'GameMap.dart';
part 'Spell.dart';
part 'Unit.dart';
part 'Castle.dart';
part 'Tank.dart';

Map gamesList = <String, GameMap>{};
main() async {
  ForceServer fs = new ForceServer(
      host: '127.0.0.1',
      port: 8080,
      clientFiles: '../web/', //'../build/web/',
      startPage: 'index.html');

  GfycatData data = new GfycatData();

  await fs.start();

  fs.on('join match', (mp, sender) {
    String name = mp.json[0];
    String matchId = mp.json[1];

    if (!gamesList.keys.contains(matchId)) {
      if (matchId.isEmpty) {
        matchId = data.getRandomMatchId();
      }

      sender.reply('matchid', [matchId]);
      gamesList[matchId] = new GameMap();
    }

    GameMap game = gamesList[matchId];
    if (game.addPlayer(name)) {
      sender.reply('toast', 'Joined match');
      sender.reply('join successful', [matchId]);
    } else {
      sender.reply('toast', 'Match full');
      sender.reply('join failure', '');
    }
  });

  print('start server');
}
