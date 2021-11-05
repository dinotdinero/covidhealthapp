import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HealthApp
{
  static const String appName = 'CovidHealthTech';

  static SharedPreferences sharedPreferences;
  static FirebaseUser user;
  static FirebaseAuth auth;
  static Firestore firestore ;

  static String collectionUser = "users";
  static String userCartList = 'userCart';
  static String userfoodCartList = 'fooduserCart';

  static final String userName = 'name';
  static final String userEmail = 'email';
  static final String userPhotoUrl = 'photoUrl';
  static final String userUID = 'uid';
  static final String userAvatarUrl = 'url';
  static final String userPassword= 'pass';



  static final String productID = 'productIDs';
  static final String isSuccess ='isSuccess';
  static final String foodID = 'FoodIDs';

  static final String adminName = 'sname';
  static final String adminEmail = 'semail';
  static final String adminPhotoUrl = 'sphotoUrl';
  static final String adminUID = 'suid';
  static final String adminAvatarUrl = 'surl';
  static final String adminPassword= 'spass';
  static String adminCartList = 'suserCart';

}