import 'package:cloud_firestore/cloud_firestore.dart';

class StudyMaterialModel {
  final String id;
  final String title;
  final String description;
  final String subjectCode;
  final String subjectName;
  final DateTime uploadDate;
  final String uploadedBy;
  final String fileUrl;
  final String fileType;
  final int fileSize; // in KB

  StudyMaterialModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subjectCode,
    required this.subjectName,
    required this.uploadDate,
    required this.uploadedBy,
    required this.fileUrl,
    required this.fileType,
    required this.fileSize,
  });

  factory StudyMaterialModel.fromJson(Map<String, dynamic> json) {
    return StudyMaterialModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      subjectCode: json['subjectCode'] ?? '',
      subjectName: json['subjectName'] ?? '',
      uploadDate: json['uploadDate'] != null
          ? (json['uploadDate'] as Timestamp).toDate()
          : DateTime.now(),
      uploadedBy: json['uploadedBy'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      fileType: json['fileType'] ?? '',
      fileSize: json['fileSize'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subjectCode': subjectCode,
      'subjectName': subjectName,
      'uploadDate': uploadDate,
      'uploadedBy': uploadedBy,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'fileSize': fileSize,
    };
  }
}