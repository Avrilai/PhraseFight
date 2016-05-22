// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library game;

import 'dart:math';
import 'dart:html';
import 'dart:js' as js;

import 'package:force/force_browser.dart';

part 'Player.dart';
part 'Soldier.dart';
part 'TextObject.dart';
part 'Unit.dart';
part 'Game_Map.dart';

String name, matchId;
ForceClient fc;

InputElement nameField = querySelector('#name');
Map clientData;

void main() {
  matchId = Uri.base.query.trim();

  fc = new ForceClient();
  fc.connect();

  fc.onConnected.listen((_) {
    print("connected!");
  });

  fc.onDisconnected.listen((_) {
    print("disconnected!");
  });

  fc.on('matchid', (mp, sender) {
    window.history.pushState({}, "matchid", mp.json[0]);
//    window.location.assign('${Uri.base.origin}${Uri.base.path}?${}');
  });

  fc.on('toast', (mp, _) => toast(mp.json));

  fc.on('join successful', (mp, _) {
    querySelector('#login').remove();
  });

  querySelector("#submit").onClick.listen((_) {
    if (nameField.value.toString().isEmpty)
      return toast('Name must be specified');

    clientData = {
      'name':nameField.value.trim(),
      'matchId' : matchId
    };

    fc.send('join match', clientData);
  });

}

void toast(String message, {int duration: 2500}) {
  print(message);
  js.context['Materialize'].callMethod('toast', [message, duration]);
}
