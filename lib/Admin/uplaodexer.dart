import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidhealthtechapp/widgets/admindrawer.dart';
import 'package:covidhealthtechapp/widgets/loadWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';




class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  File file;
  TextEditingController _descriptionTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _shortInfoTextEditingController = TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return file == null ? displayAdminHomeScreen() : displayAdminUploadFormScreen();
  }

  displayAdminHomeScreen()
  {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        flexibleSpace: Container(
          decoration: new BoxDecoration(


            color: Colors.white,



          ),
        ),
        title: Text(
          " CovidHeathTech",
          style: TextStyle(fontSize: 50,color: Colors.amber,fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
      drawer:
      adminDrawer(),
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody()
  {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, color: Colors.amber, size: 200.0,),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
                child: Text("Add New Items", style: TextStyle(fontSize: 20.0, color: Colors.amber),),
                color: Colors.white,
                onPressed: ()=> takeImage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  takeImage(mContext)
  {
    return showDialog(
        context: mContext,
        builder: (con)
        {
          return SimpleDialog(
            title: Text("Item Image", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),),
            children: [
              SimpleDialogOption(
                child: Text("Capture with Camera", style: TextStyle(color: Colors.amber,)),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: Text("Select from Gallery", style: TextStyle(color: Colors.amber,)),
                onPressed: pickPhotoFromGallery,
              ),
              SimpleDialogOption(
                child: Text("Cancel", style: TextStyle(color: Colors.amber,)),
                onPressed: ()
                {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

  capturePhotoWithCamera() async
  {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);

    setState(() {
      file = imageFile;
    });
  }

  pickPhotoFromGallery() async
  {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,);

    setState(() {
      file = imageFile;
    });
  }

  displayAdminUploadFormScreen()
  {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
           color: Colors.white,
          ),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.amber,), onPressed: clearFormInfo),
        title: Text("New Product", style: TextStyle(color: Colors.amber, fontSize: 24.0, fontWeight: FontWeight.bold,),),
        actions: [
          FlatButton(
            onPressed: uploading ? null : ()=> uploadImageAndSaveItemInfo(),
            child: Text("Add", style: TextStyle(color: Colors.amber, fontSize: 16.0, fontWeight: FontWeight.bold,),),
          ),
        ],
      ),
      body: ListView(
        children: [
          uploading ? circularProgress() : Text(""),
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(image: DecorationImage(image: FileImage(file), fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12.0)),

          ListTile(
            leading: Icon(Icons.perm_device_information, color: Colors.amber,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.amber),
                controller: _shortInfoTextEditingController,
                decoration: InputDecoration(
                  hintText: "Short Info",
                  hintStyle: TextStyle(color: Colors.amber),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: Colors.amber,),

          ListTile(
            leading: Icon(Icons.perm_device_information, color: Colors.amber,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.amber),
                controller: _titleTextEditingController,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.amber),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: Colors.amber,),

          ListTile(
            leading: Icon(Icons.perm_device_information, color: Colors.amber,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.amber),
                controller: _descriptionTextEditingController,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.amber),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: Colors.amber,),


        ],
      ),
    );
  }

  clearFormInfo()
  {
    setState(() {
      file = null;
      _descriptionTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _titleTextEditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async
  {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadItemImage(file);

    saveItemInfo(imageDownloadUrl);
  }

  Future<String> uploadItemImage(mFileImage) async
  {
    final StorageReference storageReference = FirebaseStorage.instance.ref().child("Items");
    StorageUploadTask uploadTask = storageReference.child("product_$productId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downloadUrl)
  {
    final itemsRef = Firestore.instance.collection("items");
    itemsRef.document(productId).setData({
      "shortInfo": _shortInfoTextEditingController.text.trim(),
      "longDescription": _descriptionTextEditingController.text.trim(),
      "publishedDate": DateTime.now(),
      "thumbnailUrl": downloadUrl,
      "title": _titleTextEditingController.text.trim(),
    });

    setState(() {
      file = null;
      uploading = false;
      productId = DateTime.now().millisecondsSinceEpoch.toString();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _shortInfoTextEditingController.clear();
    });
  }
}
