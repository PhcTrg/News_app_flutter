import 'package:flutter/material.dart';
import 'package:news_reading/argumennt/userid_argument.dart';
import 'package:news_reading/core/app_export.dart';
import 'package:news_reading/model/user_model.dart';
import 'package:news_reading/provider/article_provider.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/provider/profile_provider.dart';
import 'package:news_reading/widgets/app_bar/appbar_leading_image.dart';
import 'package:news_reading/widgets/app_bar/appbar_title.dart';
import 'package:news_reading/widgets/app_bar/custom_app_bar.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArticleProvider(),
      child: UserProfile(),
    );
  }
}

class _UserProfileState extends State<UserProfile> {
  var args;
  late Future<UserModel> futureUser;
  late Future<String> futureFollowers;
  late Future<String> futureFollowing;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as UserIdArgument;
    // futureUser = context.read<HomeProvider>().postUserInfo(args.userId);

    futureFollowers = context.read<ProfileProvider>().getFollower(args.userId);
    futureFollowing = context.read<ProfileProvider>().getFollowing(args.userId);

    super.didChangeDependencies();
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
                                  // user infomation
                                  SizedBox(height: 15.v),
                                  SizedBox(
                                    height: 200.v,
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
                                                              future:
                                                                  futureFollowers,
                                                              followString:
                                                                  "Followers",
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
                                                              future:
                                                                  futureFollowing,
                                                              followString:
                                                                  "Following",
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

                                  // articles
                                  // FutureBuilder<List<NewsModel>>(
                                  //   future: futureNews,
                                  //   builder: (context, data) {
                                  //     if (data.hasData) {
                                  //       return _buildColumnMyPosts(
                                  //           context, data.data!);
                                  //     }

                                  //     return Center(
                                  //         child:
                                  //             const CircularProgressIndicator());
                                  //   },
                                  // )
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

          return Center(
              child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
        });

    // SafeArea(
    //   child: Scaffold(body: Text(args.userId.toString())),
    // );
  }

  Widget _buildFollowers(
    BuildContext context, {
    required Future<String> future,
    required String followString,
  }) {
    return Column(
      children: [
        FutureBuilder<String>(
          future: future,
          builder: (context, data) {
            return Text(
              data.hasData ? data.data! : "-",
              style: theme.textTheme.titleLarge!.copyWith(
                color: appTheme.whiteA700,
              ),
            );
          },
        ),
        SizedBox(height: 3.v),
        Text(
          followString,
          style: CustomTextStyles.bodySmallMulishWhiteA700.copyWith(
            color: appTheme.whiteA700.withOpacity(0.87),
          ),
        )
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 100.h,
      leading: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.black,
          ),
          SizedBox(width: 10),
          Text(
            "Profile",
            style: theme.textTheme.bodyLarge,
          )
        ],
      ),
      // actions: [],
    );
  }
}
