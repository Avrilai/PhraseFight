part of game;

class Game_Map {

  //placeholder
  static final int mapWidth = 400;

  void main() {
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


}