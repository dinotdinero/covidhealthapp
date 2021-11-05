import 'dart:async';

import 'package:covidhealthtechapp/Config/config.dart';
import 'package:covidhealthtechapp/counter/itemcounter.dart';
import 'package:covidhealthtechapp/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Exercise.dart';
import 'food.dart';








class HomeApp extends StatefulWidget {
  @override
  _Homestate createState() => _Homestate();
}

class _Homestate extends State<HomeApp> {
  DateTime backButtonPressed;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.amber),
          flexibleSpace: Container(
            decoration: new BoxDecoration(


              color: Colors.white,



            ),
          ),
          title: Text(
            "CovidHealthTech",
            style: TextStyle(fontSize: 50,color: Colors.amber,fontFamily: "Signatra"),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [

                Positioned(
                  child:
                  Stack(
                      children:[
                        Icon(
                          Icons.brightness_1,
                          size: 18,
                          color: Colors.white,
                        ),
                        Positioned(
                          top: 3.0,
                          bottom: 4.0 ,
                          left: 4.0,
                          child: Consumer<CartItemCounter>(
                            builder: (context, counter, _)
                            {
                              return Text(
                                (HealthApp.sharedPreferences.getStringList(HealthApp.userCartList).length-1).toString(),
                                style: TextStyle(color: Colors.amber, fontSize: 12.0, fontWeight: FontWeight.bold),
                              );
                            },

                          ),

                        ),

                      ]
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer:
        MyDrawer(),
        body:


             Column(
            children: [
              Text (
                "Keep calm and carry on." "The only thing we have to fear is fear itself." "Don't worry, be happy.",
                style: TextStyle(color: Colors.amber, fontSize: 18.0, fontWeight: FontWeight.bold),),
              Divider(height:10.0, color: Colors.amber,thickness: 2.0,),

              Text (
                "Normal Body Temperature",
                style: TextStyle(color: Colors.amber, fontSize: 12.0, fontWeight: FontWeight.bold),),

              Text (
                "Babies and children. In babies and children, the average body temperature ranges from 97.9°F (36.6°C) to 99°F (37.2°C).",
                style: TextStyle(color: Colors.amber, fontSize: 12.0, fontWeight: FontWeight.bold),),
              Text (
                "Adults. Among adults, the average body temperature ranges from 97°F (36.1°C) to 99°F (37.2°C).",
                style: TextStyle(color: Colors.amber, fontSize: 12.0, fontWeight: FontWeight.bold),),

              Text (
                "Adults over age 65. In older adults, the average body temperature is lower than 98.6°F (37°C).",
                style: TextStyle(color: Colors.amber, fontSize: 12.0, fontWeight: FontWeight.bold),),
              Divider(height:10.0, color: Colors.amber,thickness: 2.0,),
              Text (
                "blood oxygen level",
                style: TextStyle(color: Colors.amber, fontSize: 12.0, fontWeight: FontWeight.bold),),

              Text (
                "95 to 100 percent is considered normal.",
                style: TextStyle(color: Colors.amber, fontSize: 12.0, fontWeight: FontWeight.bold),),

              Text (
                "If oxygen levels are below 88 percent, that is a cause for concern",
                style: TextStyle(color: Colors.amber, fontSize: 12.0, fontWeight: FontWeight.bold),),
              Divider(height:10.0, color: Colors.amber,thickness: 2.0,),
              Text (
                "Pulse rate",
                style: TextStyle(color: Colors.amber, fontSize: 12.0, fontWeight: FontWeight.bold),),

              Text (
                "The normal pulse for healthy adults ranges from 60 to 100 beats per minute. The pulse rate may fluctuate and increase with exercise, illness, injury, and emotions. Females ages 12 and older, in general, tend to have faster heart rates than do males. Athletes, such as runners, who do a lot of cardiovascular conditioning, may have heart rates near 40 beats per minute and experience no problems.",
                style: TextStyle(color: Colors.amber, fontSize: 12.0, fontWeight: FontWeight.bold),),






            ]
            ),

      ),

    );
  }
}
