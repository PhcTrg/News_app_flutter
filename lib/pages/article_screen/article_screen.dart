import 'package:flutter/material.dart';
import 'package:news_reading/model/news_model.dart';
import 'package:news_reading/pages/argumennt/article_argument.dart';
import 'package:news_reading/provider/article_provider.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';

class ArticleScreen extends StatefulWidget {
  // final NewsModel news;

  const ArticleScreen({Key? key})
      : super(
          key: key,
        );

  @override
  ArticleScreenState createState() => ArticleScreenState();

  static Widget builder(BuildContext context, NewsModel news) {
    return ChangeNotifierProvider(
      create: (context) => ArticleProvider(),
      child: ArticleScreen(),
    );
  }
}

class ArticleScreenState extends State<ArticleScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var news = widget.news;

    // var news = NewsModel(
    //   comments: [
    //     Comment(
    //         content:
    //             'This is a great article!This is a great article!This is a great article!This is a great article!This is a great article!This is a great article!This is a great article!This is a great article!This is a great article!',
    //         user: 'User1'),
    //     Comment(content: 'I found this very helpful.', user: 'User2'),
    //     Comment(content: 'Can someone explain this part to me?', user: 'User3'),
    //   ],
    // );

    final args = ModalRoute.of(context)!.settings.arguments as ArticleArguments;

    return SafeArea(
      child: Scaffold(
        // appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 13.v),
              Container(
                width: 295.h,
                margin: EdgeInsets.only(
                  left: 40.h,
                  right: 39.h,
                ),
                child: Text(
                  "msg_four_things_every".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 33.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 39.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 38.adaptSize,
                      width: 38.adaptSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.h,
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            ImageConstant.imgPlaceholder38x38,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "lbl_richard_gervain".tr,
                            style: CustomTextStyles.bodyMediumIndigo800_1,
                          ),
                          SizedBox(height: 5.v),
                          Padding(
                            padding: EdgeInsets.only(left: 3.h),
                            child: Text(
                              "lbl_2m_ago".tr,
                              style: CustomTextStyles.bodySmallBluegray400_1,
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    CustomImageView(
                      imagePath: ImageConstant.imgSend,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      margin: EdgeInsets.only(
                        top: 7.v,
                        bottom: 8.v,
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgBookmark,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      margin: EdgeInsets.only(
                        left: 24.h,
                        top: 7.v,
                        bottom: 8.v,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 23.v),
              SizedBox(
                height: 508.v,
                width: double.maxFinite,
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage,
                      height: 219.v,
                      width: 375.h,
                      alignment: Alignment.topCenter,
                    ),
                    SizedBox(height: 13.v),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 40.h),
                            decoration: AppDecoration.outlineBlueAF.copyWith(
                              borderRadius: BorderRadiusStyle.customBorderTL28,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 293.h,
                                    margin: EdgeInsets.only(right: 84.h),
                                    child: Text(
                                      args.newsmodel.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        height: 1.11,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 13.v),
                                  SizedBox(
                                    width: 293.h,
                                    child: Text(
                                      args.newsmodel.content,
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyles
                                          .bodyMediumIndigo800_1
                                          .copyWith(
                                        height: 1.43,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 13.v),
                                  SizedBox(
                                    width: 293.h,
                                    child: Text(
                                      args.newsmodel.content,
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyles
                                          .bodyMediumIndigo800_1
                                          .copyWith(
                                        height: 1.43,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 13.v),
                                  Container(
                                    width: 293.h,
                                    margin: EdgeInsets.only(right: 84.h),
                                    child: Text(
                                      "Comment Section",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        height: 1.11,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 293.h,
                                    height:
                                        (args.newsmodel.comments?.length.v ??
                                                0) *
                                            150.v,
                                    child: ListView.builder(
                                      itemCount:
                                          args.newsmodel.comments?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final comment =
                                            args.newsmodel.comments![index];
                                        return ListTile(
                                          leading: Icon(Icons.person_2_rounded),
                                          title: Text(
                                              '${comment.user.toString()}'),
                                          subtitle: Text(comment.content),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _buildColumn21k(context),
      ),
    );
  }

  /// Section Widget
  // PreferredSizeWidget _buildAppBar(BuildContext context) {
  //   return CustomAppBar(
  //     leadingWidth: 72.h,
  //     leading: AppbarLeadingImage(
  //       imagePath: ImageConstant.imgChevronLeft,
  //       margin: EdgeInsets.only(
  //         left: 40.h,
  //         top: 12.v,
  //         bottom: 12.v,
  //       ),
  //       onTap: () {
  //         onTapChevronleftone(context);
  //       },
  //     ),
  //     actions: [
  //       AppbarTrailingImage(
  //         imagePath: ImageConstant.imgOverflow,
  //         margin: EdgeInsets.symmetric(
  //           horizontal: 40.h,
  //           vertical: 12.v,
  //         ),
  //       )
  //     ],
  //   );
  // }

  /// Section Widget
  Widget _buildColumn21k(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 224.h,
        right: 40.h,
        bottom: 44.v,
      ),
      decoration: AppDecoration.gradientGrayToGray,
      child: CustomElevatedButton(
        text: "lbl_2_1k".tr,
        leftIcon: Container(
          margin: EdgeInsets.only(right: 8.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgThumbs,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapChevronleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}
