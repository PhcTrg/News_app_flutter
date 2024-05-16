import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/widgets/app_bar/appbar_title.dart';
import 'package:news_reading/widgets/app_bar/appbar_title_image.dart';
import 'package:news_reading/widgets/app_bar/appbar_trailing_image.dart';
import 'package:news_reading/widgets/app_bar/custom_app_bar.dart';
import 'package:news_reading/widgets/custom_text_form_field.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';

var items = [
  'Author',
  'Publisher',
  'Reader',
];

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<LoginScreen> createState() => _MyAppState();
}

class _MyAppState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  String roleVal = items[0];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    roleVal = items[0];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void dropdownCallback(String? selectedVal) {
      if (selectedVal is String) {
        setState(() {
          roleVal = selectedVal;
        });
      }
    }

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28.0),
                      topRight: Radius.circular(28.0),
                    ),
                  ),
                  child: const TabBar(
                    // indicator: BoxDecoration(
                    //     // borderRadius: BorderRadius.circular(50),
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(50.0),
                    //       topRight: Radius.circular(50.0),
                    //     ),
                    //     color: Colors.blue),
                    // indicatorColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.blue,
                    labelStyle: TextStyle(
                      color: Colors.white, // change the color as needed
                    ),
                    dividerColor: Colors.blue,
                    // dividerHeight: 3,
                    tabs: [
                      Tab(text: "Login"),
                      Tab(text: "Sign up"),
                    ],
                  ),
                ),
              ),
            ),
            title: _iconTitle(context),
          ),
          body: TabBarView(
            children: [
              // Login tab
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50.h,
                          vertical: 50.v,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back",
                              style: theme.textTheme.headlineSmall,
                            ),
                            SizedBox(height: 14.v),
                            Text(
                              "Sign in with your account",
                              style: theme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 35.v),
                            userInput(
                                context,
                                "Username",
                                "Type your user name here...",
                                userNameController),
                            SizedBox(height: 20.v),
                            _buildPassword(
                                context, "Password", passwordController),
                            SizedBox(height: 30.v),
                            CustomElevatedButton(
                                text: "Login".toUpperCase(),
                                buttonTextStyle:
                                    CustomTextStyles.bodyLargeWhiteA700,
                                onPressed: () {
                                  setState(() {
                                    var homeProvider =
                                        Provider.of<HomeProvider>(context,
                                            listen: false);
                                    homeProvider.futureUser =
                                        homeProvider.postLogin(
                                            userNameController.text,
                                            passwordController.text);
                                  });
                                }),
                            SizedBox(height: 20.v),
                            Align(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Forgot your password? ",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      Text(
                                        "Reset here",
                                        style:
                                            CustomTextStyles.bodyMediumPrimary,
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(height: 32.v),
                            Center(
                              child: Text(
                                "Or sign in with".toUpperCase(),
                                style: CustomTextStyles.bodySmall_1,
                              ),
                            ),
                            SizedBox(height: 17.v),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: CustomImageView(
                                          width: 36.adaptSize,
                                          height: 36.adaptSize,
                                          imagePath: ImageConstant.imgGoogle,
                                        )),
                                    Spacer(
                                      flex: 50,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: CustomImageView(
                                          width: 36.adaptSize,
                                          height: 36.adaptSize,
                                          imagePath: ImageConstant.imgFacebook,
                                        )),
                                    Spacer(
                                      flex: 50,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: CustomImageView(
                                          width: 36.adaptSize,
                                          height: 36.adaptSize,
                                          color: appTheme.blue400,
                                          imagePath: ImageConstant.imgTrash,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 39.v)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Sign up tab
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50.h,
                          vertical: 50.v,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome to our app",
                              style: theme.textTheme.headlineSmall,
                            ),
                            SizedBox(height: 14.v),
                            Text(
                              "Sign up with your account",
                              style: theme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 35.v),
                            userInput(
                                context,
                                "Username",
                                "Type your user name here...",
                                userNameController),
                            SizedBox(height: 20.v),
                            _buildPassword(
                                context, "Password", passwordController),
                            SizedBox(height: 20.v),
                            _buildPassword(context, "Type your password again",
                                retypePasswordController),
                            SizedBox(height: 20.v),
                            userInput(context, "First name",
                                "Your first name...", firstnameController),
                            SizedBox(height: 20.v),
                            userInput(context, "Last name", "Your last name...",
                                lastnameController),
                            SizedBox(height: 20.v),
                            DropdownButton(
                              value: roleVal,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: dropdownCallback,
                            ),
                            SizedBox(height: 30.v),
                            CustomElevatedButton(
                                text: "Sign up".toUpperCase(),
                                buttonTextStyle:
                                    CustomTextStyles.bodyLargeWhiteA700,
                                onPressed: () {
                                  setState(() {
                                    var homeProvider =
                                        Provider.of<HomeProvider>(context,
                                            listen: false);
                                    homeProvider.postSignUp(
                                        userNameController.text,
                                        passwordController.text,
                                        firstnameController.text,
                                        lastnameController.text,
                                        roleVal);
                                  });
                                }),
                            Text(context.watch<HomeProvider>().signUpStatus),
                            SizedBox(height: 50.v),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "Login",
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

  Widget _iconTitle(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.v),
        Container(
          height: 30.v,
          width: 102.h,
          margin: EdgeInsets.only(right: 7.h),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 30.v,
                  width: 102.h,
                  decoration: BoxDecoration(
                    color: appTheme.blue800,
                    borderRadius: BorderRadius.circular(
                      6.h,
                    ),
                  ),
                ),
              ),
              AppbarTitleImage(
                imagePath: ImageConstant.imgBlog,
                margin: EdgeInsets.fromLTRB(5.h, 5.v, 6.h, 5.v),
              )
            ],
          ),
        ),
        SizedBox(height: 6.v),
        AppbarTitleImage(
          imagePath: ImageConstant.imgClub,
          margin: EdgeInsets.only(left: 22.h),
        )
      ],
    );
  }

  // Widget _buildUsername(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Username",
  //         style: theme.textTheme.bodyMedium,
  //       ),
  //       SizedBox(height: 13.v),
  //       CustomTextFormField(
  //         controller: userNameController,
  //         hintText: "Type your user name here...",
  //         textInputType: TextInputType.emailAddress,
  //         contentPadding: EdgeInsets.symmetric(horizontal: 1.h),
  //         borderDecoration: TextFormFieldStyleHelper.underLineGray,
  //       )
  //     ],
  //   );
  // }

  Widget _buildPassword(
      BuildContext context, String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 12.v),
        CustomTextFormField(
          controller: controller,
          hintText: "••••••••",
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          obscureText: true,
        )
      ],
    );
  }

  Widget userInput(BuildContext context, String title, String hintText,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 12.v),
        CustomTextFormField(
          controller: controller,
          hintText: hintText,
          textInputType: TextInputType.emailAddress,
          contentPadding: EdgeInsets.symmetric(horizontal: 1.h),
          borderDecoration: TextFormFieldStyleHelper.underLineGray,
        )
      ],
    );
  }
}
