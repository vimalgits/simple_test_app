import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_test_app/presentation/app/view/app_page.dart';

import '../../splashscreen/splashscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                var sharedpref = await SharedPreferences.getInstance();
                sharedpref.setBool(SplashScreen.keylogin, false);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SimpleApp(),
                  ),
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Profile Details"),
                    content: FutureBuilder<dynamic>(
                      future: getdata(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Text('Loading....');
                          default:
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            else
                              return Text('${snapshot.data.toString()}');
                        }
                      },
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("Ok"),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }

  Future<dynamic> getdata() async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc("g0S6U7FGHIOCad8DCSXL")
          .get();
      return snapshot.data().toString();
      //print(snapshot.data().toString());
    } catch (e) {
      print("error is: " + e.toString());
    }
  }
}
