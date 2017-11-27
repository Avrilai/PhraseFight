part of server;

class Castle{

  num _health;
  bool destroyed;

  Castle() {
    _health = 180;
    destroyed = false;
  }

  void takeDamage(num damageAmount, String name, String matchId){
    _health -= damageAmount;
    if (_health < 0) _health = 0;
    fs.send('set castle health', [name, matchId, _health]);
    if(_health <= 0 && !destroyed){
      destroyed = true;
    }
  }

  num getHealth() => _health;
}