import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/widgets/app_bar/appbar_title.dart';
import 'package:news_reading/widgets/app_bar/appbar_trailing_image.dart';
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
  TextEditingController codeController = TextEditingController();
  String roleVal = items[0];
  bool isCodeSended = false;
  bool firstUpdate = false;
  bool _buttonEnabled = true;

  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    isCodeSended = false;
    firstUpdate = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!firstUpdate) {
      context.watch<HomeProvider>().forgotpassStatus = "";
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    codeController.dispose();
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
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.blue,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      dividerColor: Colors.blue,
                      // dividerHeight: 3,
                      tabs: [
                        Tab(text: "Login"),
                        Tab(text: "Sign up"),
                        Tab(text: "   Forgot\nPassword"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            title: AppbarTitle(
              text: "Account",
              margin: EdgeInsets.only(left: 40.h),
            ),
            actions: [
              AppbarTrailingImage(
                imagePath: ImageConstant.imgUser,
                margin: EdgeInsets.fromLTRB(40.h, 11.v, 40.h, 12.v),
              )
            ],
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
                                "Email",
                                "Type your email name here...",
                                'email',
                                userNameController),
                            SizedBox(height: 20.v),
                            _buildPassword(context, "Password", 'password',
                                passwordController),
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
                            SizedBox(height: 180.v)
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
                                "Email",
                                "Type your email here...",
                                'email',
                                userNameController),
                            SizedBox(height: 20.v),
                            _buildPassword(context, "Password", 'password',
                                passwordController),
                            SizedBox(height: 20.v),
                            _buildPassword(context, "Type your password again",
                                'password', retypePasswordController),
                            SizedBox(height: 20.v),
                            userInput(
                                context,
                                "First name",
                                "Your first name...",
                                'firstName',
                                firstnameController),
                            SizedBox(height: 20.v),
                            userInput(context, "Last name", "Your last name...",
                                'lastName', lastnameController),
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

              // forgot password
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
                              "Forgot password",
                              style: theme.textTheme.headlineSmall,
                            ),
                            SizedBox(height: 14.v),

                            // new pass
                            (!isCodeSended)
                                ? (Column(
                                    children: [
                                      userInput(
                                          context,
                                          "Email",
                                          "Type your email here...",
                                          'email',
                                          userNameController),
                                      SizedBox(height: 20.v),
                                      CustomElevatedButton(
                                          text: "OK".toUpperCase(),
                                          buttonTextStyle: CustomTextStyles
                                              .bodyLargeWhiteA700,
                                          onPressed: () {
                                            setState(() {
                                              firstUpdate = true;
                                              var homeProvider =
                                                  Provider.of<HomeProvider>(
                                                      context,
                                                      listen: false);

                                              homeProvider.codeFuture =
                                                  homeProvider.getCodeForgot(
                                                      userNameController.text);
                                              isCodeSended = true;
                                            });
                                          }),
                                      SizedBox(height: 20.v),
                                    ],
                                  ))
                                : (FutureBuilder(
                                    future: context
                                        .watch<HomeProvider>()
                                        .codeFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Column(children: [
                                          _buildPassword(
                                              context,
                                              "New password",
                                              'password',
                                              passwordController),
                                          SizedBox(height: 30.v),
                                          userInput(
                                              context,
                                              "Code",
                                              "CODE here...",
                                              'code',
                                              codeController),
                                          SizedBox(height: 30.v),
                                          CustomElevatedButton(
                                            text: "OK".toUpperCase(),
                                            buttonTextStyle: CustomTextStyles
                                                .bodyLargeWhiteA700,
                                            onPressed: _buttonEnabled
                                                ? () {
                                                    setState(() {
                                                      var homeProvider =
                                                          Provider.of<
                                                                  HomeProvider>(
                                                              context,
                                                              listen: false);
                                                      homeProvider
                                                          .resetPassword(
                                                              userNameController
                                                                  .text,
                                                              codeController
                                                                  .text,
                                                              passwordController
                                                                  .text);
                                                      _buttonEnabled =
                                                          false; // disable the button
                                                    });
                                                  }
                                                : null, // disable the button when _buttonEnabled is false
                                          ),
                                        ]);
                                      }

                                      return Center(
                                          child:
                                              const CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.blue)));
                                    },
                                  )),

                            Center(
                              child: Text(context
                                  .watch<HomeProvider>()
                                  .forgotpassStatus),
                            ),

                            SizedBox(height: 280.v)
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

  Widget _buildPassword(
    BuildContext context,
    String title,
    String keyString,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 12.v),
        CustomTextFormField(
          key: Key(keyString),
          controller: controller,
          hintText: "••••••••",
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          obscureText: true,
        )
      ],
    );
  }

  Widget userInput(
    BuildContext context,
    String title,
    String hintText,
    String keyString,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 12.v),
        CustomTextFormField(
          key: Key(keyString),
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
