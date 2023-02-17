import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_test_app/connectivity_bloc/internet_bloc.dart';
import 'package:simple_test_app/connectivity_bloc/internet_state.dart';
import 'package:simple_test_app/presentation/app/view/app_page.dart';
import 'package:simple_test_app/presentation/splashscreen/splashscreen.dart';

class Myhome extends StatefulWidget {
  Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: Text('Flutter RouteAware '),
          centerTitle: true,
        ),
        body: Center(
            child: BlocConsumer<InternetBloc, InternetState>(
                builder: (context, state) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/pic.webp',
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(fontSize: 20),
                                  minimumSize: Size.fromHeight(40),
                                ),
                                onPressed: () async {
                                  var sharedpref =
                                      await SharedPreferences.getInstance();
                                  sharedpref.setBool(
                                      SplashScreen.keylogin, true);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SimpleApp(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Let's Go",
                                )),
                          ],
                        ),
                      ),
                    ),
                listener: (context, state) {
                  if (state is InternetGainedState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Internet Connected"),
                      backgroundColor: Colors.green,
                    ));
                  } else if (state is InternetLostState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Internet Not Connected"),
                      backgroundColor: Colors.red,
                    ));
                  }
                })));
  }
}
