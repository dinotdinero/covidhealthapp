
import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidhealthtechapp/Config/config.dart';
import 'package:covidhealthtechapp/Dialog/ErroDial.dart';
import 'package:covidhealthtechapp/Dialog/alertDial.dart';
import 'package:covidhealthtechapp/Home/Homemenu.dart';
import 'package:covidhealthtechapp/widgets/customT.dart';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register> {
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final TextEditingController _confirmpTextEditingController = TextEditingController();
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _iFile;

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
            InkWell(
              onTap: () => _selectImage(),
              child: CircleAvatar(
                radius: _screenWidth * 0.15,
                backgroundColor: Colors.white,
                backgroundImage: _iFile == null ? null : FileImage(_iFile),
                child: _iFile == null
                    ? Icon(Icons.add_photo_alternate, size: _screenWidth * 0.15,
                  color: Colors.grey,) :
                null,
              ),
            ),
            SizedBox(height: 0.0),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    contr: _nameTextEditingController,
                    image: Icons.person,
                    hintT: "Name",
                    iso:  false,


                  ),
                  CustomTextField(
                    contr: _emailTextEditingController,
                    image: Icons.email,
                    hintT: "E-mail",
                    iso:  false,


                  ),
                  CustomTextField(
                    contr: _passwordTextEditingController,
                    image: Icons.person,
                    hintT: "Password",
                    iso:  true,


                  ),
                  CustomTextField(
                    contr: _confirmpTextEditingController,
                    image: Icons.person,
                    hintT: "Confirm Password",
                    iso:  true,


                  ),
                ],
              ),
            ),
            RaisedButton(
                onPressed: () {uploadAndSave();},
              color: Colors.amber,
              child: Text("Sign Up", style: TextStyle(color: Colors.white,),),
            ),
            SizedBox(
              height: 30.0,
            ),

            SizedBox(
              height: 15.0,
            ),



          ],
        ),
      ),

    );

  }
  Future<void >_selectImage() async
  {
    _iFile = await ImagePicker.pickImage(source:ImageSource.gallery);

  }

 Future<void> uploadAndSave() async
 {
   if (_iFile == null) {
      showDialog(context: context,
      builder: (c)
      {
        return ErrorAlertDialog(message: "Please select an image");
      });
   }
   else{
     _passwordTextEditingController.text == _confirmpTextEditingController.text
         ? _emailTextEditingController.text.isNotEmpty &&
         _passwordTextEditingController.text.isNotEmpty &&
         _confirmpTextEditingController.text.isNotEmpty &&
         _nameTextEditingController.text.isNotEmpty

         ?uploadToStor()
         : displayDialog("Please fill up the required form")
         
         :displayDialog("Password do not match");
   }
 }
 displayDialog(String msg)
 {
 showDialog( context: context,
   builder: (c)
   {
   return ErrorAlertDialog(message:msg,);
   });
 }
 uploadToStor()async {
   showDialog(context: context,
       builder: (c) {
         return LoadingAlertDialog(message: "Authenticating, please wait",);
       });
   String imageFileName = DateTime
       .now()
       .millisecondsSinceEpoch
       .toString();

   StorageReference storageReference = FirebaseStorage.instance.ref().child(
       imageFileName);
   StorageUploadTask storageUploadTask = storageReference.putFile(_iFile);
   StorageTaskSnapshot taskSnap = await storageUploadTask.onComplete;
   await taskSnap.ref.getDownloadURL().then((urlIm) {
     userImageUrl = urlIm;

     _registerUser();
   });
 }
   FirebaseAuth _auth = FirebaseAuth.instance;
   void _registerUser() async{
     FirebaseUser firebaseUser;

      await _auth.createUserWithEmailAndPassword
     (
     email: _emailTextEditingController.text.trim(),
       password: _passwordTextEditingController.text.trim(),


     ).then((auth){
        firebaseUser = auth.user;

     }).catchError((error)
     {
       Navigator.pop(context);
       showDialog(
           context: context,
           builder: (c) {
             return ErrorAlertDialog(message: error.message.toString(),);
           }
       );
     });
      if (firebaseUser != null)
        {
          saveUserInfoToFireStore(firebaseUser).then((value)
          {
            Navigator.pop(context);
            Route route = MaterialPageRoute(builder: (c) => HomeApp());
            Navigator.pushReplacement(context, route);
          });
        }
   }
  Future saveUserInfoToFireStore(FirebaseUser fUser) async
  {
    Firestore.instance.collection("users").document(fUser.uid).setData({
      "uid": fUser.uid,
      "name": _nameTextEditingController.text.trim(),
      "password"
      "email": fUser.email,
      "url": userImageUrl,


      HealthApp.userCartList: ["garbageValue"],
    });
    await HealthApp.sharedPreferences.setString(HealthApp.userUID, fUser.uid);
    await HealthApp.sharedPreferences.setString(HealthApp.userEmail, fUser.email);
    await HealthApp.sharedPreferences.setString(HealthApp.userName, _nameTextEditingController.text);
    await HealthApp.sharedPreferences.setString(HealthApp.userAvatarUrl,userImageUrl);
    await HealthApp.sharedPreferences.setStringList(HealthApp.userCartList,["garbageValue"]);

  }
}






