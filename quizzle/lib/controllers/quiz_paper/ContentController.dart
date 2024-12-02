import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzle/models/ClassModel.dart';

import '../../controllers/quiz_paper/ClassController.dart';
import '../../models/SchoolStageModel.dart';
import '../../screens/home/StudyYearsScreen.dart';


class ContentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  RxList<SchoolStageModel> allStudyYears = <SchoolStageModel>[].obs;
  RxList<SchoolStageModel> filteredStudyYears = <SchoolStageModel>[].obs;
 late SchoolStageModel schoolStageModel;

  @override
  void onInit() {
    super.onInit();
     schoolStageModel = Get.arguments as SchoolStageModel;
print(schoolStageModel.name);
    loadStudyYears(schoolStageModel);
  }
  // navigatoQuestions({required SchoolStageModel subject}) {
  //   Get.toNamed(StudyYearsScreen.routeName, arguments: subject);
  // }
  void loadStudyYears(SchoolStageModel schoolStage) async {
    allStudyYears.value = schoolStage.studyYearLevel;
    
    // try {
    //
    //   // First, try to fetch from Firestore
    //   QuerySnapshot querySnapshot = await _firestore.collection('StudyYears').get();
    //  
    //   if (querySnapshot.docs.isNotEmpty) {
    //     allStudyYears.value = querySnapshot.docs
    //         .map((doc) => SchoolStageModel.fromFirestore(doc))
    //         .toList();
    //   } else {
    //     // Fallback to predefined StudyYears if Firestore is empty
    //     allStudyYears.value = SchoolStageModel.predefinedStudyYears;
    //   }
    //
    //   filterStudyYearsByType(classModel.type);
    // } catch (e) {
    //   // If there's an error, use predefined StudyYears
    //   allStudyYears.value = SchoolStageModel.predefinedStudyYears;
    //   filterStudyYearsByType(classModel.type);
    //   print('Error loading StudyYears: $e');
    // }
  }

  // void filterStudyYearsByType(String classType) {
  //   selectedClassType.value = classType;
  //   filteredStudyYears.value = allStudyYears.where((subject) =>
  //     subject.classType == classType || subject.classType == 'all'
  //   ).toList();
  // }
}
