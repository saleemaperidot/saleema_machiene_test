import 'package:flutter/foundation.dart' show ChangeNotifier;

mixin CustomNotifierMixin on ChangeNotifier {
  @override
  void notifyListeners() {
    if (hasListeners) {
      super.notifyListeners();
    }
  }
}
