import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:onetourism/home.dart';

class EditPage extends StatefulWidget {
  final String id;
  EditPage({Key key, this.id}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _nameController;
  TextEditingController _priceController;
  TextEditingController _ratingController;
  TextEditingController _descriptionController;
  
  // get data from edit button
  Future<List> getData() async {
    final response = await http.get(
      Uri.parse("http://54.169.198.245:5050/destination/" + widget.id),
    );
    Map<String, dynamic> data = json.decode(response.body);
    return data['data'];
  }

  @override
  // fill text fields with data from edit button
  void initState() {
    super.initState();
    getData().then((data) {
      setState(() {
        _nameController = TextEditingController(text: data[0]['name']);
        _priceController = TextEditingController(text: data[0]['price'].toString());
        _ratingController = TextEditingController(text: data[0]['rating'].toString());
        _descriptionController = TextEditingController(text: data[0]['description'].toString());
      });
    });
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      // fill text fields with data from edit button
      appBar: AppBar(
        title: Text("Edit Destination"),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: "Price",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: _ratingController,
                          decoration: InputDecoration(
                            labelText: "Rating",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          maxLines: 8,
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          color: Colors.indigo,
                          child: Text("Edit", style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            // edit data
                            http.put(
                              Uri.parse("http://54.169.198.245:5050/destination/"+ widget.id),
                              body: {
                                'name': _nameController.text,
                                'price': _priceController.text,
                                'rating': _ratingController.text,
                                'description': _descriptionController.text,
                              },
                            ).then((response) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}