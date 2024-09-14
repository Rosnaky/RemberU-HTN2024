import 'package:flutter/material.dart';

class Destination {
  const Destination(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<Destination> destinations = [
  Destination(Icons.home, 'Home'),
  Destination(Icons.cloud, 'Weather'),
  Destination(Icons.map, 'Navigation'),
  Destination(Icons.people_alt_outlined, 'Club'),
  Destination(Icons.book, 'Logbook'),
];
