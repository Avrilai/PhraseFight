part of server;

class Unit{

  int _health;
  int _attack;
  int xPosition;
  int cost;
  bool _alive;

  Unit(this._health, this._attack, this.cost){
    xPosition = 0;
    _alive = true;
  }

  int takeDamage(int damageTaken){
    this._health -= damageTaken;
  }

  int getAttack() => this._attack;
  int getHealth() => this._health;
  bool isAlive() => this._alive;

}