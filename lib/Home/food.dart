import 'dart:async';



import 'package:covidhealthtechapp/Models/FoodModel.dart';
import 'package:covidhealthtechapp/widgets/foodSearchbox.dart';
import 'package:covidhealthtechapp/widgets/loadWidget.dart';
import 'package:covidhealthtechapp/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Food_page.dart';

double width;

class Food extends StatefulWidget {
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  DateTime backButtonPressed;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.amber),
          flexibleSpace: Container(
            decoration: new BoxDecoration(


              color: Colors.white,



            ),
          ),
          title: Text(
            "Dietary",
            style: TextStyle(fontSize: 55.0, color: Colors.amber, fontFamily: "Signatra"),
          ),
          centerTitle: true,

        ),
        drawer: MyDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("foods").limit(15).orderBy("publishedDate", descending: true).snapshots(),
              builder: (context, dataSnapshot)
              {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                    : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                  itemBuilder: (context, index)
                  {
                   ItemModel model = ItemModel.fromJson(dataSnapshot.data.documents[index].data);
                    return sourceInfo(model, context);
                  },
                  itemCount: dataSnapshot.data.documents.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: ()
    {
      Route route = MaterialPageRoute(builder: (c) => FoodPage(itemModel: model));
      Navigator.pushReplacement(context, route);
    },
    splashColor: Colors.amber,
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Container(
        height: 190.0,
        width: width,
        child: Row(
          children: [
            Image.network(model.thumbnailUrl, width: 140.0, height: 140.0,),
            SizedBox(width: 4.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0,),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(model.title, style: TextStyle(color: Colors.black, fontSize: 14.0),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(model.shortInfo, style: TextStyle(color: Colors.black54, fontSize: 12.0),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),




                  Flexible(
                    child: Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}



Widget card({Color primaryColor = Colors.amber, String imgPath}) {
  return Container(
    height: 150.0,
    width: width * .34,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(0, 5), blurRadius: 10.0, color: Colors.grey[200]),
        ]
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Image.network(
        imgPath,
        height: 150.0,
        width: width * .34,
        fit: BoxFit.fill,
      ),
    ),
  );
}