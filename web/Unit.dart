part of game;

class Unit{

  int _health;
  int _attack;
  int xPosition;
  int cost;

  Unit(this._health, this._attack, this.cost){
    xPosition = 0;
  }

  int damaged(int damageTaken){
    this._health -= damageTaken;
  }

  int getAttack() => this._attack;
  int getHealth() => this._health;

}