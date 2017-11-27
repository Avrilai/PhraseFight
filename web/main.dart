// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library game;

import 'dart:html';
import 'dart:js' as js;

import 'package:force/force_browser.dart';

String name, matchId;
ForceClient fc;

InputElement nameField = querySelector('#name');

String currentText = "";
int currentVal = 0;

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
  });

  fc.on('toast', (mp, _) => toast(mp.json));

  fc.on('join successful', (mp, _) {
    matchId = mp.json[0];
    querySelector('#login').remove();
    setupGame();
  });

  fc.on('join failure', (mp, _) {});

  querySelector("#submit").onClick.listen((_) {
    if (nameField.value.toString().isEmpty)
      return toast('Name must be specified');

    name = nameField.value.trim();

    fc.send('join match', [name, matchId]);
  });

  fc.on('phrase', (mp, sender) {
    String phrase = mp.json['text'];
    int value = mp.json['value'];
    onNewPhrase(phrase, value);
  });

  fc.on('add mana', (mp, sender) {
    if (mp.json[1] != matchId) return;

    if (mp.json[0] == name) {
      js.context.callMethod('addMana', [1, mp.json[2]]);
    } else {
      js.context.callMethod('addMana', [2, mp.json[2]]);
    }
  });

  fc.on('set name', (mp, sender) {
    if (mp.json[1] != matchId) return;

    if (mp.json[0] == name) {
      js.context.callMethod('setName', [1, mp.json[0]]);
    } else {
      js.context.callMethod('setName', [2, mp.json[0]]);
    }
  });

  fc.on('buy unit', (mp, sender) {
    if (mp.json[1] != matchId) return;

    if (mp.json[0] == name) {
      js.context.callMethod('buyUnit', [1, mp.json[2], mp.json[3], mp.json[4]]);
    } else {
      js.context.callMethod('buyUnit', [2, mp.json[2], mp.json[3], mp.json[4]]);
    }
  });

  fc.on('remove unit', (mp, sender) {
    if (mp.json[1] != matchId) return;

    if (mp.json[0] == name) {
      js.context.callMethod('removeUnit', [1, mp.json[2]]);
    } else {
      js.context.callMethod('removeUnit', [2, mp.json[2]]);
    }
  });

  fc.on('set castle health', (mp, sender) {
    if (mp.json[1] != matchId) return;
    if (mp.json[0] == name) {
      js.context.callMethod('setCastleHealth', [1, mp.json[2]]);
    } else {
      js.context.callMethod('setCastleHealth', [2, mp.json[2]]);
    }
  });
}

void toast(String message, {int duration: 2500}) {
  js.context['Materialize'].callMethod('toast', [message, duration]);
}

void setupGame() {
  querySelector('#mycanvas').style.visibility = 'visible';
  querySelector('#input').style.visibility = 'visible';
  querySelector('#phrase-holder').style.visibility = 'visible';
  InputElement input = querySelector('#input');
  document.onKeyDown.listen((e) {
    if (e.keyCode == KeyCode.ENTER) {
      checkText(input.value.trim(), currentText);
      e.preventDefault();
      input.value = "";
    } else if (e.keyCode >= 48 && e.keyCode <= 57) {
      if (e.keyCode > 48) {
        buyUnit(e.keyCode - 48);
      }
      e.preventDefault();
      return false;
    }
  });
}

void buyUnit(int unitId) {
  fc.send('buy units', [name, matchId, unitId]);
}

void onNewPhrase(String phrase, int value) {
  currentText = phrase;
  currentVal = value;
  querySelector('#phrase-holder').text = phrase;
}

void checkText(String typed, String original) {
  if (typed == original) {
    fc.send('add mana', [name, matchId, currentVal]);
    fc.send('new phrase', '');
  } else {}
}
