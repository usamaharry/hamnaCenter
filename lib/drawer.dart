import 'package:flutter/material.dart';

import 'filters.dart';

class MainDrawer extends StatelessWidget {
  final appBarHeight;
  final Function handler;
  final bool isOneYear;
  final bool isTwoYear;

  MainDrawer(this.appBarHeight, this.handler, this.isOneYear, this.isTwoYear);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: appBarHeight + MediaQuery.of(context).padding.top,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: Icon(Icons.home),
            title: Text('Home'),
            subtitle: Text('Go to main page'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return Filters(handler, isOneYear, isTwoYear);
              })).then(
                (value) => Navigator.of(context).pop(),
              );
            },
            leading: Icon(Icons.settings),
            title: Text('Filters'),
            subtitle: Text('Adjust filers'),
          ),
        ],
      ),
    );
  }
}
