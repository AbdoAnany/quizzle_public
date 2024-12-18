import 'package:get/get.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/controllers/quiz_paper/ClassController.dart';
import 'package:quizzle/controllers/quiz_paper/StudyYearsController.dart';
import 'package:quizzle/screens/screens.dart';

import '../controllers/quiz_paper/ContentController.dart';
import '../controllers/quiz_paper/SubjectsController.dart';
import '../screens/home/ContantScreen.dart';
import '../screens/home/StudyYearsScreen.dart';
import '../screens/home/SubjectsScreen.dart';

class AppRoutes {
  static List<GetPage> pages() => [
        GetPage(
          page: () => const SplashScreen(),
          name: SplashScreen.routeName,
        ),
        GetPage(
          page: () => const AppIntroductionScreen(),
          name: AppIntroductionScreen.routeName,
        ),
        GetPage(
            page: () =>  HomeScreen(),
            name: HomeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(ClassController());
              Get.put(MyDrawerController());
            })),

    GetPage(
            page: () =>  StudyYearsScreen(),
            name: StudyYearsScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(StudyYearsController());
              Get.put(ClassController());
              // Get.put(MyDrawerController());
            })),
    GetPage(
            page: () =>  ContentScreen(),
            name: ContentScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(ContentController());
              // Get.put(ClassController());
              // Get.put(MyDrawerController());
            })),
    GetPage(
            page: () =>  SubjectsScreen(),
            name: SubjectsScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(SubjectsController());
              Get.put(ClassController());
              Get.put(MyDrawerController());
            })),
        GetPage(page: () => const LoginScreen(), name: LoginScreen.routeName),
        GetPage(
            page: () => const ProfileScreen(),
            name: ProfileScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(ProfileController());
            })),
        GetPage(
            page: () => LeaderBoardScreen(),
            name: LeaderBoardScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(LeaderBoardController());
            })),
        GetPage(
            page: () => QuizeScreen(),
            name: QuizeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<QuizController>( QuizController());
            })),
    GetPage(
            page: () => QuizeScreen(),
            name: QuizeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<QuizController>( QuizController());
            })),
        GetPage(
            page: () => const AnswersCheckScreen(),
            name: AnswersCheckScreen.routeName),
        GetPage(
            page: () => const QuizOverviewScreen(),
            name: QuizOverviewScreen.routeName),
        GetPage(page: () => const Resultcreen(), name: Resultcreen.routeName),
      ];
}
