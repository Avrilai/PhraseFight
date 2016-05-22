part of server;

class Player {

  List<Unit> activeUnits = new List();
  String name;
  int points;

  Player(this.name) {
    points = 0;
  }

  Unit purchaseUnit(Unit unit) {
    if (unit.cost <= points) {
      points -= unit.cost;
      activeUnits.add(unit);
    }
  }

  int setPoints(int value){
    points = value;
  }

}