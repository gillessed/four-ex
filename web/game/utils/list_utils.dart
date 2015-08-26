part of utils;

List listMap(List s, Function map) {
  List t = [];
  for(var o in s) {
    t.add(map(o));
  }
  return t;
}