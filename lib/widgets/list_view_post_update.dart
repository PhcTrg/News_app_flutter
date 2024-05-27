import 'package:flutter/material.dart';
import 'package:news_reading/core/app_export.dart';
import 'package:news_reading/model/news_model.dart';
import 'package:news_reading/argumennt/article_argument.dart';
import 'package:news_reading/provider/home_provider.dart';

class ListNewsUpdate extends StatelessWidget {
  final List<NewsModel> news;

  ListNewsUpdate({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height * 0.6, // Adjust the height
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: news.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.newArticlePage,
                  arguments:
                      ArticleArguments(news[index], homeProvider.userModel));
            },
            child: Column(
              children: [
                _post(context, news: news[index]),
                SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.03), // Adjust the spacing
              ],
            ),
          );
        },
      ),
    );
  }
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
                ),
              ),
              SizedBox(height: 6.v),
              SizedBox(
                width: 139.h,
                child: Text(
                  news.content,
                  maxLines: 2,
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
                        // CustomImageView(
                        //   imagePath: ImageConstant.imgThumbsIndigo800,
                        //   height: 16.adaptSize,
                        //   width: 16.adaptSize,
                        //   margin: EdgeInsets.only(bottom: 1.v),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     left: 6.h,
                        //     bottom: 1.v,
                        //   ),
                        //   child: Text(
                        //     "lbl_2_1k".tr,
                        //     style: CustomTextStyles.bodySmallIndigo800,
                        //   ),
                        // ),
                        CustomImageView(
                          imagePath: ImageConstant.imgTime,
                          height: 16.adaptSize,
                          width: 16.adaptSize,
                          // margin: EdgeInsets.only(
                          //   left: 19.h,
                          //   bottom: 1.v,
                          // ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6.h),
                          child: Text(
                            "lbl_1hr_ago".tr,
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
