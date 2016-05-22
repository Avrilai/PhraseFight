part of server;

class Unit {

  num _health;
  num _attack;
  num xPosition = GameMap.leftCastleXPos;
  int cost;
  bool _alive;
  bool canMove;
  bool canAttack;

  Unit(this._health, this._attack, this.cost) {
    _alive = true;
    canAttack = true;
    canMove = true;
  }

  void takeDamage(num damageTaken) {
    this._health -= damageTaken;
    if(this._health <= 0){
      _alive = false;
    }
  }

  num getAttack() => this._attack;

  num getHealth() => this._health;

  bool isAlive() => this._alive;

}