import 'package:cloud_firestore/cloud_firestore.dart';

class ExamTimetableModel {
  final String id;
  final String examName;
  final DateTime startDate;
  final DateTime endDate;
  final List<ExamEntry> entries;

  ExamTimetableModel({
    required this.id,
    required this.examName,
    required this.startDate,
    required this.endDate,
    required this.entries,
  });

  factory ExamTimetableModel.fromJson(Map<String, dynamic> json) {
    List<ExamEntry> entriesList = [];
    if (json['entries'] != null) {
      entriesList = (json['entries'] as List)
          .map((entry) => ExamEntry.fromJson(entry))
          .toList();
    }

    return ExamTimetableModel(
      id: json['id'] ?? '',
      examName: json['examName'] ?? '',
      startDate: json['startDate'] != null
          ? (json['startDate'] as Timestamp).toDate()
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? (json['endDate'] as Timestamp).toDate()
          : DateTime.now(),
      entries: entriesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'examName': examName,
      'startDate': startDate,
      'endDate': endDate,
      'entries': entries.map((entry) => entry.toJson()).toList(),
    };
  }
}

class ExamEntry {
  final String id;
  final String subjectName;
  final String subjectCode;
  final DateTime dateTime;
  final String venue;
  final int duration; // in minutes

  ExamEntry({
    required this.id,
    required this.subjectName,
    required this.subjectCode,
    required this.dateTime,
    required this.venue,
    required this.duration,
  });

  factory ExamEntry.fromJson(Map<String, dynamic> json) {
    return ExamEntry(
      id: json['id'] ?? '',
      subjectName: json['subjectName'] ?? '',
      subjectCode: json['subjectCode'] ?? '',
      dateTime: json['dateTime'] != null
          ? (json['dateTime'] as Timestamp).toDate()
          : DateTime.now(),
      venue: json['venue'] ?? '',
      duration: json['duration'] ?? 120,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectName': subjectName,
      'subjectCode': subjectCode,
      'dateTime': dateTime,
      'venue': venue,
      'duration': duration,
    };
  }
}