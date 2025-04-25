import 'package:flutter/foundation.dart';
import 'package:college_app/models/class_timetable_model.dart';
import 'package:college_app/models/exam_timetable_model.dart';
import 'package:college_app/services/firestore_service.dart';

class TimetableProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  ClassTimetableModel? _classTimetable;
  List<ExamTimetableModel> _examTimetables = [];
  bool _isLoadingClass = false;
  bool _isLoadingExam = false;
  String? _errorClass;
  String? _errorExam;

  ClassTimetableModel? get classTimetable => _classTimetable;
  List<ExamTimetableModel> get examTimetables => [..._examTimetables];
  bool get isLoadingClass => _isLoadingClass;
  bool get isLoadingExam => _isLoadingExam;
  String? get errorClass => _errorClass;
  String? get errorExam => _errorExam;

  Future<void> fetchClassTimetable(
      String studentId, String semester, String section) async {
    try {
      _isLoadingClass = true;
      _errorClass = null;
      notifyListeners();

      final timetableData = await _firestoreService.getClassTimetable(
          studentId, semester, section);
      _classTimetable = timetableData;

      _isLoadingClass = false;
      notifyListeners();
    } catch (e) {
      _isLoadingClass = false;
      _errorClass = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchExamTimetables(String studentId, String semester) async {
    try {
      _isLoadingExam = true;
      _errorExam = null;
      notifyListeners();

      final timetableData =
      await _firestoreService.getExamTimetables(studentId, semester);
      _examTimetables = timetableData;

      _isLoadingExam = false;
      notifyListeners();
    } catch (e) {
      _isLoadingExam = false;
      _errorExam = e.toString();
      notifyListeners();
    }
  }

  WeekdaySchedule? getTodaySchedule() {
    if (_classTimetable == null) return null;

    final today = DateTime.now().weekday;
    final weekdayNames = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];

    try {
      return _classTimetable!.weekSchedule.firstWhere(
            (schedule) => schedule.weekday == weekdayNames[today - 1],
      );
    } catch (e) {
      return null;
    }
  }

  List<ExamEntry> getUpcomingExams() {
    List<ExamEntry> upcomingExams = [];
    final now = DateTime.now();

    for (var timetable in _examTimetables) {
      for (var entry in timetable.entries) {
        if (entry.dateTime.isAfter(now)) {
          upcomingExams.add(entry);
        }
      }
    }

    // Sort by date
    upcomingExams.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return upcomingExams;
  }

  void clearErrors() {
    _errorClass = null;
    _errorExam = null;
    notifyListeners();
  }
}