// this page is used to handle add and update article screen
// Responsibilities: Nguyen Phuoc Truong

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_reading/provider/article_provider.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/widgets/button.dart';
import 'package:news_reading/widgets/custom_elevated_button.dart';
import 'package:news_reading/widgets/custom_text_form_field.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

var categoris = [
  'Sports',
  'Technology',
  'Entertainment',
  'Politics',
  'Health',
  'Education',
  'Uncategorized'
];

class NewArticlePage extends StatefulWidget {
  const NewArticlePage({Key? key})
      : super(
          key: key,
        );

  @override
  NewArticlePageState createState() => NewArticlePageState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: NewArticlePage(),
    );
  }
}

class NewArticlePageState extends State<NewArticlePage> {
  var args;
  TextEditingController articleTitleController =
      TextEditingController(text: '');
  TextEditingController articleContentController =
      TextEditingController(text: '');
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  File? _selectImage;

  bool isUpdate = false;
  String cateVal = categoris[0];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments;

    // change value when the page refresh
    if (args != null &&
        articleTitleController.text == '' &&
        articleContentController.text == '') {
      articleTitleController =
          TextEditingController(text: args.newsmodel?.title ?? '');
      articleContentController =
          TextEditingController(text: args.newsmodel?.content ?? '');
      cateVal = args.newsmodel?.category ?? categoris[0];
      isUpdate = articleTitleController.text == '' ? false : true;
    }
  }

  @override
  void dispose() {
    articleTitleController.dispose();
    articleContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // change dropdown option
    void dropdownCallback(String? selectedVal) {
      if (selectedVal is String) {
        setState(() {
          cateVal = selectedVal;
        });
      }
    }

    print(isUpdate);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(50.0),
        color: Colors.white,
        child: Scaffold(
          appBar: _buildAppBar(context),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            reverse: true,
            child: Container(
              // decoration: AppDecoration.gradientWhiteAToGray5002,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 1.h),
                    borderDecoration: TextFormFieldStyleHelper.underLineGray,
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 1.h),
                      borderDecoration: TextFormFieldStyleHelper.underLineGray,
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
                  // Image picker
                  MainButton(
                    onPressedFunc: _pickImgFromGalery,
                    btnText: "Select Img",
                    icon: Icon(
                      Icons.image_rounded,
                      color: Colors.white,
                    ),
                  ),

                  (_selectImage != null)
                      ? Image.file(_selectImage!)
                      : Text("Please select image"),

                  SizedBox(height: 15.v),
                  Text(context.watch<ArticleProvider>().createStatus),
                  SizedBox(height: 15.v),
                  CustomElevatedButton(
                    text: "Submit".toUpperCase(),
                    buttonTextStyle: CustomTextStyles.bodyLargeWhiteA700,
                    onPressed: () {
                      // Add a new article
                      if (!isUpdate) {
                        var articleProvider = Provider.of<ArticleProvider>(
                            context,
                            listen: false);
                        var homeProvider =
                            Provider.of<HomeProvider>(context, listen: false);

                        articleProvider.addArticle(
                            articleTitleController.text,
                            articleContentController.text,
                            cateVal,
                            homeProvider.userModel.id,
                            _selectImage);
                      } else {
                        // Add a new article
                        var articleProvider = Provider.of<ArticleProvider>(
                            context,
                            listen: false);

                        articleProvider.updateArticle(
                            articleTitleController.text,
                            articleContentController.text,
                            args.userModel.id,
                            cateVal,
                            args.newsmodel.id);
                      }
                    },
                  ),
                  SizedBox(height: 15.v),
                  isUpdate
                      ? CustomElevatedButton(
                          text: "Go back to home Page".toUpperCase(),
                          buttonTextStyle: CustomTextStyles.bodyLargeWhiteA700,
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                      : (SizedBox())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _pickImgFromGalery() async {
    final returnImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImg == null) return;

    final filePath = returnImg.path;
    // Compress the image
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      filePath,
      filePath + "_compressed.jpg",
      quality: 88, // You can adjust the compression quality here
    );

    setState(() {
      _selectImage =
          compressedImage != null ? File(compressedImage.path) : null;
    });
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
