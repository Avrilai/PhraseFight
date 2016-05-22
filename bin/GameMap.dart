part of server;

class GameMap {

  Timer timer;
  bool gameStart = false;
  Player player1;
  Player player2;

  //placeholder
  static final int mapWidth = 400;

  void start() {
    if (timer == null) {
      timer = new Timer.periodic(const Duration(milliseconds: 16), (_) {
        update();
      });
    }
  }

  void update() {
    for (int i = 0; i < player1.activeUnits.length; i++) {
      player1.activeUnits[i].xPosition += 0.02;
    }
    for (int i = 0; i < player2.activeUnits.length; i++) {
      player2.activeUnits[i].xPosition += 0.02;
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
      return true;
    }

    return false;
  }

  //units attack each other
  void unitCollision(Unit unitOne, Unit unitTwo) {
    if (unitTwo.canAttack) {
      unitOne.takeDamage(unitTwo.getAttack());
    }
    if (unitOne.canAttack) {
      unitTwo.takeDamage(unitOne.getAttack());
    }
  }

  bool comparePositions(Unit unitOne, Unit unitTwo) {
    return unitOne.xPosition.toInt() == unitTwo.xPosition.toInt();
  }

  void performLegalInteractions(Player p1, Player p2) {
    //checks if any two units of opposing sides are colliding
    for (int i = p1.activeUnits.length - 1; i >= 0; i--) {
      for (int j = p2.activeUnits.length - 1; j >= 0; j--) {
        if (comparePositions(p1.activeUnits[i], p2.activeUnits[j])) {
          //the two units attack each other, if any die, they are removed from the player's unitlist
          unitCollision(p1.activeUnits[i], p2.activeUnits[j]);
          if (!p1.activeUnits[i].isAlive()) {
            p1.activeUnits.remove(i);
          }
          if (!p2.activeUnits[i].isAlive()) {
            p2.activeUnits.remove(j);
          }
        }
      }
    }
    refreshUnitAttacks(p1);
    refreshUnitAttacks(p2);
  }

  void debug(){
    for (int i = player1.activeUnits.length - 1; i >= 0; i--) {
      print(player1.activeUnits[i].isAlive());
      print(player1.activeUnits[i].isAlive());
      print(player1.activeUnits[i].isAlive());
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

}