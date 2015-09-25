part of transformation;

/**
 * Represents a two dimensional vertical hexagonal lattice.
 * 
 * If the lattice is symmetric, the edge of the lattice
 * will be line-wise symmetric down the middle. Otherwise, it
 * will stick in on one side and out the other.
 * 
 * If the lattice is upper, that means that even parity columns
 * will stick out on the top of the matrix. Otherwise, odd-parity columns
 * will stick out.
 * 
 * If the lattice is symmetric, the height should represent the height of
 * the larger columns.
 */
class HexagonalLattice<T> {
  int width;
  int height;
  List<List<T>> array;
  bool symmetric;
  bool upper;
  
  HexagonalLattice.empty(this.symmetric, this.upper, this.width, this.height) {
    array = [];
    for(int x = 0; x < width; x++) {
      array.add([]);
      for(int y = 0; y < heightFor(x); y++) {
        array[x].add(null);
      }
    }
  }
  
  bool isEmpty(int x, int y) {
    return array[x][y] == null;
  }
  
  T get(int x, int y) {
    return array[x][y];
  }
  
  set(T t, int x, int y) {
    array[x][y] = t;
  }
  
  getRandomPoint() {
    if(symmetric) {
      int x = random.nextInt(width);
      int y;
      if(upper) {
        if(x % 2 == 0) {
          y = random.nextInt(height);
        } else {
          y = random.nextInt(height - 1);
        }
      } else {
        if(x % 2 == 0) {
          y = random.nextInt(height - 1);
        } else {
          y = random.nextInt(height);
        }
      }
      return {
        'x': x,
        'y': y
      };
    } else {
      return {
        'x': random.nextInt(width),
        'y': random.nextInt(height)
      };
    }
  }

  List<T> getNeighbours(int x, int y) {
    //TODO
  }
  
  /**
   * Converts lattice coordinates to Euclidean coordinates.
   * 
   * The hexagon radius is considered the distance from its center to
   * one of it vertices.
   */
  TPoint convertToEuclidean(int x, int y, int hexagonRadius) {
    num mx = x * hexagonRadius * 1.5;
    num dy = getHexagonHeight(hexagonRadius);
    num my;
    if(symmetric) {
      if(upper) {
        if(x % 2 == 0) {
          my = y * dy * 2;
        } else {
          my = y * dy * 2 + dy;
        }
      } else {
        if(x % 2 == 0) {
          my = y * dy * 2;
        } else {
          my = y * dy * 2 - dy;
        }
      }
    } else {
      if(upper) {
        if(x % 2 == 0) {
          my = y * dy * 2;
        } else {
          my = y * dy * 2 + dy;
        }
      } else {
        if(x % 2 == 1) {
          my = y * dy * 2;
        } else {
          my = y * dy * 2 - dy;
        }
      }
    }
    return new TPoint(mx, my);
  }
  
  /**
   * Iterate over the lattice points. The order is by column.
   */
  List<TPoint> points(int hexagonRadius) {
    List<TPoint> points = [];
    for(int x = 0; x < width; x++) {
      for(int y = 0; y < heightFor(x); y++) {
        points.add(convertToEuclidean(x, y, hexagonRadius));
      }
    }
    return points;
  }
  
  int heightFor(int x) {
    if(symmetric) {
      if(upper) {
        if(x % 2 == 0) {
          return height;
        } else {
          return height - 1;
        }
      } else {
        if(x % 2 == 0) {
          return height - 1;
        } else {
          return height;
        }
      }
    } else {
      return height;
    }
  }
  
  /**
   * Iterate over the non-empty lattice points. The order is by column.
   */
  Map<TPoint, T> nonEmptyPoints(int hexagonRadius) {
    Map<TPoint, T> points = {};
    for(int x = 0; x < width; x++) {
      for(int y = 0; y < heightFor(x); y++) {
        if(get(x, y) != null) {
          points[convertToEuclidean(x, y, hexagonRadius)] = get(x, y);
        }
      }
    }
    return points;
  }
  
  
  static num getHexagonHeight(int hexagonRadius) {
    return sqrt(3) / 2 * hexagonRadius;
  }
}
