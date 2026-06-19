import 'package:flutter/material.dart';
void main() {
  DecorationImage(
    image: NetworkImage('https://img.youtube.com/vi/GQI72THyO5I/hqdefault.jpg'),
    onError: (e, s) { print('Error'); },
  );
}
