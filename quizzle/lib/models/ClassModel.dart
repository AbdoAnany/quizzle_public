import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModel {
  final String id;
  final int num;
  final String name;
  final String type;
  bool isActive = true;

  ClassModel({required this.id, required this.name,required this.num,required this.type,this.isActive=true});

  factory ClassModel.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return ClassModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      num: data['num'] ?? '',
      type: data['type'] ?? '',
      isActive: data['isActive'] ?? '',
    );
  }
}
