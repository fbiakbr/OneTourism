import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:onetourism/add.dart';
import 'login.dart';
import 'destinations.dart';
import 'add.dart';
import 'search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int _selectedIndex = 0;

  void _onInputTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Beranda'),
        actions: [searchBar.getSearchAction(context)]);
  }

  _HomePageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar);
  }

  static const List<Widget> _pages = <Widget>[
    DestinationsPage(), 
    SearchPage(),
    AddPage(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.indigo,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 18,
        unselectedFontSize: 14,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Destination',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
        ],
        onTap: _onInputTapped,
        currentIndex: _selectedIndex,
      ),
      body: Container(
        child: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
