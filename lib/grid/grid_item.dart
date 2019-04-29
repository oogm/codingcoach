abstract class GridItem {
  int x;
  int y;

  GridItem({this.x, this.y});
}

class Player extends GridItem {
  int rotation = 90;

  Player({int x, int y}) : super(x: x, y: y);
}

class Obstacle extends GridItem {
  Obstacle({int x, int y}) : super(x: x, y: y);
}

class Target extends GridItem {
  Target({int x, int y}) : super(x: x, y: y);
}
