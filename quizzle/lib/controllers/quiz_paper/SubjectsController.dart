import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzle/models/ClassModel.dart';

import '../../controllers/quiz_paper/ClassController.dart';
import '../../models/SubjectModel.dart';
import '../../screens/home/SubjectsScreen.dart';


class SubjectsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  RxList<SubjectModel> allSubjects = <SubjectModel>[].obs;
  RxList<SubjectModel> filteredSubjects = <SubjectModel>[].obs;
  RxString selectedClassType = ClassType.primary.name.obs;

  @override
  void onInit() {
    super.onInit();
    final _classModel = Get.arguments as ClassModel;

    loadSubjects(_classModel);
  }
  // navigatoQuestions({required SubjectModel subject}) {
  //   Get.toNamed(SubjectsScreen.routeName, arguments: subject);
  // }
  void loadSubjects(ClassModel classModel) async {
    try {

      // First, try to fetch from Firestore
      QuerySnapshot querySnapshot = await _firestore.collection('subjects').get();
      
      if (querySnapshot.docs.isNotEmpty) {
        allSubjects.value = querySnapshot.docs
            .map((doc) => SubjectModel.fromFirestore(doc))
            .toList();
      } else {
        // Fallback to predefined subjects if Firestore is empty
        allSubjects.value = SubjectModel.predefinedSubjects;
      }

      filterSubjectsByType(classModel.type);
    } catch (e) {
      // If there's an error, use predefined subjects
      allSubjects.value = SubjectModel.predefinedSubjects;
      filterSubjectsByType(classModel.type);
      print('Error loading subjects: $e');
    }
  }

  void filterSubjectsByType(String classType) {
    selectedClassType.value = classType;
    filteredSubjects.value = allSubjects.where((subject) => 
      subject.classType == classType || subject.classType == 'all'
    ).toList();
  }
}
