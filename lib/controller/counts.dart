import 'package:flutter/cupertino.dart';

class Counts with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  double get area => _count * _count * 3.14;

  void add() {
    _count++;
    notifyListeners();
  }

  void remove() {
    _count--;
    notifyListeners();
  }

  void Circle() {
    print('반지름: ${count}'); // 반지름 출력
    print('넓이: ${area}'); // 넓이 출력
    notifyListeners();
  }
}