import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  // ignore: prefer_function_declarations_over_variables
  final Function onDestinationSelect;
  final List<NavigationDestination> items;
  const BottomNavbar(
      {super.key, required this.onDestinationSelect, required this.items});

  @override
  State<BottomNavbar> createState() => _BottomNavbar();
}

class _BottomNavbar extends State<BottomNavbar> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    _selectedIndex = index;
    widget.onDestinationSelect(index);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        animationDuration: Duration.zero,
        selectedIndex: _selectedIndex,
        destinations: widget.items,
        height: 64,
        onDestinationSelected: _onDestinationSelected);
  }
}
