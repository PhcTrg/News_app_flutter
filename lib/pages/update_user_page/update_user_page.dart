import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_reading/argumennt/user_argument.dart';
import 'package:news_reading/core/app_export.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/widgets/app_bar/appbar_trailing_image.dart';
import 'package:news_reading/widgets/app_bar/custom_app_bar.dart';
import 'package:news_reading/widgets/custom_elevated_button.dart';
import 'package:news_reading/widgets/custom_text_form_field.dart';

var items = [
  'Author',
  'Publisher',
  'Reader',
];

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  // TextEditingController userNameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  String roleVal = items[0];

  var args;

  @override
  void initState() {
    // args = ModalRoute.of(context)!.settings.arguments as UserArgument;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as UserArgument;
    // userNameController = TextEditingController(text: args.userModel.firstName);
    firstnameController = TextEditingController(text: args.userModel.firstName);
    lastnameController = TextEditingController(text: args.userModel.lastName);
    roleVal = args.userModel.role;
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

    PreferredSizeWidget _buildAppBar(BuildContext context) {
      return CustomAppBar(
        leadingWidth: 72.h,
        leading: AppbarTrailingImage(
          imagePath: ImageConstant.imgChevronLeft,
          margin: EdgeInsets.only(
            left: 40.h,
            top: 12.v,
            bottom: 12.v,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          AppbarTrailingImage(
            imagePath: ImageConstant.imgOverflow,
            margin: EdgeInsets.symmetric(
              horizontal: 40.h,
              vertical: 12.v,
            ),
          )
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your user details goes here",
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 14.v),
                  userInput(context, "First name", "Your first name...",
                      firstnameController),
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
                      text: "Submit".toUpperCase(),
                      buttonTextStyle: CustomTextStyles.bodyLargeWhiteA700,
                      onPressed: () {
                        setState(() {
                          // update user

                          // var homeProvider =
                          //     Provider.of<HomeProvider>(context,
                          //         listen: false);
                          // homeProvider.postSignUp(
                          //     userNameController.text,
                          //     passwordController.text,
                          //     firstnameController.text,
                          //     lastnameController.text,
                          //     roleVal);
                        });
                      }),
                  Text(context.watch<HomeProvider>().signUpStatus),
                  CustomElevatedButton(
                      text: "Go back to home Page".toUpperCase(),
                      buttonTextStyle: CustomTextStyles.bodyLargeWhiteA700,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  Text(context.watch<HomeProvider>().signUpStatus),
                  SizedBox(height: 100.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
