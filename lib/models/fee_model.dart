import 'package:cloud_firestore/cloud_firestore.dart';

class FeeModel {
  final String id;
  final String feeType;
  final double amount;
  final DateTime dueDate;
  final bool isPaid;
  final DateTime? paidDate;
  final String? transactionId;
  final String paymentMethod;
  final String semester;

  FeeModel({
    required this.id,
    required this.feeType,
    required this.amount,
    required this.dueDate,
    required this.isPaid,
    this.paidDate,
    this.transactionId,
    required this.paymentMethod,
    required this.semester,
  });

  factory FeeModel.fromJson(Map<String, dynamic> json) {
    return FeeModel(
      id: json['id'] ?? '',
      feeType: json['feeType'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      dueDate: json['dueDate'] != null
          ? (json['dueDate'] as Timestamp).toDate()
          : DateTime.now(),
      isPaid: json['isPaid'] ?? false,
      paidDate: json['paidDate'] != null
          ? (json['paidDate'] as Timestamp).toDate()
          : null,
      transactionId: json['transactionId'],
      paymentMethod: json['paymentMethod'] ?? '',
      semester: json['semester'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'feeType': feeType,
      'amount': amount,
      'dueDate': dueDate,
      'isPaid': isPaid,
      'paidDate': paidDate,
      'transactionId': transactionId,
      'paymentMethod': paymentMethod,
      'semester': semester,
    };
  }
}