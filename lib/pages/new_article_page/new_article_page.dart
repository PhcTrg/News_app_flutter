import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_reading/Services/notifi_service.dart';
import 'package:news_reading/core/constant.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/util/navigator_page.dart';
import 'package:news_reading/widgets/button.dart';
import 'package:news_reading/widgets/custom_text_form_field.dart';
import '../../core/app_export.dart';
import 'package:http/http.dart' as http;

var categoris = [
  'Sports',
  'Technology',
  'Entertainment',
  'Politics',
  'Health',
  'Education',
  'Uncategorized'
];
String url = ConstValue().URL;

class NewArticlePage extends StatefulWidget {
  const NewArticlePage({Key? key})
      : super(
          key: key,
        );

  @override
  NewArticlePageState createState() => NewArticlePageState();

  // static Widget builder(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => HomeProvider(),
  //     child: NewArticlePage(),
  //   );
  // }
}

class NewArticlePageState extends State<NewArticlePage> {
  TextEditingController articleTitleController =
      TextEditingController(text: '');
  TextEditingController articleContentController =
      TextEditingController(text: '');
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  String cateVal = categoris[0];
  String createStatus = "";

  Future<String> addArticle(
      String title, String content, String category, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://$url:8000/api/articles/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "content": content,
          "category": category,
          "user": userId
        }),
      );

      if (response.statusCode == 201) {
        // final responseData = jsonDecode(response.body);
        createStatus = "Create article successfully";

        NotificationService().showNotification(
            title: 'Your article is now live',
            body: 'Your article: $title upload successfully');

        return createStatus;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      createStatus = "Create article fail: $e";
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    articleTitleController.dispose();
    articleContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final bottom = MediaQuery.of(context).viewInsets.bottom;
    void dropdownCallback(String? selectedVal) {
      if (selectedVal is String) {
        setState(() {
          cateVal = selectedVal;
        });
      }
    }

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(50.0),
        color: Colors.white,
        child: Scaffold(
          // appBar: _buildAppBar(context),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            reverse: true,
            child: Container(
              // decoration: AppDecoration.gradientWhiteAToGray5002,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (!context.watch<HomeProvider>().isLogin)
                      ? MainButton(
                          onPressedFunc: () =>
                              NavigatorPage().navigateLogin(context),
                          btnText: "LOGIN",
                        )
                      : Column(
                          children: [
                            Text(
                              "Article Title",
                              style: CustomTextStyles.titleLargeBluegray90022,
                            ),
                            SizedBox(height: 15.v),
                            CustomTextFormField(
                              controller: articleTitleController,
                              hintText: "Type your article title here...",
                              textInputType: TextInputType.emailAddress,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 1.h),
                              borderDecoration:
                                  TextFormFieldStyleHelper.underLineGray,
                              textStyle: theme.textTheme.bodyLarge,
                            ),
                            SizedBox(height: 30.v),
                            Text(
                              "Article Content",
                              style: CustomTextStyles.titleMediumBluegray90022,
                            ),
                            SizedBox(height: 15.v),
                            SizedBox(
                              width: 293.h,
                              child: CustomTextFormField(
                                controller: articleContentController,
                                hintText: "Type your article content here...",
                                textInputType: TextInputType.emailAddress,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 1.h),
                                borderDecoration:
                                    TextFormFieldStyleHelper.underLineGray,
                                maxLines: 8,
                                textStyle: theme.textTheme.bodyMedium!.copyWith(
                                  height: 1.43,
                                ),
                              ),
                            ),
                            SizedBox(height: 15.v),
                            Text(
                              "Categoris",
                              style: CustomTextStyles.titleMediumBluegray90022,
                            ),
                            DropdownButton(
                              value: cateVal,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: categoris.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: dropdownCallback,
                            ),
                            SizedBox(height: 15.v),
                            Text(createStatus),
                            SizedBox(height: 15.v),
                            MainButton(
                              btnText: "Submit".toUpperCase(),
                              onPressedFunc: () {
                                addArticle(
                                    articleTitleController.text,
                                    articleContentController.text,
                                    cateVal,
                                    context.watch<HomeProvider>().userModel.id);
                              },
                            ),
                            SizedBox(height: 15.v),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
