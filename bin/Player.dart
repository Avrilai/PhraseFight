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

  void purchaseUnit(Unit unit, var mp) {
    if (unit.cost <= points) {
      points -= unit.cost;
      activeUnits.add(unit);

      fs.send('buy unit', [mp.json[0], mp.json[1], mp.json[2], unit.xSpeed, unit.uuid]);

      fs.send('add mana', [mp.json[0], mp.json[1], -unit.cost]);
    }
  }

  void activateSpell(Spell spell){
    if(spell.cost <= points){
      points -= spell.cost;
      activeSpells.add(spell);
    }
  }

}