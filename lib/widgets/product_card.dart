import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_reading/core/app_export.dart';
import 'package:news_reading/model/news_model.dart';

class ProductCard extends StatelessWidget {
  final NewsModel news;

  ProductCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.outlineBlueA2000f.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgPlaceholder141x92,
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
                Text(
                  news.title,
                  style: CustomTextStyles.bodyMediumIndigoA40001,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),

                //

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
                    // softWrap: false,
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
                            imagePath: ImageConstant.imgThumbsIndigo800,
                            height: 16.adaptSize,
                            width: 16.adaptSize,
                            margin: EdgeInsets.only(bottom: 1.v),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 6.h,
                              bottom: 1.v,
                            ),
                            child: Text(
                              "2.1k",
                              style: CustomTextStyles.bodySmallIndigo800,
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgTime,
                            height: 16.adaptSize,
                            width: 16.adaptSize,
                            margin: EdgeInsets.only(
                              left: 19.h,
                              bottom: 1.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6.h),
                            child: Text(
                              "1hr ago",
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
          ),
        ],
      ),
    );
  }
}
