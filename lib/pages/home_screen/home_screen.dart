import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:news_reading/argumennt/article_argument.dart';
import 'package:news_reading/core/utils/date_time_utils.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // fetchData();
    futureNews = context.read<HomeProvider>().getNewsData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    await context.read<HomeProvider>().getNewsData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // RefreshIndicator(
                //   onRefresh: () async {
                //     setState(() {
                //       fetchData();
                //     });
                //   },
                //   child:

                FutureBuilder<List<NewsModel>>(
                    future: futureNews,
                    builder: (context, data) {
                      if (data.hasData) {
                        //  data.data!
                        return Column(
                          children: [
                            ...homeProvider.news.asMap().entries.map((e) {
                              int index = e.key;
                              NewsModel item = e.value;

                              if (index < homeProvider.news.length - 1) {
                                return GestureDetector(
                                  onTap: () {
                                    // SchedulerBinding.instance
                                    //     .addPostFrameCallback((_) {

                                    Navigator.pushNamed(
                                        context, AppRoutes.articleScreen,
                                        arguments: ArticleArguments(
                                            item, homeProvider.userModel));

                                    // });
                                  },
                                  child: Column(
                                    children: [
                                      _post(context, news: item),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03),
                                    ],
                                  ),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.blue)));
                              }
                            }),
                          ],
                        );
                      }

                      return Center(
                          child: const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue)));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _post(
    BuildContext context, {
    required NewsModel news,
  }) {
    String getImagePath(String categories) {
      switch (categories) {
        case 'Sports':
          return ImageConstant.imgSport;
        case 'Technology':
          return ImageConstant.imgTech;
        case 'Entertainment':
          return ImageConstant.imgEntertain;
        case 'Politics':
          return ImageConstant.imgPolitics;
        case 'Health':
          return ImageConstant.imgHealth;
        case 'Education':
          return ImageConstant.imgEducation;
        default:
          return ImageConstant.imgPlaceholder141x92;
      }
    }

    String timestamp = news.updatedAt;
    DateTime date = DateTime.parse(timestamp).toLocal();
    String timeAgoString = timeAgo(date);

    return Container(
      decoration: AppDecoration.outlineBlueA2000f.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // img URL
          CustomImageView(
            imagePath: getImagePath(news.category),
            height: 141.v,
            width: 92.h,
            radius: BorderRadius.circular(
              16.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 21.v,
              right: 20.h,
              bottom: 19.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 139.h,
                  child: Text(
                    news.title,
                    style: CustomTextStyles.bodyMediumIndigoA40001,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 6.v),
                SizedBox(
                  width: 139.h,
                  child: Text(
                    news.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      height: 1.43,
                    ),
                  ),
                ),
                SizedBox(height: 19.v),
                Row(
                  children: [
                    SizedBox(
                      width: 118.h,
                      child: Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgTime,
                            height: 16.adaptSize,
                            width: 16.adaptSize,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6.h),
                            child: Text(
                              timeAgoString,
                              style: CustomTextStyles.bodySmallIndigo800,
                            ),
                          )
                        ],
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgBookmarkIndigoA40001,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.only(left: 29.h),
                    )
                  ],
                )
              ],
            ),
          )
        ],
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

          // articles display
          (news.length == 0) ? Text("There is no news") : ListNews(news: news)
        ],
      ),
    );
  }
}
