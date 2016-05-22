part of game;

class Game_Map {

  bool gameStart = false;
  Player player1;
  Player player2;

  //placeholder
  static final int mapWidth = 400;

  void main() {
  }

  bool addPlayer(String name) {
    if (player1 != null) {
      player1 = new Player(name);
      return true;
    }

    if (player2 != null) {
      player2 = new Player(name);
      return true;
    }

    return false;
  }

  void unitCollision(Unit unitOne, Unit unitTwo) {
      unitOne.takeDamage(unitTwo.getAttack());
      unitTwo.takeDamage(unitOne.getAttack());
  }

  bool comparePositions(Unit unitOne, Unit unitTwo) {
    return unitOne.xPosition == unitTwo.xPosition;
  }

  void performLegalInteractions(Player p1, Player p2){
    for(int i = 0; i < p1.activeUnits.length; i++){
      for(int j = 0; j < p2.activeUnits.length; j++){
        if(comparePositions(p1.activeUnits[i], p2.activeUnits[j])){
            unitCollision(p1.activeUnits[i], p2.activeUnits[j]);
        }
      }
    }
  }

  void spellDamageToCastle(Castle castle, Spell spell){
    castle.takeDamage(spell.getDamage());
  }

  void unitDamageToCastle(Castle castle, Unit unit){
    castle.takeDamage(unit.getAttack());
  }

}