import 'package:stacked/stacked.dart';

class TabLayoutViewModel extends IndexTrackingViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  setIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
