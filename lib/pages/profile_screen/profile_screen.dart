import 'package:flutter/material.dart';
import 'package:news_reading/model/news_model.dart';
import 'package:news_reading/model/user_model.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/widgets/list_view_post_update.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../provider/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key})
      : super(
          key: key,
        );

  @override
  ProfileScreenState createState() => ProfileScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: ProfileScreen(),
    );
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  late Future<UserModel> futureUser;
  late Future<List<NewsModel>> futureNews;

  @override
  void initState() {
    super.initState();
    futureUser = context
        .read<HomeProvider>()
        .postUserInfo(context.read<HomeProvider>().userModel.id);
    futureNews = context
        .read<ProfileProvider>()
        .getNewsData(context.read<HomeProvider>().userModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: futureUser,
        builder: (context, data) {
          if (data.hasData) {
            return SafeArea(
              child: Scaffold(
                appBar: _buildAppBar(context),
                body: SizedBox(
                  width: SizeUtils.width,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 6.v),
                    child: SizedBox(
                      height: 905.v,
                      width: double.maxFinite,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              decoration:
                                  AppDecoration.gradientWhiteAToGray5002,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 15.v),
                                  SizedBox(
                                    height: 318.v,
                                    width: 295.h,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            padding: EdgeInsets.all(32.h),
                                            decoration: AppDecoration
                                                .outlineBlueA2000f
                                                .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder16,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 84.adaptSize,
                                                      width: 84.adaptSize,
                                                      padding:
                                                          EdgeInsets.all(6.h),
                                                      decoration: AppDecoration
                                                          .outline
                                                          .copyWith(
                                                        borderRadius:
                                                            BorderRadiusStyle
                                                                .roundedBorder28,
                                                      ),
                                                      child: CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgPlaceholder,
                                                        height: 66.adaptSize,
                                                        width: 66.adaptSize,
                                                        radius: BorderRadius
                                                            .circular(
                                                          22.h,
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 24.h,
                                                        bottom: 6.v,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                              height: 15.v),
                                                          Text(
                                                            data.data!.firstName
                                                                .toUpperCase(),
                                                            style: theme
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                          SizedBox(height: 5.v),
                                                          Text(
                                                            data.data!.role
                                                                .toUpperCase(),
                                                            style: CustomTextStyles
                                                                .bodyLargeIndigoA40001,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 22.v),
                                                Text(
                                                  "lbl_about_me".tr,
                                                  style: CustomTextStyles
                                                      .bodyLarge16,
                                                ),
                                                SizedBox(height: 11.v),
                                                SizedBox(
                                                  width: 214.h,
                                                  child: Text(
                                                    "msg_madison_blackstone".tr,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: CustomTextStyles
                                                        .bodyMediumIndigo800_1
                                                        .copyWith(
                                                      height: 1.43,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20.v)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: SizedBox(
                                            height: 68.v,
                                            width: 231.h,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    decoration: AppDecoration
                                                        .fillIndigoA
                                                        .copyWith(
                                                      borderRadius:
                                                          BorderRadiusStyle
                                                              .roundedBorder12,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 25.h,
                                                            vertical: 9.v,
                                                          ),
                                                          decoration:
                                                              AppDecoration
                                                                  .fillBlue
                                                                  .copyWith(
                                                            borderRadius:
                                                                BorderRadiusStyle
                                                                    .roundedBorder12,
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "lbl_52".tr,
                                                                style: theme
                                                                    .textTheme
                                                                    .titleLarge,
                                                              ),
                                                              // SizedBox(height: 3.v),
                                                              Text(
                                                                "lbl_post".tr,
                                                                style: CustomTextStyles
                                                                    .bodySmallMulishWhiteA700,
                                                              ),
                                                              // SizedBox(height: 2.v)
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 11.h,
                                                              top: 5.v,
                                                              bottom: 5.v,
                                                            ),
                                                            child:
                                                                _buildFollowers(
                                                              context,
                                                              rating:
                                                                  "lbl_250".tr,
                                                              followersCount:
                                                                  "lbl_following"
                                                                      .tr,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 11.h,
                                                              top: 5.v,
                                                              bottom: 5.v,
                                                            ),
                                                            child:
                                                                _buildFollowers(
                                                              context,
                                                              rating:
                                                                  "lbl_4_5k".tr,
                                                              followersCount:
                                                                  "lbl_followers"
                                                                      .tr,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15.v),
                                  FutureBuilder<List<NewsModel>>(
                                    future: futureNews,
                                    builder: (context, data) {
                                      if (data.hasData) {
                                        return _buildColumnMyPosts(
                                            context, data.data!);
                                      }

                                      return Center(
                                          child:
                                              const CircularProgressIndicator());
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return Center(child: const CircularProgressIndicator());
        });
  }

  Widget _buildColumnMyPosts(BuildContext context, List<NewsModel> newsList) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.h,
        vertical: 20.v,
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
                "lbl_my_posts".tr,
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
          ListNewsUpdate(news: newsList)
        ],
      ),
    );
  }

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

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "lbl_profile".tr,
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
}
