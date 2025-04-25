import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String id;
  final String subjectId;
  final String subjectName;
  final int totalClasses;
  final int attendedClasses;
  final double attendancePercentage;
  final List<AttendanceRecord> records;

  AttendanceModel({
    required this.id,
    required this.subjectId,
    required this.subjectName,
    required this.totalClasses,
    required this.attendedClasses,
    required this.attendancePercentage,
    required this.records,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    List<AttendanceRecord> recordsList = [];
    if (json['records'] != null) {
      recordsList = (json['records'] as List)
          .map((record) => AttendanceRecord.fromJson(record))
          .toList();
    }

    return AttendanceModel(
      id: json['id'] ?? '',
      subjectId: json['subjectId'] ?? '',
      subjectName: json['subjectName'] ?? '',
      totalClasses: json['totalClasses'] ?? 0,
      attendedClasses: json['attendedClasses'] ?? 0,
      attendancePercentage: json['attendancePercentage'] ?? 0.0,
      records: recordsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectId': subjectId,
      'subjectName': subjectName,
      'totalClasses': totalClasses,
      'attendedClasses': attendedClasses,
      'attendancePercentage': attendancePercentage,
      'records': records.map((record) => record.toJson()).toList(),
    };
  }
}

class AttendanceRecord {
  final String id;
  final DateTime date;
  final bool present;

  AttendanceRecord({
    required this.id,
    required this.date,
    required this.present,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'] ?? '',
      date: json['date'] != null
          ? (json['date'] as Timestamp).toDate()
          : DateTime.now(),
      present: json['present'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'present': present,
    };
  }
}