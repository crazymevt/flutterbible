import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home'))
            ],
            selectedIndex: 0,
            trailing: Expanded(child: Container()),
          )
        ],
      )
    )
  ));
}
