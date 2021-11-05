
import 'package:covidhealthtechapp/Admin/uplaodexer.dart';
import 'package:covidhealthtechapp/Admin/uploadfood.dart';
import 'package:covidhealthtechapp/Authen/authentication.dart';
import 'package:covidhealthtechapp/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class adminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  ;
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
                    leading: Icon(Icons.fitness_center, color: Colors.amber,),
                    title: Text("Upload Exercise",style: TextStyle(color: Colors.amber),),
                    onTap: (){
                      Route route = MaterialPageRoute(builder: (_) => UploadPage());
                      Navigator.pushReplacement(context, route);
                    }
                ),
                Divider(height:10.0, color: Colors.amber,thickness: 4.0,),
                ListTile(
                    leading: Icon(Icons.fastfood, color: Colors.amber,),
                    title: Text("Upload Food",style: TextStyle(color: Colors.amber),),
                    onTap: (){
                      Route route = MaterialPageRoute(builder: (_) => UploadFood());
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
