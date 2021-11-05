
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidhealthtechapp/Admin/uploadfood.dart';
import 'package:covidhealthtechapp/Authen/authentication.dart';
import 'package:covidhealthtechapp/Authen/login.dart';
import 'package:covidhealthtechapp/Dialog/ErroDial.dart';
import 'package:covidhealthtechapp/widgets/customT.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';





class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        flexibleSpace: Container(
          decoration: new BoxDecoration(


            color: Colors.white,



          ),
        ),

        title: Text(
          "CovidHealthTech",
          style: TextStyle(fontSize: 50,color: Colors.amber,fontFamily: "Signatra",),
        ),
        centerTitle: true,

      ),
      body: AdminSignInScreen(),
    );
  }
}


class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen>
{
  final TextEditingController _adminIDTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width,
        _screenHeight = MediaQuery
            .of(context)
            .size
            .height;
    return SingleChildScrollView(
      child: Container(
      child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
      Container(
      alignment: Alignment.bottomCenter,
      child: Image.asset("images/login2.png",
        height: 240,
        width: 240,),

    ),
    Padding(padding: EdgeInsets.all(5.0),
    child: Text(
    "Login To Your Admin Account",
    style: TextStyle(color: Colors.amber,),

    ),
    ),
    Form(
    key: _formkey,
    child: Column(
    children: [

    CustomTextField(

    contr: _adminIDTextEditingController,
    image: Icons.email,
    hintT: "Username",
    iso: false,


    ),
    CustomTextField(
    contr: _passwordTextEditingController,
    image: Icons.person,
    hintT: "Password",
    iso: true,



    ),

    ],
    ),
    ),
    SizedBox(
    height: 30.0,
    ),

    SizedBox(
    height: 15.0,
    ),
    RaisedButton(
    onPressed: () {
    _adminIDTextEditingController.text.isNotEmpty
    && _passwordTextEditingController.text.isNotEmpty
    ? loginAdmin()
        : showDialog(
    context: context,
    builder: (c) {
    return ErrorAlertDialog(
    message: "Please write email and password",);
    }
    );
    },

    color: Colors.amber,
    child: Text("Login", style: TextStyle(color: Colors.white,),
    ),
    ),
        SizedBox(
          height: 30.0,
        ),

        FlatButton.icon(
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AuthenticScreen())),
          icon: (Icon(Icons.nature_people, color: Colors.amber)),
          label: Text("Not an Admin", style: TextStyle(
              color: Colors.amber, fontWeight: FontWeight.bold,),),
        ),
      ],
    ),

    ),

    );
  }
  loginAdmin()
  {
    Firestore.instance.collection("admins").getDocuments().then((snapshot){
      snapshot.documents.forEach((result) {
        if (result.data["username"] != _adminIDTextEditingController.text.trim()){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Username is incorrect"),));
        }
        else if (result.data["password"] != _passwordTextEditingController.text.trim()){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Password is incorrect"),));
        }
        else{
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Welcome Dear Admin," + result.data["name"]),));
        }
        setState(() {
          _adminIDTextEditingController.text = "";
          _passwordTextEditingController.text = "";
        });
        Route route = MaterialPageRoute(builder: (c) => UploadFood());
        Navigator.pushReplacement(context, route);
      });
    });
  }
  }

