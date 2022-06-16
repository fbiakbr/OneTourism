import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onetourism/home.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _ratingController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  void addData() {
    var url = Uri.parse("http://54.169.198.245:5050/destination");

    http.post(url, body: {
      "name": _nameController.text,
      "price": _priceController.text,
      "rating": _ratingController.text,
      "description": _descriptionController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                child: Text("Add", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  addData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
