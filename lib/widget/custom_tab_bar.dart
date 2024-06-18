import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 3,
        child: TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelColor: Colors.blue,
            indicator: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.blue, width: 3))),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.only(left: 15, right: 15),
            indicatorColor: Colors.blue,
            tabs: [
              Tab(
                icon: Icon(Icons.book),
                child: Text(
                  "Cashbooks",
                ),
              ),
              Tab(
                icon: Icon(Icons.menu_book),
                child: Text("Passbook"),
              ),
              Tab(
                icon: Icon(Icons.settings),
                child: Text("settings"),
              )
            ]));
  }
}
