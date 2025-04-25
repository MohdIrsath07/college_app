import 'package:flutter/foundation.dart';
import 'package:college_app/models/study_material_model.dart';
import 'package:college_app/services/firestore_service.dart';

class StudyMaterialProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<StudyMaterialModel> _studyMaterials = [];
  bool _isLoading = false;
  String? _error;

  List<StudyMaterialModel> get studyMaterials => [..._studyMaterials];
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAllStudyMaterials(String studentId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final materialsData = await _firestoreService.getAllStudyMaterials(studentId);
      _studyMaterials = materialsData;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchStudyMaterialsBySubject(
      String studentId, String subjectCode) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final materialsData =
      await _firestoreService.getStudyMaterials(studentId, subjectCode);
      _studyMaterials = materialsData;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  List<StudyMaterialModel> getRecentMaterials() {
    final sortedMaterials = [..._studyMaterials];
    sortedMaterials.sort((a, b) => b.uploadDate.compareTo(a.uploadDate));

    return sortedMaterials.take(5).toList();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}