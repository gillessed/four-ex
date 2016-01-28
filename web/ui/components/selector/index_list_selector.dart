part of view;

class IndexSelector<T> extends Selector<T> {
  int index = 0;
  Function getArray;
  IndexSelector(this.getArray);

  @override
  T current() {
    return getArray()[index];
  }

  @override
  void next() {
    index++;
    if(index >= getArray().length) {
      index = 0;
    }
  }

  @override
  void previous() {
    index = index - 1;
    if(index < 0) {
      index = getArray().length - 1;
    }
  }
}