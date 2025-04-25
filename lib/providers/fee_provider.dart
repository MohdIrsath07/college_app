import 'package:flutter/foundation.dart';
import 'package:college_app/models/fee_model.dart';
import 'package:college_app/services/firestore_service.dart';

class FeeProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<FeeModel> _fees = [];
  bool _isLoading = false;
  String? _error;

  List<FeeModel> get fees => [..._fees];
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<FeeModel> get pendingFees {
    return _fees.where((fee) => !fee.isPaid).toList();
  }

  List<FeeModel> get paidFees {
    return _fees.where((fee) => fee.isPaid).toList();
  }

  double get totalPendingAmount {
    return pendingFees.fold(0, (sum, fee) => sum + fee.amount);
  }

  Future<void> fetchStudentFees(String studentId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final feesData = await _firestoreService.getStudentFees(studentId);
      _fees = feesData;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> updateFeePayment(
      String studentId, String feeId, Map<String, dynamic> paymentDetails) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.updateFeePayment(studentId, feeId, paymentDetails);

      // Refresh fees after payment
      await fetchStudentFees(studentId);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}