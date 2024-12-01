import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:iconsax/iconsax.dart';

import '../../configs/themes/app_icons_icons.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../controllers/quiz_paper/ClassController.dart';
import '../../controllers/quiz_paper/quiz_papers_controller.dart';
import '../../models/ClassModel.dart';
import '../../screens/home/SubjectsScreen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/leaderboard/leaderboard_screen.dart';
import '../../screens/quiz/quiz_screen.dart';
import '../common/icon_with_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassCard extends StatelessWidget {
  final ClassModel model;

  const ClassCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(SubjectsScreen.routeName, arguments: model);


        // Navigation or further actions
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getGradientColors(model.type),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color:  _getGradientColors(model.type).first.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Type Icon
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIconForType(model.type),
                  color: Colors.white,
                  size: 30,
                ),
              ),

              SizedBox(width: 16),

              // Class Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _getSubtitleForType(model.type),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Status Indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: model.isActive
                      ? Colors.green.withOpacity(0.7)
                      : Colors.red.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  model.isActive ? 'أكتشف' : 'لا يوجد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> _getGradientColors(String type) {
    switch (type) {
      case 'primary':
        return [Colors.blue[400]!, Colors.blue[700]!];
      case 'secondary':
        return [Colors.purple[400]!, Colors.purple[700]!];
      case 'preparatory':
        return [Colors.orange[400]!, Colors.orange[700]!];
      default:
        return [Colors.deepPurple[400]!, Colors.deepPurple[700]!];
    }
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'primary':
        return Iconsax.teacher;
      case 'secondary':
        return Iconsax.teacher;
      case 'preparatory':
        return Iconsax.teacher;
      default:
        return Iconsax.teacher;
    }
  }

  String _getSubtitleForType(String type) {
    switch (type) {
      case 'primary':
        return 'Elementary Level';
      case 'secondary':
        return 'Advanced Preparation';

      case 'preparatory':
        return 'Intermediate Level';
      default:
        return 'Educational Class';
    }
  }
}