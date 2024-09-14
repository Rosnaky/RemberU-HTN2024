import 'package:flutter/material.dart';

class Destination {
  const Destination(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<Destination> destinations = [
  Destination(Icons.home, 'Home'),
  Destination(Icons.cloud, 'Profile'),
];
