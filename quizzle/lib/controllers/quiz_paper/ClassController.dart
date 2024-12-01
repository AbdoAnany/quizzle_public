import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/ClassModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum ClassType {all, primary,preparatory, secondary }
class ClassController extends GetxController {
  final allClasses = <ClassModel>[].obs;
  final filteredClasses = <ClassModel>[].obs;

  @override
  void onReady() {
    getAllClasses();
    super.onReady();
  }

  Future<void> getAllClasses() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance.collection('classes').get();
      final classList = data.docs.map((classDoc) => ClassModel.fromSnapshot(classDoc)).toList();
      classList.sort((a, b) => a.num.compareTo(b.num),);
      allClasses.assignAll(classList);
      filteredClasses.assignAll(classList);
      if(classList.isEmpty) addClassesToFirestore();
    } catch (e) {
      print("Error fetching classes: $e");
    }
  }
  void filterClasses(String query) {
    if (query.isEmpty) {
      filteredClasses.value = allClasses;
    } else {
      filteredClasses.value = allClasses.where((classModel) =>
      classModel.name.toLowerCase().contains(query.toLowerCase()) ||
          classModel.type.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
  }
  void addClassesToFirestore() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference classesCollection = firestore.collection('classes');

    // List of classes from الأول ابتدائي to الثالث ثانوي
    final List<Map<String, dynamic>> classes = [
      {"id": "class_1_primary", "name": "الصف الأول الابتدائي", "isActive": true,"type": ClassType.primary.name,"num":1},
      {"id": "class_2_primary", "name": "الصف الثاني الابتدائي", "isActive": true,"type": ClassType.primary.name,"num":2},
      {"id": "class_3_primary", "name": "الصف الثالث الابتدائي", "isActive": true,"type":ClassType.primary.name,"num":3},
      {"id": "class_4_primary", "name": "الصف الرابع الابتدائي", "isActive": true,"type": ClassType.primary.name,"num":4},
      {"id": "class_5_primary", "name": "الصف الخامس الابتدائي", "isActive": true,"type": ClassType.primary.name,"num":5},
      {"id": "class_6_primary", "name": "الصف السادس الابتدائي", "isActive": true,"type": ClassType.primary.name,"num":6},
      {"id": "class_1_preparatory", "name": "الصف الأول الإعدادي", "isActive": true,"type": ClassType.preparatory.name,"num":7},
      {"id": "class_2_preparatory", "name": "الصف الثاني الإعدادي", "isActive": true,"type": ClassType.preparatory.name,"num":8},
      {"id": "class_3_preparatory", "name": "الصف الثالث الإعدادي", "isActive": true,"type": ClassType.preparatory.name,"num":9},
      {"id": "class_1_secondary", "name": "الصف الأول الثانوي", "isActive": false,"type": ClassType.secondary.name,"num":10},
      {"id": "class_2_secondary", "name": "الصف الثاني الثانوي", "isActive": false,"type": ClassType.secondary.name,"num":11},
      {"id": "class_3_secondary", "name": "الصف الثالث الثانوي", "isActive": false,"type": ClassType.secondary.name,"num":12},
    ];

    try {
      for (var classData in classes) {
        await classesCollection.doc(classData['id']).set(classData);
        print("Class ${classData['name']} added successfully.");
      }
      print("All classes added successfully.");
    } catch (e) {
      print("Error adding classes: $e");
    }
  }

}