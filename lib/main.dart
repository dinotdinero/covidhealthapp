import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authen/authentication.dart';
import 'Config/config.dart';
import 'Home/Homemenu.dart';
import 'counter/ItemQuantity.dart';
import 'counter/foodQuantity.dart';
import 'counter/fooditemcounter.dart';
import 'counter/itemcounter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HealthApp.auth = FirebaseAuth.instance;
  HealthApp.sharedPreferences = await SharedPreferences.getInstance();
  HealthApp.firestore = Firestore.instance;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers:[
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => ItemQuantity()),
        ChangeNotifierProvider(create: (c) => foodQuantity()),
        ChangeNotifierProvider(create: (c) => FoodCounter()),
      ],



      child: MaterialApp(
          title: '',
          debugShowCheckedModeBanner: false,


          theme: ThemeData(

            primarySwatch: Colors.green,

          ),

          home: SplashScreen()
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class  _SplashScreenState extends State<SplashScreen> {


  void initState() {
    super.initState();

    displaySplash();
  }

  displaySplash() {
    Timer(Duration(seconds: 5), () async {

      if (await HealthApp.auth.currentUser() != null) {
        Route route = MaterialPageRoute(builder: (_) => HomeApp());
        Navigator.pushReplacement(context, route);
      }
      else {
        Route route = MaterialPageRoute(builder: (_) => AuthenticScreen());
        Navigator.pushReplacement(context, route);
      }

    });
  }







  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.


        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
            child:Container(
              decoration: new BoxDecoration(
                color: Colors.white,


              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/well.png"),
                    SizedBox(height: 20.0,),
                    Text(" ")
                  ],
                ),

              ),
            )


        )
    );
  }
}
