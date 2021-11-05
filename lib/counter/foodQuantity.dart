import 'package:flutter/foundation.dart';

class foodQuantity with ChangeNotifier {
  int _numberOffoods = 0;

  int get numberOfItems => _numberOffoods;

  display(int no)
  {
    _numberOffoods = no;
    notifyListeners();
  }
}

