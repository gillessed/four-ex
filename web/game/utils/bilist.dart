part of utils;

class BiList<S, T> {
  List<S> first;
  List<T> second;
  
  BiList.blank() {
    first = [];
    second = [];
  }
  
  BiList(List<S> first, List<T> second) {
    if(first.length != second.length) {
      throw new StateError('Input lists for bilist must have same length');
    }
    this.first = [];
    this.first.addAll(first);
    this.second = [];
    this.second.addAll(second);
  }

  void add(S s, T t) {
    first.add(s);
    second.add(t);
  }

  int getIndexOfS(S s) {
    int index = first.indexOf(s);
    if(index < 0) {
      throw new IndexError(index, second);
    }
    return index;
  }

  int getIndexOfT(T t) {
    int index = second.indexOf(t);
    if(index < 0) {
      throw new IndexError(index, second);
    }
    return index;
  }
  
  T getT(S s) {
    return second[getIndexOfS(s)];
  }
  
  S getS(T t) {
    return first[getIndexOfT(t)];
  }

  void replaceT(S s, T t) {
    second[getIndexOfS(s)] = t;
  }

  void replaceS(S s, T t) {
    first[getIndexOfT(t)] = s;
  }
  
  void removeByS(S s) {
    removeAt(getIndexOfS(s));
  }
  
  void removeByT(T t) {
    removeAt(getIndexOfT(t));
  }
  
  void removeAt(int index) {
    first.removeAt(index);
    second.removeAt(index);
  }
  
  void forEach(var lambda) {
    for(int i = 0; i < first.length; i++) {
      lambda(first[i], second[i]);
    }
  }
  
  void forEachReverse(var lambda) {
    for(int i = first.length - 1; i >= 0; i--) {
      lambda(first[i], second[i]);
    }
  }
  
  bool forEachUntil(var lambda) {
    for(int i = 0; i < first.length; i++) {
      if(lambda(first[i], second[i])) {
        return true;
      }
    }
    return false;
  }
  
  bool forEachReverseUntil(var lambda) {
    for(int i = first.length - 1; i >= 0; i--) {
      if(lambda(first[i], second[i])) {
        return true;
      }
    }
    return false;
  }
  
  void clear() {
    first.clear();
    second.clear();
  }
}