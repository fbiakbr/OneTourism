import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Widget> _cardList = [];

  void searchData() {
    var url = Uri.parse("http://54.169.198.245:5050/destination/search/" +
        _searchController.text);
    http.get(url).then((response) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _cardList = [];
        for (var i = 0; i < data['data'].length; i++) {
          _cardList.add(SingleChildScrollView(
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        id: data['data'][i]['_id'],
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage("assets/bg.jpg"),
                        fit: BoxFit.cover,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['data'][i]['name'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          // show description but limit to 100 characters
                          data['data'][i]['description'].toString().length > 100
                              ? data['data'][i]['description'].toString()
                                      .substring(0, 100) +
                                  "..."
                              : data['data'][i]['description'].toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: searchData,
                child: Text("Search"),
              ),
            ),
            Expanded(
              child: ListView(
                children: _cardList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
