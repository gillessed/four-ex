part of model;

class OrbitalPlatform {
  HexagonalLattice<Tile> tiles;
  OrbitalPlatform() {
    tiles = new HexagonalLattice.empty(false, true, 5, 5);
    for(int i = 0; i < 5; i++) {
      for(int j = 0; j < 5; j++) {
        tiles.set(new Tile([]), i, j);
      }
    }
  }
}