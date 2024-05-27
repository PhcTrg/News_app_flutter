import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:news_reading/argumennt/user_argument.dart';
import 'package:news_reading/model/news_model.dart';
import 'package:news_reading/model/user_model.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/widgets/list_view_post_update.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
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
  late Future<String> futureFollowers;
  late Future<String> futureFollowing;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    futureUser = context
        .read<HomeProvider>()
        .postUserInfo(context.read<HomeProvider>().userModel.id);
    futureNews = context
        .read<ProfileProvider>()
        .getNewsData(context.read<HomeProvider>().userModel.id);

    futureFollowers = context
        .read<ProfileProvider>()
        .getFollower(context.read<HomeProvider>().userModel.id);
    futureFollowing = context
        .read<ProfileProvider>()
        .getFollowing(context.read<HomeProvider>().userModel.id);
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
                      child: RefreshIndicator(
                        onRefresh: () async {
                          fetchData();
                        },
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 84.adaptSize,
                                                        width: 84.adaptSize,
                                                        padding:
                                                            EdgeInsets.all(6.h),
                                                        decoration:
                                                            AppDecoration
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
                                                        padding:
                                                            EdgeInsets.only(
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
                                                              data.data!
                                                                  .firstName
                                                                  .toUpperCase(),
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            ),
                                                            SizedBox(
                                                                height: 5.v),
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
                                                                  EdgeInsets
                                                                      .only(
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
                                                                  EdgeInsets
                                                                      .only(
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
                                    FutureBuilder<List<NewsModel>>(
                                      future: futureNews,
                                      builder: (context, data) {
                                        if (data.hasData) {
                                          return _buildColumnMyPosts(
                                              context, data.data!);
                                        }

                                        return Center(
                                            child:
                                                const CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.blue)));
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
              ),
            );
          }

          return Center(
              child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
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

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "Profile",
        margin: EdgeInsets.all(20),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              customButton: const Icon(
                Icons.list,
                size: 46,
                color: Colors.black,
              ),
              items: [
                ...MenuItems.firstItems.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item),
                  ),
                ),
                const DropdownMenuItem<Divider>(
                    enabled: false, child: Divider()),
                ...MenuItems.secondItems.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item),
                  ),
                ),
              ],
              onChanged: (value) {
                MenuItems.onChanged(context, value! as MenuItem);
              },
              dropdownStyleData: DropdownStyleData(
                width: 160,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                offset: const Offset(0, 8),
              ),
              menuItemStyleData: MenuItemStyleData(
                customHeights: [
                  ...List<double>.filled(MenuItems.firstItems.length, 48),
                  8,
                  ...List<double>.filled(MenuItems.secondItems.length, 48),
                ],
                padding: const EdgeInsets.only(left: 16, right: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// menu item class
class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  // static const List<MenuItem> firstItems = [home, share, settings];
  static const List<MenuItem> firstItems = [profileDetails];
  static const List<MenuItem> secondItems = [logout];

  // static const home = MenuItem(text: 'Home', icon: Icons.home);
  // static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const profileDetails =
      MenuItem(text: 'Profile Edit', icon: Icons.person);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.blue, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  // on change for app bar option click
  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.profileDetails:
        {
          var homeProvider = Provider.of<HomeProvider>(context, listen: false);

          Navigator.pushNamed(context, AppRoutes.profileDetails,
              arguments: UserArgument(homeProvider.userModel));
        }
        break;
      case MenuItems.logout:
        context.read<HomeProvider>().userLogout();
        break;
    }
  }
}
