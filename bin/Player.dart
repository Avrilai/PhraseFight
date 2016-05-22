part of server;

class Player {

  List<Unit> activeUnits = new List();
  List<Spell> activeSpells = new List();
  Castle castle = new Castle();
  String name;
  int points;
  int setStart;

  Player(this.name) {
    points = 0;
  }

  void purchaseUnit(Unit unit) {
    if (unit.cost <= points) {
      points -= unit.cost;
      activeUnits.add(unit);
    }
  }

  void activateSpell(Spell spell){
    if(spell.cost <= points){
      points -= spell.cost;
      activeSpells.add(spell);
    }
  }

  int setPoints(int value){
    points = value;
  }

}