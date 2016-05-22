import 'server.dart';


void main() {
  GameMap g = new GameMap();

  //player initialization testing
  print(g.addPlayer("Jim"));
  print(g.addPlayer("Bob"));
  print(g.addPlayer("Roy"));

  //testing point purchasing system
  g.player1.setPoints(30);
  g.player2.setPoints(15);
  g.player1.purchaseUnit(new Soldier());
  print(g.player1.points);
  g.player2.purchaseUnit(new Tank());
  print(g.player2.points);

  //testing combat


}
