import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineModel {
  final String id;
  final String name;
  final String status;
  final String userId;
  final String createdAt;

  MedicineModel({
    required this.id,
    required this.name,
    required this.status,
    required this.userId,
    required this.createdAt,
  });

  factory MedicineModel.fromSnap(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return MedicineModel(
      id: data['id'],
      name: data['name'],
      status: data['status'],
      userId: data['userId'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'userId': userId,
    'createdAt': createdAt,
  };
}
