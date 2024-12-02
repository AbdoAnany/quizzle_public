
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
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final ClassController _classController = Get.put(ClassController());

    return DataScreen();
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: SafeArea(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // Animated Header
    //         FadeInDown(
    //           child: Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 Text(
    //                   'بوابة التعليم الإلكترونى',
    //                   style: TextStyle(
    //                       fontSize: 28,
    //                       fontWeight: FontWeight.w800,
    //                       color: Theme.of(context).primaryColor,
    //                   ),
    //                 ),      SizedBox(width: 8,),SizedBox(width: 8,),
    //                 Icon(
    //                     Iconsax.briefcase5,
    //                   color: Theme.of(context).primaryColor,
    //                   size: 32,
    //                 ),
    //
    //               ],
    //             ),
    //           ),
    //         ),
    //
    //
    //         Expanded(
    //           child: ListView.builder(
    //             // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1
    //             // ,crossAxisSpacing: 12,childAspectRatio: 5,
    //             //   mainAxisSpacing: 12
    //             // ),
    //             padding: EdgeInsets.all(16),
    //             itemCount: _classController.schoolStageList.length,
    //             itemBuilder: (context, index) {
    //               final classModel = _classController.schoolStageList[index];
    //               return FadeInUp(
    //                 delay: Duration(milliseconds: 100 * index),
    //                 child: SchoolStageCard(model: classModel),
    //               );
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
final List<dynamic> schoolStageList =[
  {
    'id':1,
    'name':"المرحلة رياض الاطفال",
    "des":"",
    "image":"",
    'color':Colors.blue,
    "type":"kg",
  },
  {
    'id':2,
    'name':"المرحلة الإبتدائية",
    "des":"",
    "image":"",
    'color':Colors.green,
    "type":"kg",
  }, {
    'id':3,
    'name':" المرحلة الإعدادية",
    "des":"",
    "image":"",
    'color':Colors.green,
    "type":"kg",
  },{
    'id':4,
    'name':" المرحلة الثانوية",
    "des":"",
    "image":"",
    'color':Colors.green,
    "type":"kg",
  }, {
    'id':5,
    'name':"ذوي الإحتياجات الخاصة (بث تجريبى)",
    "des":"",
    "image":"",
    'color':Colors.green,
    "type":"kg",
  }, {
    'id':6,
    'name':"التعليم المجتمعي",
    "des":"",
    "image":"",
    'color':Colors.green,
    "type":"kg",
  },
];
//<select id="schoolStageId" placeholder="SchoolStage"
// class="form-control"><option value="">اختر</option><option value="6959">مرحلة رياض الاطفال
// </option><option value="1582">المرحلة الإبتدائية</option><option value="1930">
// المرحلة الإعدادية
// </option><option value="1931">المرحله الثانوية
// </option><option value="28268">ذوي الإحتياجات الخاصة (بث تجريبى)
// </option><option value="31333">التعليم المجتمعي</option></select>



class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List<Map<String, String>> dataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        'https://moe.gov.eg/ar/elearningenterypage/e-learning?schoolStageId=1582&schoolYearId=3606&schoolTermId=1584&pageIndex=0&sortBy=0';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = parser.parse(utf8.decode(response.bodyBytes));
        final elements = document.getElementsByClassName('elearning-list');

        List<Map<String, String>> tempDataList = [];

        for (var element in elements) {
          final cards = element.getElementsByClassName('card-body');
          final links = element.getElementsByClassName('d-flex');

          for (var i = 0; i < cards.length; i++) {
            final titles = cards[i].getElementsByTagName('h5');
            final String title1 =
            titles.isNotEmpty ? titles[0].text.trim() : '';
            final String title2 =
            titles.length > 1 ? titles[1].text.trim() : '';

            final downloadLinks = links[i].getElementsByTagName('a');
            String? downloadLink;

            if (downloadLinks.isNotEmpty) {
              for (var link in downloadLinks) {
                if (link.text.contains('تحميل الملف')) {
                  downloadLink = link.attributes['href'];
                  break;
                }
              }
            }

            tempDataList.add({
              'title': title1,
              'subtitle': title2,
              'link': downloadLink ?? '',
            });
          }
        }

        setState(() {
          dataList = tempDataList;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scraped Data'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final item = dataList[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(item['title'] ?? 'No Title'),
              subtitle: Text(item['subtitle'] ?? 'No Subtitle'),
              trailing: Icon(Icons.download),
              onTap: () {
                if (item['link'] != null && item['link']!.isNotEmpty) {
                  _showDownloadDialog(context, item['link']!);
                }
              },
            ),
          );
        },
      ),
    );
  }

  void _showDownloadDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Download File'),
          content: Text('Do you want to download the file from this link?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // You can handle file download here using another package like dio
              },
              child: Text('Download'),
            ),
          ],
        );
      },
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
