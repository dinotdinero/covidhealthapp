
import 'package:covidhealthtechapp/Config/config.dart';
import 'package:flutter/foundation.dart';


class FoodCounter extends ChangeNotifier
{
  int _foodcounter = HealthApp.sharedPreferences.getStringList(HealthApp.userfoodCartList).length-1;
  int get count => _foodcounter;

  Future<void> displayResult() async
  {
    int _foodcounter = HealthApp.sharedPreferences.getStringList(HealthApp.userfoodCartList).length-1;

    await Future.delayed(const Duration(milliseconds: 100), (){
      notifyListeners();
    });
  }
}