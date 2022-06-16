import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'home.dart';
import 'edit.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  DetailsPage({Key key, this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<List> getData() async {
    final response = await http.get(
      Uri.parse("http://54.169.198.245:5050/destination/" + widget.id),
    );
    Map<String, dynamic> data = json.decode(response.body);
    return data['data'];
  }

  // make delete function with argument id
  void deleteData(String id) async {
    final response = await http.delete(
      Uri.parse("http://54.169.198.245:5050/destination/" + widget.id),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Destination Details"),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      // return card for each destination
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 200,
                            width: 340,
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
                                  snapshot.data[i]['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // show rating with stars icon
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.indigo,
                                  size: 30,
                                ),
                                Container(
                                  margin: EdgeInsets.all(6),
                                  child: Text(
                                    snapshot.data[i]['rating'].toString(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 18),
                                child: Text(
                                  'Price : Rp. ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  snapshot.data[i]['price']
                                      .toString()
                                      .replaceAllMapped(
                                          new RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]}.'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(18),
                            child: Text(
                              'Description : \n \n' +
                                  snapshot.data[i]['description'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // make button to book
                          Row(
                            // make 2 buttons to book
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: RaisedButton(
                                  color: Colors.indigo,
                                  child: Text(
                                    'EDIT',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditPage(
                                            id: snapshot.data[i]['_id']),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: RaisedButton(
                                  color: Colors.red,
                                  child: Text(
                                    'DELETE',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    // show dialog to confirm delete
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Delete Destination'),
                                          content: Text(
                                              'Are you sure you want to delete this destination?'),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: Text('Delete'),
                                              onPressed: () {
                                                deleteData(
                                                    snapshot.data[i]['id']
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
