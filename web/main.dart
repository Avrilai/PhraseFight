// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library game;

import 'dart:math';
import 'dart:html';

part 'gfycat_data.dart';
part 'Player.dart';
part 'Soldier.dart';
part 'TextObject.dart';
part 'Unit.dart';

void main() {
  String matchId = Uri.base.query.trim();

  // join match
  if (matchId.isEmpty) {
    print('creating match');
    GfycatData data = new GfycatData();
    matchId = data.getRandomMatchId();
    window.location.assign('${Uri.base.origin}${Uri.base.path}?$matchId');
  }
  // create match
  else {
    print('trying to join match: $matchId');
  }
}


