import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineModel {
  final String id;
  final String name;
  final String status;
  final String userId;
  final String createdAt;
  final Color color;
  final List<Map<String, bool>> accountsToAccess;
  final num currentStock;
  final num pillsPerDose;
  final List<Map<String, String>> doseWithTime;

  MedicineModel({
    required this.id,
    required this.name,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.color,
    required this.accountsToAccess,
    required this.currentStock,
    required this.pillsPerDose,
    required this.doseWithTime,
  });

  factory MedicineModel.fromSnap(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return MedicineModel(
      id: data['id'],
      name: data['name'],
      status: data['status'],
      userId: data['userId'],
      createdAt: data['createdAt'],
      color: data['color'],
      accountsToAccess: data['accountsToAccess'],
      currentStock: data['currentStock'],
      pillsPerDose: data['pillsPerDose'],
      doseWithTime: data['doseWithTime'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'userId': userId,
    'createdAt': createdAt,
    'color': color.value,
    'accountsToAccess': accountsToAccess,
    'currentStock': currentStock,
    'pillsPerDose': pillsPerDose,
    'doseWithTime': doseWithTime,
  };
}
