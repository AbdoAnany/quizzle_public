import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/ClassModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/SchoolStageModel.dart';

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



// Initialize the list of school stages with simple descriptions
  final List<SchoolStageModel> schoolStageList = [
    SchoolStageModel(
      id: 1,
      name: "المرحلة رياض الاطفال",
      des: "مرحلة تأسيسية للأطفال من سن 4 إلى 6 سنوات.",
      image: "",
      color: Colors.blue.value,
      type: "kg",
      studyYearLevel: [
        SchoolStageModel(
          id: 11,
          name: "Kg 1",
          des: "مرحلة تأسيسية للأطفال من سن 4 إلى 5 سنوات.",
          image: "",
          color: Colors.blue.value,
          type: "kg",
          studyYearLevel: [
            SchoolStageModel(
              id: 111,
              name: "محتوى تفاعلي",
              des: "محتوى تفاعلي للأطفال.",
              image: "",
              color: Colors.blue.value,
              type: "kg1",
            ),
            SchoolStageModel(
              id: 112,
              name: "كتاب الطالب",
              des: "كتاب الطالب.",
              image: "",
              color: Colors.blue.value,
              type: "kg1",
            ),
            SchoolStageModel(
              id: 113,
              name: "مواد إثرائية",
              des: "مواد إثرائية.",
              image: "",
              color: Colors.blue.value,
              type: "kg1",
            ),
            SchoolStageModel(
              id: 114,
              name: "دليل المعلم",
              des: "دليل المعلم.",
              image: "",
              color: Colors.blue.value,
              type: "kg1",
            ),
            SchoolStageModel(
              id: 115,
              name: "نماذج اختبارية",
              des: "نماذج اختبارية للأطفال للتدريب.",
              image: "",
              color: Colors.blue.value,
              type: "kg1",
            ),
          ],
        ),
        SchoolStageModel(
          id: 12,
          name: "Kg 2",
          des: "مرحلة تأسيسية للأطفال من سن 5 إلى 6 سنوات.",
          image: "",
          color: Colors.blue.value,
          type: "kg",
          studyYearLevel: [
            SchoolStageModel(
              id: 121,
              name: "محتوى تفاعلي",
              des: "محتوى تفاعلي للأطفال.",
              image: "",
              color: Colors.blue.value,
              type: "kg2",
            ),
            SchoolStageModel(
              id: 122,
              name: "كتاب الطالب",
              des: "كتاب الطالب.",
              image: "",
              color: Colors.blue.value,
              type: "kg2",
            ),
          ],
        ),
      ],
    ),
    SchoolStageModel(
      id: 2,
      name: "المرحلة الإبتدائية",
      des: "مرحلة التعليم الأساسي من الصف الأول إلى السادس.",
      image: "",
      color: Colors.green.value,
      type: "primary",
      studyYearLevel: [
        SchoolStageModel(
          id: 21,
          name: "الصف الأول الإبتدائي",
          des: "الصف الأول من التعليم الابتدائي.",
          image: "",
          color: Colors.green.value,
          type: "primary",
          studyYearLevel: [
            SchoolStageModel(
              id: 211,
              name: "الرياضيات",
              des: "مادة الرياضيات للصف الأول.",
              image: "",
              color: Colors.green.value,
              type: "primary",
            ),
            SchoolStageModel(
              id: 212,
              name: "اللغة العربية",
              des: "مادة اللغة العربية.",
              image: "",
              color: Colors.green.value,
              type: "primary",
            ),
          ],
        ),
        SchoolStageModel(
          id: 22,
          name: "الصف الثاني الإبتدائي",
          des: "الصف الثاني من التعليم الابتدائي.",
          image: "",
          color: Colors.green.value,
          type: "primary",
        ),
      ],
    ),
    SchoolStageModel(
      id: 3,
      name: "المرحلة الإعدادية",
      des: "مرحلة التعليم المتوسط من الصف السابع إلى التاسع.",
      image: "",
      color: Colors.orange.value,
      type: "middle",
    ),
    SchoolStageModel(
      id: 4,
      name: "المرحلة الثانوية",
      des: "مرحلة التعليم الثانوي من الصف العاشر إلى الثاني عشر.",
      image: "",
      color: Colors.purple.value,
      type: "high",
    ),
    SchoolStageModel(
      id: 5,
      name: "ذوي الإحتياجات الخاصة (بث تجريبى)",
      des: "مرحلة مخصصة لتعليم ذوي الإحتياجات الخاصة.",
      image: "",
      color: Colors.indigo.value,
      type: "special",
    ),
    SchoolStageModel(
      id: 6,
      name: "التعليم المجتمعي",
      des: "مرحلة تعليمية موجهة للمجتمع المحلي.",
      image: "",
      color: Colors.brown.value,
      type: "community",
    ),
  ];

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