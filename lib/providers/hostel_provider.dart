import 'package:flutter/foundation.dart';
import 'package:college_app/models/hostel_menu_model.dart';
import 'package:college_app/services/firestore_service.dart';

class HostelProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  HostelMenuModel? _hostelMenu;
  bool _isLoading = false;
  String? _error;

  HostelMenuModel? get hostelMenu => _hostelMenu;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchHostelMenu(String hostelName) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final menuData = await _firestoreService.getHostelMenu(hostelName);
      _hostelMenu = menuData;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  DailyMenu? getTodayMenu() {
    if (_hostelMenu == null) return null;

    final today = DateTime.now().weekday;
    final weekdayNames = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];

    try {
      return _hostelMenu!.weekMenu.firstWhere(
            (menu) => menu.day == weekdayNames[today - 1],
      );
    } catch (e) {
      return null;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}