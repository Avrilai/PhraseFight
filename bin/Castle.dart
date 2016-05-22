part of server;

class Castle{

  int _health;

  Castle() {
    _health = 50;
  }

  void takeDamage(int damageAmount){
    _health -= damageAmount;
  }

  int getHealth() => _health;
}