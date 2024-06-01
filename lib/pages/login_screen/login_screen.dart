import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_reading/core/token_decode.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/widgets/app_bar/appbar_title.dart';
import 'package:news_reading/widgets/app_bar/appbar_trailing_image.dart';
import 'package:news_reading/widgets/button.dart';
import 'package:news_reading/widgets/custom_text_form_field.dart';
import '../../core/app_export.dart';
import 'package:http/http.dart' as http;

var items = [
  'Author',
  'Publisher',
  'Reader',
];

class LoginPage extends StatelessWidget {
  LoginPage({Key? key})
      : super(
          key: key,
        );

//   @override
//   State<LoginScreen> createState() => _MyAppState();
// }

// class _MyAppState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String roleVal = items[0];
  String _loginStatus = "";
  bool isCodeSended = false;
  // bool firstUpdate = false;
  bool _buttonEnabled = true;

  // late Future<String>? codeFuture;
  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  // isCodeSended = false;
  //   // firstUpdate = false;
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   if (!firstUpdate) {
  //     context.watch<HomeProvider>().forgotpassStatus = "";
  //   }
  // }

  // @override
  // void dispose() {
  //   userNameController.dispose();
  //   passwordController.dispose();
  //   retypePasswordController.dispose();
  //   firstnameController.dispose();
  //   lastnameController.dispose();
  //   codeController.dispose();
  //   roleVal = items[0];
  //   super.dispose();
  // }

  Future<void> postUserInfo(BuildContext context, int id) async {
    final response = await http.get(
      Uri.parse('http://$url/api/users/$id'),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      context.read<HomeProvider>().setUserModel(
          responseData['id'],
          responseData['first_name'],
          responseData['last_name'],
          responseData['role']);
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> postLogin(
      BuildContext context, String userName, String password) async {
    final response = await http.post(
      Uri.parse('http://$url/api/login/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, dynamic>{
        "username": userName,
        "password": password,
      }),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      context.read<HomeProvider>().setLoginStatus(true);

      // decode token
      final userId =
          TokenDecode().parseJwtPayLoad(responseData['access'])['user_id'];

      //Login Successful
      context.read<HomeProvider>().setLoginStatus(true);
      await postUserInfo(context, userId);

      _loginStatus = "Login Successfully";
    } else {
      _loginStatus = "Invalid user name or password";
    }
  }

  void handleLogin(BuildContext context) async {
    await postLogin(context, userNameController.text, passwordController.text);
  }

  void handleGoHomeAndPassLoginStatus() {
    // go home
  }

  @override
  Widget build(BuildContext context) {
    void dropdownCallback(String? selectedVal) {
      if (selectedVal is String) {
        // setState(() {
        roleVal = selectedVal;
        // });
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
                                "Username",
                                "Type your user name here...",
                                userNameController),
                            SizedBox(height: 20.v),
                            _buildPassword(
                                context, "Password", passwordController),
                            SizedBox(height: 30.v),
                            MainButton(
                                btnText: "LOGIN",
                                onPressedFunc: () => handleLogin(context)),
                            SizedBox(height: 20.v),
                            MainButton(
                                btnText: "GO HOME",
                                onPressedFunc: handleGoHomeAndPassLoginStatus),
                            SizedBox(height: 20.v),
                            Center(child: Text(_loginStatus)),
                            SizedBox(height: 32.v),
                            // Center(
                            //   child: Text(
                            //     "Or sign in with".toUpperCase(),
                            //     style: CustomTextStyles.bodySmall_1,
                            //   ),
                            // ),
                            // SizedBox(height: 17.v),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 10, right: 10),
                            //   child: Center(
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         IconButton(
                            //             onPressed: () {},
                            //             icon: CustomImageView(
                            //               width: 36.adaptSize,
                            //               height: 36.adaptSize,
                            //               imagePath: ImageConstant.imgGoogle,
                            //             )),
                            //         Spacer(
                            //           flex: 50,
                            //         ),
                            //         IconButton(
                            //             onPressed: () {},
                            //             icon: CustomImageView(
                            //               width: 36.adaptSize,
                            //               height: 36.adaptSize,
                            //               imagePath: ImageConstant.imgFacebook,
                            //             )),
                            //         Spacer(
                            //           flex: 50,
                            //         ),
                            //         IconButton(
                            //             onPressed: () {},
                            //             icon: CustomImageView(
                            //               width: 36.adaptSize,
                            //               height: 36.adaptSize,
                            //               color: appTheme.blue400,
                            //               imagePath: ImageConstant.imgTrash,
                            //             )),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 150.v)
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
                            MainButton(
                                btnText: "Sign up".toUpperCase(),
                                onPressedFunc: () {
                                  // setState(() {
                                  var homeProvider = Provider.of<HomeProvider>(
                                      context,
                                      listen: false);
                                  homeProvider.postSignUp(
                                      userNameController.text,
                                      passwordController.text,
                                      firstnameController.text,
                                      lastnameController.text,
                                      roleVal);
                                  // });
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
                                          userNameController),
                                      SizedBox(height: 20.v),
                                      MainButton(
                                          btnText: "OK",
                                          onPressedFunc: () {
                                            // setState(() {
                                            // firstUpdate = true;
                                            var homeProvider =
                                                Provider.of<HomeProvider>(
                                                    context,
                                                    listen: false);

                                            homeProvider.codeFuture =
                                                homeProvider.getCodeForgot(
                                                    userNameController.text);
                                            isCodeSended = true;
                                            // }
                                            // );
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
                                              passwordController),
                                          SizedBox(height: 30.v),
                                          userInput(context, "Code",
                                              "CODE here...", codeController),
                                          SizedBox(height: 30.v),
                                          MainButton(
                                            btnText: "OK".toUpperCase(),
                                            onPressedFunc: _buttonEnabled
                                                ? () {
                                                    // setState(() {
                                                    var homeProvider = Provider
                                                        .of<HomeProvider>(
                                                            context,
                                                            listen: false);
                                                    homeProvider.resetPassword(
                                                        userNameController.text,
                                                        codeController.text,
                                                        passwordController
                                                            .text);
                                                    _buttonEnabled =
                                                        false; // disable the button
                                                    // });
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
