part of server;

class Unit {

  num _health;
  num _attack;
  num xSpeed = 0.35;
  num xPosition = GameMap.leftCastleXPos;
  int cost;
  bool _alive;
  bool canMove;
  bool canAttack;
  String name, uuid, matchId;

  Unit(this.name, this.matchId, this._health, this._attack, this.cost) {
    _alive = true;
    canAttack = true;
    canMove = true;
    uuid = new Uuid().v1();
  }

  void takeDamage(num damageTaken) {
    this._health -= damageTaken;
    if(this._health <= 0 && _alive){
      fs.send('remove unit', [name, matchId, uuid]);
      _alive = false;
    }
  }

  num move(){
    return xPosition + xSpeed;
  }

  num getAttack() => this._attack;

  num getHealth() => this._health;

  bool isAlive() => this._alive;

  static Unit getUnitType(int unitType, String name, String matchId) {
    switch(unitType) {
      case 1:
        return new Soldier(name, matchId);
      case 2:
        return new Tank(name, matchId);
      default:
        return new Soldier(name, matchId);
    }
  }
}