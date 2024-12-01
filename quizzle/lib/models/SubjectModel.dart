import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/quiz_paper/ClassController.dart';

class SubjectModel {
  final String id;
  final String name;
  final String classType;
  final bool isActive;

  SubjectModel({
    required this.id, 
    required this.name, 
    required this.classType,
    this.isActive = true,
  });

  factory SubjectModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return SubjectModel(
      id: doc.id,
      name: data['name'] ?? '',
      classType: data['classType'] ?? '',
      isActive: data['isActive'] ?? true,
    );
  }

  // Predefined Arabic subject list with types
  static List<SubjectModel> predefinedSubjects = [
    // Primary School Subjects
    SubjectModel(id: '7622', name: 'الرياضيات', classType: ClassType.primary.name, isActive: true),
    SubjectModel(id: '7645', name: 'التربية الفنية', classType: ClassType.primary.name, isActive: true),
    SubjectModel(id: '7781', name: 'العلوم', classType: ClassType.primary.name, isActive: true),
    SubjectModel(id: '7646', name: 'التربية الموسيقية', classType: ClassType.primary.name, isActive: true),
    SubjectModel(id: '22768', name: 'اكتشف', classType: ClassType.primary.name, isActive: true),
    SubjectModel(id: '7781', name: 'العلوم', classType: ClassType.primary.name, isActive: true),


    // Secondary School Subjects
    SubjectModel(id: 'SEC001', name: 'الرياضيات المتقدمة', classType: ClassType.secondary.name, isActive: true),
    SubjectModel(id: 'SEC003', name: 'الفيزياء', classType: ClassType.secondary.name, isActive: true),
    SubjectModel(id: 'SEC004', name: 'الكيمياء', classType: ClassType.secondary.name, isActive: true),

    // Preparatory School Subjects
    SubjectModel(id: 'PREP001', name: 'الرياضيات التطبيقية', classType: ClassType.preparatory.name, isActive: true),
    SubjectModel(id: 'PREP002', name: 'العلوم التطبيقية', classType: ClassType.preparatory.name, isActive: true),
    SubjectModel(id: 'PREP003', name: 'مهارات التفكير', classType: ClassType.preparatory.name, isActive: true),
    SubjectModel(id: 'PREP004', name: 'التكنولوجيا والابتكار', classType: ClassType.preparatory.name, isActive: true),
    SubjectModel(id: '7662', name: 'الدراسات الإجتماعية', classType: ClassType.preparatory.name, isActive: true),

    // Subjects Common to All Levels
    SubjectModel(id: '7621', name: 'التربية الدينية', classType:  ClassType.all.name, isActive: true),
    SubjectModel(id: '7701', name: 'اللغة العربية', classType:  ClassType.all.name, isActive: true),
    SubjectModel(id: '7696', name: 'اللغة الإنجليزية', classType: ClassType.all.name, isActive: true),
    SubjectModel(id: '7659', name: 'الحاسب الآلي وتكنولوجيا المعلومات', classType: ClassType.all.name, isActive: true),

    // Additional Language Subjects
    SubjectModel(id: '7686', name: 'اللغة الأسبانية', classType: ClassType.secondary.name, isActive: true),
    SubjectModel(id: '7704', name: 'اللغة الفرنسية', classType: ClassType.secondary.name, isActive: true),

    // Specialized Subjects
    SubjectModel(id: '22755', name: 'المهارات المهنية', classType: ClassType.preparatory.name, isActive: true),


    SubjectModel(id: '21339', name: 'القيم واحترام الآخر', classType:  ClassType.all.name, isActive: true),

    // Unique Exploratory Subjects
    SubjectModel(id: '29660', name: 'أساسيات توكاتسو', classType: ClassType.secondary.name, isActive: true),
  ];
}