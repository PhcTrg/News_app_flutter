import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_reading/Services/notifi_service.dart';
import 'package:news_reading/model/news_model.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/util/navigator_page.dart';
import 'package:news_reading/widgets/button.dart';
import 'package:news_reading/widgets/custom_text_form_field.dart';
import 'package:news_reading/widgets/status_text.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:news_reading/core/constant.dart';

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

class UpdateArticlePage extends StatelessWidget {
  final NewsModel articles;
  TextEditingController articleTitleController =
      TextEditingController(text: '');
  TextEditingController articleContentController =
      TextEditingController(text: '');
  String updateStatus = '';

  UpdateArticlePage({
    super.key,
    required this.articles,
  });

  String cateVal = categoris[0];

  void initArticleData() {
    articleTitleController = TextEditingController(text: articles.title);
    articleContentController = TextEditingController(text: articles.content);
    cateVal = articles.category;
  }

  Future<String> updateArticle(String title, String content, int userId,
      String category, int articleId) async {
    try {
      final response = await http.put(
        Uri.parse('http://$url/api/articles/$articleId/'),
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

      if (response.statusCode == 200) {
        // final responseData = jsonDecode(response.body);
        updateStatus = "update article successfully";

        NotificationService().showNotification(
            title: 'Your article is update successfully',
            body: 'Your article: $title update successfully');

        return updateStatus;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      updateStatus = "update article fail: $e";
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final bottom = MediaQuery.of(context).viewInsets.bottom;
    void dropdownCallback(String? selectedVal) {
      if (selectedVal is String) {
        cateVal = selectedVal;
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
                      ? ElevatedButton(
                          onPressed: () =>
                              NavigatorPage().navigateLogin(context),
                          child: Text("Login"))
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
                            Text(updateStatus),
                            SizedBox(height: 15.v),
                            StatusText(text: updateStatus),
                            // MainButton(
                            //   btnText: "Submit".toUpperCase(),
                            //   onPressedFunc: () {
                            //     updateArticle(
                            //         articleTitleController.text,
                            //         articleContentController.text,
                            //         context.watch<HomeProvider>().userID,
                            //         cateVal,
                            //         articles.id);
                            //   },
                            // ),
                            SizedBox(height: 15.v),
                            ElevatedButton(
                                child: Text("Go back home"),
                                onPressed: () {
                                  // go home
                                })
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

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "Article Manipulation",
        // margin: EdgeInsets.only(left: 10.h),
      ),
      actions: [
        // AppbarTrailingImage(
        //   imagePath: ImageConstant.imgDownload,
        //   margin: EdgeInsets.symmetric(
        //     horizontal: 40.h,
        //     vertical: 12.v,
        //   ),
        // )
      ],
    );
  }
}
