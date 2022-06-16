import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'details.dart';

class DestinationsPage extends StatefulWidget {
  const DestinationsPage({Key key}) : super(key: key);

  @override
  State<DestinationsPage> createState() => _DestinationsPageState();
}

class _DestinationsPageState extends State<DestinationsPage> {
  Future<List> getData() async {
    final response = await http.get(
      Uri.parse("http://54.169.198.245:5050/destination"),
    );
    Map<String, dynamic> data = json.decode(response.body);
    return data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      return Container(
                          child: GestureDetector(
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
                                snapshot.data[i]['name'],
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
                                  snapshot.data[i]['description'].length > 100
                                      ? snapshot.data[i]['description'].substring(0, 100) + "..."
                                      : snapshot.data[i]['description'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          // navigate to details page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                id: snapshot.data[i]['_id'],
                              ),
                            ),
                          );
                        },
                      ));
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
