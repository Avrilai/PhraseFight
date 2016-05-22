part of server;

class GameMap {
  Timer timer;
  bool gameStart = false;

  //placeholder
  static final int leftCastleXPos = 20;
  static final int rightCastleXPos = 100;

  Player player1;
  Player player2;

  void start() {
    if (timer == null) {
      timer = new Timer.periodic(const Duration(milliseconds: 16), (_) {
        update();
        debug();
      });
//      new Timer.periodic(const Duration(seconds: 1), (_) {
//        debug();
//      });
    }
  }

  void update() {
    for (int i = 0; i < player1.activeUnits.length; i++) {
      if (player1.activeUnits[i].canMove) {
        player1.activeUnits[i].xPosition =
            clamp(player1.activeUnits[i].xPosition + 0.2, leftCastleXPos, rightCastleXPos);
      }
    }
    for (int i = 0; i < player2.activeUnits.length; i++) {
      if (player2.activeUnits[i].canMove) {
        player2.activeUnits[i].xPosition =
            clamp(player2.activeUnits[i].xPosition + 0.2, leftCastleXPos, rightCastleXPos);
      }
    }

    performLegalInteractions(player1, player2);
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
    return rightCastleXPos == unitOne.xPosition.toInt() + unitTwo.xPosition.toInt();
  }

  void performLegalInteractions(Player player1, Player player2) {
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
            print("derp");
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

  void debug() {
    debugUnits(player1);
    debugUnits(player2);
  }

  void debugUnits(Player player) {
    List<Unit> activeUnits = player.activeUnits;
    for (int i = activeUnits.length - 1; i >= 0; i--) {
      print("Player: ${player.name}");
      print("Unit is alive: ${activeUnits[i].isAlive()}");
      print("Unit's attack: ${activeUnits[i].getAttack()}");
      print("Unit's hp:  ${activeUnits[i].getHealth()}");
      print(
          "Unit position: ${getRealPositionX(player.name, activeUnits[i].xPosition)}");
    }
  }

  //enables units to attack after every loop (they're able to attack once per iteration)
  void refreshUnitAttacks(Player p) {
    for (int i = 0; i < p.activeUnits.length; i++) {
      p.activeUnits[i].canAttack = true;
    }
  }

  void spellDamageToCastle(Castle castle, Spell spell) {
    castle.takeDamage(spell.getDamage());
  }

  void unitDamageToCastle(Castle castle, Unit unit) {
    castle.takeDamage(unit.getAttack());
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
