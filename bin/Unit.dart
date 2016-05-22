part of server;

class Unit {

  int _health;
  int _attack;
  num xPosition;
  int cost;
  bool _alive;
  bool canAttack;

  Unit(this._health, this._attack, this.cost) {
    xPosition = 0;
    _alive = true;
    canAttack = true;
  }

  int takeDamage(int damageTaken) {
    this._health -= damageTaken;
    if(this._health <= 0){
      _alive = false;
    }
  }

  int getAttack() => this._attack;

  int getHealth() => this._health;

  bool isAlive() => this._alive;

}