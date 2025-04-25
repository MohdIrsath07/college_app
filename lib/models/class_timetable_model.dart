import 'package:cloud_firestore/cloud_firestore.dart';

class ClassTimetableModel {
  final String id;
  final String semester;
  final String section;
  final List<WeekdaySchedule> weekSchedule;

  ClassTimetableModel({
    required this.id,
    required this.semester,
    required this.section,
    required this.weekSchedule,
  });

  factory ClassTimetableModel.fromJson(Map<String, dynamic> json) {
    List<WeekdaySchedule> scheduleList = [];
    if (json['weekSchedule'] != null) {
      scheduleList = (json['weekSchedule'] as List)
          .map((day) => WeekdaySchedule.fromJson(day))
          .toList();
    }

    return ClassTimetableModel(
      id: json['id'] ?? '',
      semester: json['semester'] ?? '',
      section: json['section'] ?? '',
      weekSchedule: scheduleList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'semester': semester,
      'section': section,
      'weekSchedule': weekSchedule.map((day) => day.toJson()).toList(),
    };
  }
}

class WeekdaySchedule {
  final String id;
  final String weekday;
  final List<ClassSession> sessions;

  WeekdaySchedule({
    required this.id,
    required this.weekday,
    required this.sessions,
  });

  factory WeekdaySchedule.fromJson(Map<String, dynamic> json) {
    List<ClassSession> sessionsList = [];
    if (json['sessions'] != null) {
      sessionsList = (json['sessions'] as List)
          .map((session) => ClassSession.fromJson(session))
          .toList();
    }

    return WeekdaySchedule(
      id: json['id'] ?? '',
      weekday: json['weekday'] ?? '',
      sessions: sessionsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weekday': weekday,
      'sessions': sessions.map((session) => session.toJson()).toList(),
    };
  }
}

class ClassSession {
  final String id;
  final String subjectName;
  final String subjectCode;
  final String teacherName;
  final String startTime;
  final String endTime;
  final String roomNumber;

  ClassSession({
    required this.id,
    required this.subjectName,
    required this.subjectCode,
    required this.teacherName,
    required this.startTime,
    required this.endTime,
    required this.roomNumber,
  });

  factory ClassSession.fromJson(Map<String, dynamic> json) {
    return ClassSession(
      id: json['id'] ?? '',
      subjectName: json['subjectName'] ?? '',
      subjectCode: json['subjectCode'] ?? '',
      teacherName: json['teacherName'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      roomNumber: json['roomNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectName': subjectName,
      'subjectCode': subjectCode,
      'teacherName': teacherName,
      'startTime': startTime,
      'endTime': endTime,
      'roomNumber': roomNumber,
    };
  }
}