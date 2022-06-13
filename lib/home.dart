import 'dart:io';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  String text = "Initial Text";
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Beranda"),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                child: DrawerHeader(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://cdn.picpng.com/person/user-person-people-profile-53120.png"),
                          radius: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'OneTourism',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text("About"),
                      onTap: () {
                        setState(
                          () {
                            text = "info pressed";
                          },
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.save),
                      title: Text("Save", style: TextStyle(fontSize: 20)),
                      onTap: () {
                        setState(
                          () {
                            text = "save pressed";
                          },
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                      onTap: () {
                        setState(
                          () {
                            text = "settings pressed";
                          },
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text("Exit"),
                      onTap: () {
                        exit(0);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: Center(
          child: Container(
            child: Row(
              children: [],
            ),
          ),
        ));
  }
}
