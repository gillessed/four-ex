part of utils;

List listMap(List s, Function map) {
  List t = [];
  for(var o in s) {
    t.add(map(o));
  }
  return t;
}

dynamic listReduce(List s, Function combine, {var startValue}) {
  int startIndex = 0;
  var value = startValue;
  if(startValue == null) {
    value = s[0];
    startIndex = 1;
  }
  for(int i = startIndex; i < s.length; i++) {
    value = combine(value, s[i]);
  }
  return value;
}