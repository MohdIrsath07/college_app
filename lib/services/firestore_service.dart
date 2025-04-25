import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_app/models/attendance_model.dart';
import 'package:college_app/models/class_timetable_model.dart';
import 'package:college_app/models/exam_timetable_model.dart';
import 'package:college_app/models/fee_model.dart';
import 'package:college_app/models/hostel_menu_model.dart';
import 'package:college_app/models/study_material_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Attendance related methods
  Future<List<AttendanceModel>> getStudentAttendance(String studentId) async {
    try {
      final querySnapshot = await _firestore
          .collection('students')
          .doc(studentId)
          .collection('attendance')
          .get();

      return querySnapshot.docs
          .map((doc) => AttendanceModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  // Class timetable related methods
  Future<ClassTimetableModel?> getClassTimetable(
      String studentId, String semester, String section) async {
    try {
      final querySnapshot = await _firestore
          .collection('timetables')
          .where('semester', isEqualTo: semester)
          .where('section', isEqualTo: section)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return ClassTimetableModel.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      throw e;
    }
  }

  // Exam timetable related methods
  Future<List<ExamTimetableModel>> getExamTimetables(
      String studentId, String semester) async {
    try {
      final querySnapshot = await _firestore
          .collection('examTimetables')
          .where('semester', isEqualTo: semester)
          .get();

      return querySnapshot.docs
          .map((doc) => ExamTimetableModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  // Study materials related methods
  Future<List<StudyMaterialModel>> getStudyMaterials(
      String studentId, String subjectCode) async {
    try {
      final querySnapshot = await _firestore
          .collection('studyMaterials')
          .where('subjectCode', isEqualTo: subjectCode)
          .get();

      return querySnapshot.docs
          .map((doc) => StudyMaterialModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  Future<List<StudyMaterialModel>> getAllStudyMaterials(String studentId) async {
    try {
      final querySnapshot = await _firestore.collection('studyMaterials').get();

      return querySnapshot.docs
          .map((doc) => StudyMaterialModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  // Fee related methods
  Future<List<FeeModel>> getStudentFees(String studentId) async {
    try {
      final querySnapshot = await _firestore
          .collection('students')
          .doc(studentId)
          .collection('fees')
          .get();

      return querySnapshot.docs
          .map((doc) => FeeModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateFeePayment(
      String studentId, String feeId, Map<String, dynamic> paymentDetails) async {
    try {
      await _firestore
          .collection('students')
          .doc(studentId)
          .collection('fees')
          .doc(feeId)
          .update(paymentDetails);
    } catch (e) {
      throw e;
    }
  }

  // Hostel menu related methods
  Future<HostelMenuModel?> getHostelMenu(String hostelName) async {
    try {
      final querySnapshot = await _firestore
          .collection('hostelMenus')
          .where('hostelName', isEqualTo: hostelName)
          .where('validUntil', isGreaterThan: DateTime.now())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return HostelMenuModel.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      throw e;
    }
  }

  // Generic document fetching method
  Future<Map<String, dynamic>?> getDocument(
      String collection, String documentId) async {
    try {
      final docSnapshot =
      await _firestore.collection(collection).doc(documentId).get();

      if (docSnapshot.exists) {
        return docSnapshot.data();
      }
      return null;
    } catch (e) {
      throw e;
    }
  }

  // Generic collection fetching method
  Future<List<Map<String, dynamic>>> getCollection(String collection) async {
    try {
      final querySnapshot = await _firestore.collection(collection).get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw e;
    }
  }
}