library server;

import 'package:force/force_serverside.dart';
import 'dart:async';
import 'dart:math';
import 'package:uuid/uuid.dart';

part 'gfycat_data.dart';
part 'Player.dart';
part 'Soldier.dart';
part 'TextObject.dart';
part 'GameMap.dart';
part 'Spell.dart';
part 'Unit.dart';
part 'Castle.dart';
part 'text_data.dart';
part 'Tank.dart';

Map gamesList = <String, GameMap>{};
ForceServer fs;
main() async {
  fs = new ForceServer(
      host: 'localhost',
      port: 8080,
      clientFiles: '../web/', //'../build/web/',
      startPage: 'index.html');

  GfycatData data = new GfycatData();
  TextData textData = new TextData();

  await fs.start();

  fs.on('join match', (mp, sender) {
    String name = mp.json[0];
    String matchId = mp.json[1];

    if (!gamesList.keys.contains(matchId)) {
      if (matchId.isEmpty) {
        matchId = data.getRandomMatchId();
      }

      sender.reply('matchid', [matchId]);
      gamesList[matchId] = new GameMap(matchId);
    }

    GameMap game = gamesList[matchId];
    if (game.addPlayer(name)) {
      sender.reply('toast', 'Joined match');
      sender.reply('join successful', [matchId]);
      sender.reply('phrase', textData.getRandomPhrase());

      fs.send('set name', [name, matchId]);

      if (game.player1 != null && game.player2 != null) {
        fs.send('set name', [game.player1.name, matchId]);
        sender.reply('toast', 'Start Game!');
      }
    } else {
      sender.reply('toast', 'Match full');
      sender.reply('join failure', '');
    }

  });

  fs.on('add mana', (mp, sender) {
    GameMap game = gamesList[mp.json[1]];
    if (game == null) return;

    if (mp.json[0] == game.player1.name) {
      game.player1.points += mp.json[2];
    } else {
      game.player2.points += mp.json[2];
    }
    fs.send('add mana', mp.json);
  });

  fs.on('new phrase', (mp, sender) {
    sender.reply('phrase', textData.getRandomPhrase());
  });

  fs.on('buy units', (mp, sender) {
    GameMap game = gamesList[mp.json[1]];
    Unit unit = Unit.getUnitType(mp.json[2], mp.json[0], mp.json[1]);
    if (mp.json[0] == game.player1.name) {
      game.player1.purchaseUnit(unit, mp);
    } else {
      game.player2.purchaseUnit(unit, mp);
    }
  });

  print('start server');
}
