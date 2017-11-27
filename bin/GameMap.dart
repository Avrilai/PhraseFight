part of server;

class GameMap {
  Timer timer;
  bool gameStart = false;

  //placeholder
  static final int leftCastleXPos = 100;
  static final int rightCastleXPos = 1000;

  Player player1;
  Player player2;

  String matchId;

  GameMap(this.matchId);

  void start() {
    if (timer == null) {
      timer = new Timer.periodic(const Duration(milliseconds: 16), (_) {
        update();
//        debug();
      });
      new Timer.periodic(const Duration(seconds: 1), (_) {
//        debug();
        debugCastle();
      });
    }
  }

  void update() {
    updateUnits(player1);
    updateUnits(player2);
    updateSpells(player1);
    updateSpells(player2);
    performSpellInteractions();
    performUnitToCastleInteractions();
    performUnitInteractions(player1, player2);

    if (player1.castle.destroyed || player2.castle.destroyed) {
      stop();
    }
  }

  void updateUnits(Player player) {
    for (int i = 0; i < player.activeUnits.length; i++) {
      player.activeUnits[i].xPosition =
          clamp(player.activeUnits[i].move(), leftCastleXPos, rightCastleXPos);
    }
  }

  void updateSpells(Player player) {
//    for (int i = 0; i < player.activeSpells.length; i++) {
//      player.activeSpells[i].xPosition =
//          clamp(player.activeSpells[i].move(), leftCastleXPos,
//              rightCastleXPos);
//    }
  }

  void stop() {
    if (timer != null) {
      timer.cancel();
    }
  }

  bool addPlayer(String name) {
    if (player1 == null) {
      player1 = new Player(name);
      return true;
    }

    if (player2 == null) {
      player2 = new Player(name);
      start();
      return true;
    }

    return false;
  }

  //units attack each other
  void unitCollision(Unit unitOne, Unit unitTwo) {
    unitOne.canMove = false;
    unitTwo.canMove = false;

    if (unitTwo.canAttack && unitOne.isAlive()) {
      unitOne.takeDamage(unitTwo.getAttack());
    }
    if (unitOne.canAttack && unitTwo.isAlive()) {
      unitTwo.takeDamage(unitOne.getAttack());
    }
  }

  bool comparePositions(Unit unitOne, Unit unitTwo) {
    return rightCastleXPos -
            (unitOne.xPosition.toInt() + unitTwo.xPosition.toInt()).abs() <
        10;
  }

  void performSpellInteractions() {
//    for (int i = 0; i < player1.activeSpells.length; i++) {
//      if (player1.activeSpells[i].xPosition.toInt() ==
//          rightCastleXPos.toInt()) {
//        player2.castle.takeDamage(
//            player1.activeSpells[i].getDamage(), player1.name, matchId);
//        player1.activeSpells[i].complete();
//      }
//    }
//    for (int i = 0; i < player2.activeSpells.length; i++) {
//      if (getRealPositionX(
//              player2.name, player2.activeSpells[i].xPosition.toInt()) ==
//          leftCastleXPos.toInt()) {
//        player1.castle.takeDamage(
//            player2.activeSpells[i].getDamage(), player1.name, matchId);
//        player1.activeSpells[i].complete();
//      }
//    }
//
//    player1.activeSpells.removeWhere((spell) => spell.isComplete());
//    player2.activeSpells.removeWhere((spell) => spell.isComplete());
  }

  void performUnitInteractions(Player player1, Player player2) {
    //checks if any two units of opposing sides are colliding
    for (int i = player1.activeUnits.length - 1; i >= 0; i--) {
      for (int j = player2.activeUnits.length - 1; j >= 0; j--) {
        if (comparePositions(player1.activeUnits[i], player2.activeUnits[j])) {
          //the two units attack each other, if any die, they are removed from the player's unitlist
          unitCollision(player1.activeUnits[i], player2.activeUnits[j]);
          if (!player1.activeUnits[i].isAlive()) {
            player2.activeUnits[j].canMove = true;
          }
          if (!player2.activeUnits[j].isAlive()) {
            player1.activeUnits[i].canMove = true;
          }
        }
      }
    }

    player1.activeUnits.removeWhere((unit) => !unit.isAlive());
    player2.activeUnits.removeWhere((unit) => !unit.isAlive());

    refreshUnitAttacks(player1);
    refreshUnitAttacks(player2);
  }

  void performUnitToCastleInteractions() {
    for (int i = 0; i < player1.activeUnits.length; i++) {
      if (player1.activeUnits[i].xPosition.toInt() > 900) {
        player2.castle.takeDamage(
            player1.activeUnits[i].getAttack(), player2.name, matchId);
      }
    }
    for (int i = 0; i < player2.activeUnits.length; i++) {
      if (player2.activeUnits[i].xPosition.toInt() > 900) {
        player1.castle.takeDamage(
            player2.activeUnits[i].getAttack(), player1.name, matchId);
      }
    }
  }

  void debug() {
    debugUnits(player1);
    debugUnits(player2);
  }

  void debugUnits(Player player) {
    List<Unit> activeUnits = player.activeUnits;
    for (int i = activeUnits.length - 1; i >= 0; i--) {
      print("Player: ${player.name}");
//      print("Unit is alive: ${activeUnits[i].isAlive()}");
//      print("Unit's attack: ${activeUnits[i].getAttack()}");
      print("Unit's hp:  ${activeUnits[i].getHealth()}");
      print("Unit position: ${getRealPositionX(
              player.name, activeUnits[i].xPosition)}");
    }
  }

  void debugCastle() {
    print("Player 1 Castle Health: ${player1.castle.getHealth()}");
    print("Player 2 Castle Health: ${player2.castle.getHealth()}");
  }

  //enables units to attack after every loop (they're able to attack once per iteration)
  void refreshUnitAttacks(Player p) {
    for (int i = 0; i < p.activeUnits.length; i++) {
      p.activeUnits[i].canAttack = true;
    }
  }
//
//  void spellDamageToCastle(Castle castle, Spell spell) {
//    castle.takeDamage(spell.getDamage());
//  }

  void unitDamageToCastle(Castle castle, Unit unit) {
    castle.takeDamage(unit.getAttack(), unit.name, unit.matchId);
  }

  num getRealPositionX(String name, num x) {
    if (player1.name != name) {
      return rightCastleXPos - x;
    }
    return x;
  }
}

num clamp(num val, num left, num right) {
  if (val < left) {
    val = left;
  }
  if (val > right) {
    val = right;
  }
  return val;
}
