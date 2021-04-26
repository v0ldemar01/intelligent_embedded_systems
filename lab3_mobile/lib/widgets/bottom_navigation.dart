import 'package:flutter/material.dart';

class TabItem {
  TabItem({this.label, this.title, this.icon, this.backgroundColor});
  final String label;
  final String title;
  final icon;
  final Color backgroundColor;
}

List<TabItem> allTabItems = <TabItem>[
  TabItem(
    icon: Icon(Icons.miscellaneous_services),
    label: 'factorization',
    title: 'Fermat`s factorization example',
    backgroundColor: Colors.redAccent[400]),
  TabItem(
    icon: Icon(Icons.mediation),
    label: 'perceptron',
    title: 'Perceptron example',
    backgroundColor: Colors.tealAccent[400]),
  TabItem(
    icon: Icon(Icons.developer_board),
    label: 'genetic',
    title: 'Genetic algorithm for diaphantine equation',
    backgroundColor: Colors.deepPurpleAccent[400]),
];

class BottomNavigation extends StatelessWidget {
  BottomNavigation({@required this.currentIndex, @required this.onSelectTab});

  final int currentIndex;
  final ValueChanged<int> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      items: allTabItems
        .map((TabItem tabItem) => BottomNavigationBarItem(
            icon: tabItem.icon,
            backgroundColor: tabItem.backgroundColor,
            label: tabItem.label))
        .toList(),
      currentIndex: currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: onSelectTab,
      iconSize: 30,
    );
  }
}
