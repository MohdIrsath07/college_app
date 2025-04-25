import 'package:flutter/foundation.dart';
import 'package:college_app/models/attendance_model.dart';
import 'package:college_app/services/firestore_service.dart';

class AttendanceProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<AttendanceModel> _attendanceList = [];
  bool _isLoading = false;
  String? _error;
  double _overallAttendancePercentage = 0.0;

  List<AttendanceModel> get attendanceList => [..._attendanceList];
  bool get isLoading => _isLoading;
  String? get error => _error;
  double get overallAttendancePercentage => _overallAttendancePercentage;

  Future<void> fetchStudentAttendance(String studentId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final attendanceData = await _firestoreService.getStudentAttendance(studentId);
      _attendanceList = attendanceData;

      // Calculate overall attendance percentage
      if (_attendanceList.isNotEmpty) {
        int totalClasses = 0;
        int totalAttended = 0;

        for (var attendance in _attendanceList) {
          totalClasses += attendance.totalClasses;
          totalAttended += attendance.attendedClasses;
        }

        _overallAttendancePercentage = (totalAttended / totalClasses) * 100;
      } else {
        _overallAttendancePercentage = 0.0;
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  AttendanceModel? getAttendanceBySubject(String subjectId) {
    try {
      return _attendanceList.firstWhere((attendance) => attendance.subjectId == subjectId);
    } catch (e) {
      return null;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}