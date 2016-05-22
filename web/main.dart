// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library game;

import 'dart:math';
import 'dart:html';
import 'dart:js' as js;

import 'package:force/force_browser.dart';

String name, matchId;
ForceClient fc;

InputElement nameField = querySelector('#name');

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
    window.history.pushState({}, "matchid", '?${mp.json[0]}');
//    window.location.assign('${Uri.base.origin}${Uri.base.path}?${}');
  });

  fc.on('toast', (mp, _) => toast(mp.json));

  fc.on('join successful', (mp, _) {
    matchId = mp.json[0];
    querySelector('#login').remove();
    setupGame();
  });

  fc.on('join failure', (mp, _) {

  });

  querySelector("#submit").onClick.listen((_) {
    if (nameField.value.toString().isEmpty)
      return toast('Name must be specified');

    name = nameField.value.trim();

    fc.send('join match', [name, matchId]);
  });

}

void toast(String message, {int duration: 2500}) {
  print(message);
  js.context['Materialize'].callMethod('toast', [message, duration]);
}

void setupGame() {
  document.body.appendHtml('<div>setup game</div>');
  document.body.appendHtml('<div>$name</div>');
  document.body.appendHtml('<div>$matchId</div>');
}
