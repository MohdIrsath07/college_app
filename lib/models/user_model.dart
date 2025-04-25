class UserModel {
  final String uid;
  final String name;
  final String email;
  final String department;
  final DateTime dateOfBirth;
  final String? profileImageUrl;
  final String studentId;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.department,
    required this.dateOfBirth,
    this.profileImageUrl,
    required this.studentId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? '',
      dateOfBirth: json['dateOfBirth'] != null
          ? (json['dateOfBirth'] as Timestamp).toDate()
          : DateTime.now(),
      profileImageUrl: json['profileImageUrl'],
      studentId: json['studentId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'department': department,
      'dateOfBirth': dateOfBirth,
      'profileImageUrl': profileImageUrl,
      'studentId': studentId,
    };
  }
}

// Add this import at the top of the file
import 'package:cloud_firestore/cloud_firestore.dart';