import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'OneTourism',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Welcome back, you\'ve been missed!',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // make button with rounded corners
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.indigo,
              ),
              child: Center(
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: double.infinity,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                ' Sign Up',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    )));
  }
}
