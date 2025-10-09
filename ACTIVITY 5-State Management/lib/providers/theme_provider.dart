import 'package:flutter/foundation.dart';

// COMPONENT 4: Theme switcher (dark/light mode) using Provider
// COMPONENT 2: ChangeNotifier to update UI when theme changes
class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // COMPONENT 4: Toggle theme
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    // COMPONENT 2: Notify listeners to update UI
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    // COMPONENT 2: Notify listeners to update UI
    notifyListeners();
  }
}
