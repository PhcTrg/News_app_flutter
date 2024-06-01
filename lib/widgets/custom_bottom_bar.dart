// this page is used to manage theme and color and custom widget
// Responsibilities: Nguyen Phuoc Truong

import 'package:flutter/material.dart';
import '../core/app_export.dart';

enum BottomBarEnum { Closewhitea700, Imagewhitea700, Play, Align, Link, Scale }
// ignore_for_file: must_be_immutable

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgCloseWhiteA700,
      activeIcon: ImageConstant.imgCloseWhiteA700,
      type: BottomBarEnum.Closewhitea700,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgImageWhiteA700,
      activeIcon: ImageConstant.imgImageWhiteA700,
      type: BottomBarEnum.Imagewhitea700,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgPlay,
      activeIcon: ImageConstant.imgPlay,
      type: BottomBarEnum.Play,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgAlign,
      activeIcon: ImageConstant.imgAlign,
      type: BottomBarEnum.Align,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgLink,
      activeIcon: ImageConstant.imgLink,
      type: BottomBarEnum.Link,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgScale,
      activeIcon: ImageConstant.imgScale,
      type: BottomBarEnum.Scale,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.v,
      decoration: BoxDecoration(
        color: appTheme.blueGray900,
        borderRadius: BorderRadius.circular(
          24.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black90026,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              13,
            ),
          )
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: bottomMenuList[index].icon,
              height: 40.adaptSize,
              width: 40.adaptSize,
              color: appTheme.whiteA700,
            ),
            activeIcon: CustomImageView(
              imagePath: bottomMenuList[index].activeIcon,
              height: 24.adaptSize,
              width: 24.adaptSize,
              color: appTheme.gray5001,
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

class BottomMenuModel {
  BottomMenuModel(
      {required this.icon, required this.activeIcon, required this.type});

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
