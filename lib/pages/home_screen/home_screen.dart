import 'package:flutter/material.dart';
import 'package:news_reading/model/news_model.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/widgets/list_view_post.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<HomeScreen> createState() => _MyAppState();
}

class _MyAppState extends State<HomeScreen> {
  late Future<List<NewsModel>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = context.read<HomeProvider>().getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: _buildAppBar(context),
        body: Row(
          children: [
            SizedBox(
              width: SizeUtils.width,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 6.v),
                child: SizedBox(
                  height: 739.v,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: AppDecoration.gradientWhiteAToGray5002,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FutureBuilder<List<NewsModel>>(
                                  future: futureNews,
                                  builder: (context, data) {
                                    if (data.hasData) {
                                      return _buildColumnMyPosts(
                                          context, data.data!);
                                    }

                                    return const CircularProgressIndicator();
                                  }),
                            ],
                          ),
                        ),
                      ),
                      // _buildMyPosts(context)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "Posts",
        margin: EdgeInsets.only(left: 40.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgUser,
          margin: EdgeInsets.fromLTRB(40.h, 11.v, 40.h, 12.v),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildColumnMyPosts(BuildContext context, List<NewsModel> news) {
    String dataLength = "";

    if (news.length == 0) {
      dataLength = "There is no news";
    } else {
      dataLength = "";
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.h,
        vertical: 32.v,
      ),
      decoration: AppDecoration.outlineBlueA2000f1.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "All Posts",
                style: CustomTextStyles.titleLargeBluegray900,
              ),
              Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgGrid,
                height: 24.adaptSize,
                width: 24.adaptSize,
                margin: EdgeInsets.only(bottom: 3.v),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgMegaphone,
                height: 24.adaptSize,
                width: 24.adaptSize,
                margin: EdgeInsets.only(
                  left: 24.h,
                  bottom: 3.v,
                ),
              )
            ],
          ),
          // SizedBox(height: 23.v),

          Text(dataLength),
          ListNews(news: news)
          // ListView.builder(
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   itemCount: news.length,
          //   itemBuilder: (context, index) {
          //     return Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: GestureDetector(
          //           onTap: () {
          //             Navigator.pushNamed(context, AppRoutes.articleScreen,
          //                 arguments: ArticleArguments(news[index]));
          //           },
          //           child: ProductCard(news: news[index]),
          //         ));
          //   },
          // ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildFollowers(
    BuildContext context, {
    required String rating,
    required String followersCount,
  }) {
    return Column(
      children: [
        Text(
          rating,
          style: theme.textTheme.titleLarge!.copyWith(
            color: appTheme.whiteA700,
          ),
        ),
        SizedBox(height: 3.v),
        Text(
          followersCount,
          style: CustomTextStyles.bodySmallMulishWhiteA700.copyWith(
            color: appTheme.whiteA700.withOpacity(0.87),
          ),
        )
      ],
    );
  }
  //
}
