import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromSnap(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return UserModel(id: data['id'], name: data['name'], email: data['email']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email};
}
