part of server;

class Spell{

  int _damage;
  int cost;
  bool _completed;
  num xPosition = GameMap.leftCastleXPos;

  Spell(this._damage, this.cost){
    _completed = false;
  }

  void complete(){
    _completed = true;
  }

  bool isComplete() => _completed;
  int getDamage() => _damage;

}