part of server;

class Castle{

  num _health;
  bool destroyed;

  Castle() {
    _health = 50;
    destroyed = false;
  }

  void takeDamage(num damageAmount){
    _health -= damageAmount;
    if(_health <= 0){
      destroyed = true;
    }
  }

  num getHealth() => _health;
}