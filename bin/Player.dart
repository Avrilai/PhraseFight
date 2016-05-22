part of game;

class Player{

  List<Unit> activeUnits = new List();
  String name;

  Player(this.name){

  }

  Unit spawnUnit(Unit unit){
    activeUnits.add(unit);
  }


}