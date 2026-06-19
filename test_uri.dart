void main() {
  var u1 = Uri.parse("b:?b=10&c=1&v=1");
  print("u1: scheme=${u1.scheme}, path=${u1.path}, queryParams=${u1.queryParameters}");
  var u2 = Uri.parse("b://?b=10&c=1&v=1");
  print("u2: scheme=${u2.scheme}, path=${u2.path}, queryParams=${u2.queryParameters}");
  var u3 = Uri.parse("b:10/1/1");
  print("u3: scheme=${u3.scheme}, path=${u3.path}");
}
