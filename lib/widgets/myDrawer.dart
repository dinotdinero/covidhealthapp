

import 'package:covidhealthtechapp/Authen/authentication.dart';
import 'package:covidhealthtechapp/Config/config.dart';
import 'package:covidhealthtechapp/Home/Exercise.dart';
import 'package:covidhealthtechapp/Home/Homemenu.dart';
import 'package:covidhealthtechapp/Home/food.dart';
import 'package:covidhealthtechapp/Home/ttodo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
      children: [
        Container(
          padding: EdgeInsets.only(top:25.0, bottom:10.0),
          decoration: new BoxDecoration(


            color: Colors.white,



          ),
          child: Column(
            children: [
              Material(
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
                elevation: 8.0,
                child: Container(
                  height: 160.0,
                  width: 160.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      HealthApp.sharedPreferences.getString(HealthApp.userAvatarUrl),

                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                HealthApp.sharedPreferences.getString(HealthApp.userName),
                style: TextStyle(color: Colors.amber, fontSize: 33.0, fontFamily: "Signatra"),
              )
            ],
          ),
        ),

        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 1,),


          child: Column(

            children:[
              ListTile(
                leading: Icon(Icons.home, color: Colors.amber,),
                title: Text("Home",style: TextStyle(color: Colors.amber),),
                onTap: (){
                  Route route = MaterialPageRoute(builder: (_) => HomeApp());
                  Navigator.pushReplacement(context, route);
                }
              ),
              Divider(height:10.0, color: Colors.amber,thickness: 4.0,),
              ListTile(
                  leading: Icon(Icons.note, color: Colors.amber,),
                  title: Text("Reminder/Diary",style: TextStyle(color: Colors.amber),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (_) => TodoApp());
                    Navigator.pushReplacement(context, route);
                  }
              ),
              Divider(height:10.0, color: Colors.amber,thickness: 4.0,),
              ListTile(
                  leading: Icon(Icons.fitness_center, color: Colors.amber,),
                  title: Text("Exercise",style: TextStyle(color: Colors.amber),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (_) => Exercise());
                    Navigator.pushReplacement(context, route);
                  }
              ),
              Divider(height:10.0, color: Colors.amber,thickness: 4.0,),
              ListTile(
                  leading: Icon(Icons.food_bank, color: Colors.amber,),
                  title: Text("Dietary Menu",style: TextStyle(color: Colors.amber),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (_) => Food());
                    Navigator.pushReplacement(context, route);
                  }
              ),
              Divider(height:10.0, color: Colors.amber,thickness: 4.0,),
              ListTile(
                  leading: Icon(Icons.logout, color: Colors.amber,),
                  title: Text("Logout",style: TextStyle(color: Colors.amber),),
                  onTap: (){
                    HealthApp.auth.signOut().then((c)
                   {
                     Route route = MaterialPageRoute(builder: (_) => AuthenticScreen());
                     Navigator.pushReplacement(context, route);
                   }
                   );
                  }
              ),
              Divider(height:10.0, color: Colors.amber,thickness: 4.0,),


              SizedBox(height: 100,),
            ],
          ),

        )
      ],

      ),
    );
  }
}
