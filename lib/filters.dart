import 'package:flutter/material.dart';

import 'drawer.dart';

class Filters extends StatefulWidget {
  final Function handler;
  bool isOneYear;
  bool isTwoYear;

  Filters(this.handler, this.isOneYear, this.isTwoYear);
  @override
  _FiltersState createState() => _FiltersState();
}

double height;

class _FiltersState extends State<Filters> {
  Widget appBarBuilder(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text('Filters'),
    );

    height = appBar.preferredSize.height;

    return appBar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilder(context),
      body: Column(
        children: [
          SwitchListTile(
            title: Text('One year program'),
            subtitle: Text('Students having one year program'),
            value: widget.isOneYear,
            onChanged: (newValue) {
              setState(() {
                widget.isOneYear = newValue;
                widget.handler(widget.isOneYear, widget.isTwoYear);
                
              });
            },
          ),
          SwitchListTile(
            title: Text('Two year program'),
            subtitle: Text('Students having two year program'),
            value: widget.isTwoYear,
            onChanged: (newValue) {
              setState(() {
                widget.isTwoYear = newValue;
                widget.handler(widget.isOneYear, widget.isTwoYear);
                
              });
            },
          )
        ],
      ),
    );
  }
}
