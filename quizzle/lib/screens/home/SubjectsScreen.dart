import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzle/models/ClassModel.dart';

import '../../controllers/quiz_paper/ClassController.dart';
import '../../controllers/quiz_paper/SubjectsController.dart';
import '../../models/SubjectModel.dart';

class SubjectsScreen extends StatelessWidget {
  static const String routeName = '/subjects';

  @override
  Widget build(BuildContext context) {
    final SubjectsController controller = Get.put(SubjectsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('المواد الدراسية', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          // Class Type Selector
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       _buildClassTypeChip(controller, ClassType.primary.name, 'ابتدائي'),
          //       _buildClassTypeChip(controller, ClassType.secondary.name, 'متوسط'),
          //       _buildClassTypeChip(controller, ClassType.preparatory.name, 'إعدادي'),
          //     ],
          //   ),
          // ),

          // Subjects List
          Expanded(
            child: Obx(() {
              if (controller.filteredSubjects.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.book_outlined,
                          size: 80, color: Colors.grey[300]),
                      SizedBox(height: 16),
                      Text(
                        'لا توجد مواد متاحة',
                        style: TextStyle(color: Colors.grey[600], fontSize: 18),
                      )
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 0),
                itemCount: controller.filteredSubjects.length,
                itemBuilder: (context, index) {
                  final subject = controller.filteredSubjects[index];
                  return SubjectCard(subject: subject);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Widget _buildClassTypeChip(
  //     SubjectsController controller, String type, String label) {
  //   return Obx(() => ChoiceChip(
  //         label: Text(label),
  //         selected: controller.selectedClassType.value == type,
  //         onSelected: (_) => controller.filterSubjectsByType(type),
  //         selectedColor: Colors.deepPurple[100],
  //         backgroundColor: Colors.grey[200],
  //         labelStyle: TextStyle(
  //           color: controller.selectedClassType.value == type
  //               ?  Theme.of(context).primaryColor
  //               : Colors.grey[700],
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ));
  // }
}

class SubjectCard extends StatelessWidget {
  final SubjectModel subject;
  const SubjectCard({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColorDark,  Theme.of(context).primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.purple.withOpacity(0.2),
        //     spreadRadius: 2,
        //     blurRadius: 10,
        //     offset: Offset(0, 5),
        //   )
        // ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Add navigation or action
            Get.snackbar(
              'المادة',
              subject.name,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Theme.of(context).cardColor,
              colorText: Theme.of(context).primaryColor,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Subject Icon
                Container(
                  decoration: BoxDecoration(
                    color:  Theme.of(context).cardColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    _getIconForSubject(subject.name),
                    // color: Theme.of(context).primaryColorDark,
                    size: 30,
                  ),
                ),
                SizedBox(width: 16),

                // Subject Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color:  Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _getSubjectDescription(subject.name),
                        style: TextStyle(
                          fontSize: 12,
                          color:  Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Helper methods to enhance the card
  IconData _getIconForSubject(String subjectName) {
    switch (subjectName) {
      case 'الرياضيات':
      case 'الرياضيات المتقدمة':
        return Icons.calculate_outlined;
      case 'العلوم':
      case 'الفيزياء':
      case 'الكيمياء':
        return Icons.science_outlined;
      case 'اللغة العربية':
        return Icons.translate;
      case 'اللغة الإنجليزية':
        return Icons.language_outlined;
      case 'التربية الدينية':
        return Icons.mosque_outlined;
      case 'التربية الفنية':
        return Icons.palette_outlined;
      case 'الحاسب الآلي وتكنولوجيا المعلومات':
        return Icons.computer_outlined;
      default:
        return Icons.book_outlined;
    }
  }

  String _getSubjectDescription(String subjectName) {
    switch (subjectName) {
      case 'الرياضيات':
        return 'دراسة الأعداد والعمليات الحسابية';
      case 'العلوم':
        return 'استكشاف الظواهر الطبيعية';
      case 'اللغة العربية':
        return 'تعلم اللغة والأدب العربي';
      case 'اللغة الإنجليزية':
        return 'تطوير مهارات اللغة الإنجليزية';
      case 'التربية الدينية':
        return 'تعميق الفهم الديني والقيمي';
      default:
        return 'مادة دراسية متخصصة';
    }
  }
}
