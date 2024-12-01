
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/widgets/widgets.dart';

import '../../controllers/quiz_paper/ClassController.dart';
import '../../models/ClassModel.dart';
import '../../widgets/home/ClassCard.dart';
import 'custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../controllers/class_controller.dart'; // Import ClassController

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final ClassController _classController = Get.put(ClassController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated Header
            FadeInDown(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'بوابة التعليم الإلكترونى',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor,
                      ),
                    ),      SizedBox(width: 8,),SizedBox(width: 8,),
                    Icon(
                        Iconsax.briefcase5,
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),

                  ],
                ),
              ),
            ),

            // Search Bar
            FadeInRight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ابحث عن المرحلة الدراسية',
                    prefixIcon: Icon(Icons.search, color:  Theme.of(context).primaryColor,),
                    filled: true,
                    fillColor:  Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none
                    ),
                  ),
                  onChanged: (value) {
                    _classController.filterClasses(value);
                  },
                ),
              ),
            ),

            // Class List
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: _classController.filteredClasses.length,
                  itemBuilder: (context, index) {
                    final classModel = _classController.filteredClasses[index];
                    return FadeInUp(
                      delay: Duration(milliseconds: 100 * index),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ClassCard(model: classModel),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen1 extends GetView<MyDrawerController> {
  const HomeScreen1({Key? key}) : super(key: key);

  static const String routeName = '/home';
  

  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprContoller = Get.find();
    return Scaffold(
        body: GetBuilder<MyDrawerController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        borderRadius: 50.0,
        showShadow: true,
        angle: 0.0,
        style: DrawerStyle.defaultStyle,
        menuScreen: const CustomDrawer(),
        menuBackgroundColor: Colors.white.withOpacity(0.5),
        slideWidth: MediaQuery.of(context).size.width * 0.6,
        mainScreen: Container(
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kMobileScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(-10, 0),
                        child: CircularButton(
                          onTap: controller.toggleDrawer,
                          child: const Icon(AppIcons.menuleft),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Icon(AppIcons.peace),
                            Builder(
                              builder: (_) {
                                final AuthController _auth = Get.find();
                                final user = _auth.getUser();
                                String label = '  Hello mate';
                                if (user != null) {
                                  label = '  Hello ${user.displayName}';
                                }
                                return Text(label,
                                    style: kDetailsTS.copyWith(
                                        color: kOnSurfaceTextColor));
                              },
                            ),
                          ],
                        ),
                      ),
                      const Text('What Do You Want To Improve Today ?',
                          style: kHeaderTS),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ContentArea(
                      addPadding: false,
                      child: Obx(
                        () => LiquidPullToRefresh(
                          height: 150,
                          springAnimationDurationInMilliseconds: 500,
                          //backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          onRefresh: () async {
                            _quizePprContoller.getAllPapers();
                          },
                          child: ListView.separated(
                            padding: UIParameters.screenPadding,
                            shrinkWrap: true,
                            itemCount: _quizePprContoller.allPapers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return QuizPaperCard(
                                model: _quizePprContoller.allPapers[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => const SizedBox(
                                height: 20,
                              ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
