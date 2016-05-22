library server;

import 'package:force/force_serverside.dart';
import 'dart:math';

part 'gfycat_data.dart';

class Game {

}

Map gamesList = <String, Game>{};
main() async {
  ForceServer fs = new ForceServer(
      host: '127.0.0.1',
      port: 8080,
      clientFiles: '../web/',//'../build/web/',
      startPage: 'index.html');

  GfycatData data = new GfycatData();

  await fs.start();

  fs.on('join match', (mp, sender) {
    String matchId = mp.json['matchId'];
    if (gamesList.keys.contains(matchId)) {

    } else {
      sender.reply('matchid', [data.getRandomMatchId()]);
    }

    sender.reply('toast', 'Joined match $matchId');
    sender.reply('join successful', '');
  });
}
