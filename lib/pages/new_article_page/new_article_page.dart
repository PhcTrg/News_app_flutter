import 'package:flutter/material.dart';
import 'package:news_reading/model/news_model.dart';
import 'package:news_reading/pages/argumennt/article_argument.dart';
import 'package:news_reading/provider/article_provider.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/widgets/custom_text_form_field.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'models/tags_item_model.dart';
import 'provider/new_article_provider.dart';
import 'widgets/tags_item_widget.dart'; // ignore_for_file: must_be_immutable

class NewArticlePage extends StatefulWidget {
  // final NewsModel? news;
  // NewArticlePage({this.news});

  const NewArticlePage({Key? key})
      : super(
          key: key,
        );

  @override
  NewArticlePageState createState() => NewArticlePageState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewArticleProvider(),
      child: NewArticlePage(),
    );
  }
}

class NewArticlePageState extends State<NewArticlePage> {
  var args;
  TextEditingController articleTitleController =
      TextEditingController(text: '');
  TextEditingController articleContentController = TextEditingController();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  bool isUpdate = false;

  // late Future<String> futureStatus;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      articleTitleController =
          TextEditingController(text: args.newsmodel?.title ?? '');
      articleContentController =
          TextEditingController(text: args.newsmodel?.content ?? '');
    }
    isUpdate = articleTitleController.text == '' ? false : true;
  }

  @override
  void dispose() {
    articleTitleController.dispose();
    articleContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(50.0),
        color: Colors.white,
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: Container(
            // decoration: AppDecoration.gradientWhiteAToGray5002,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Article Title",
                  style: CustomTextStyles.titleLargeBluegray90022,
                ),
                SizedBox(height: 15.v),
                CustomTextFormField(
                  controller: articleTitleController,
                  hintText: "Type your article title here...",
                  textInputType: TextInputType.emailAddress,
                  contentPadding: EdgeInsets.symmetric(horizontal: 1.h),
                  borderDecoration: TextFormFieldStyleHelper.underLineGray,
                  textStyle: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: 30.v),
                // _buildTags(context),
                // SizedBox(height: 33.v),
                Text(
                  "Article Content",
                  style: CustomTextStyles.titleMediumBluegray90022,
                ),
                SizedBox(height: 15.v),
                SizedBox(
                  width: 293.h,
                  child: CustomTextFormField(
                    controller: articleContentController,
                    hintText: "Type your article content here...",
                    textInputType: TextInputType.emailAddress,
                    contentPadding: EdgeInsets.symmetric(horizontal: 1.h),
                    borderDecoration: TextFormFieldStyleHelper.underLineGray,
                    maxLines: 8,
                    textStyle: theme.textTheme.bodyMedium!.copyWith(
                      height: 1.43,
                    ),
                  ),
                ),
                SizedBox(height: 15.v),
                Text(context.watch<ArticleProvider>().createStatus),
                // FutureBuilder<String>(
                //   future: ,
                //   builder: (context, data) {
                //     if (data.hasData) {
                //       return Text(data.data!);
                //     }

                //     return Text("Nothing happened");
                //   },
                // ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    if (!isUpdate) {
                      var articleProvider =
                          Provider.of<ArticleProvider>(context, listen: false);
                      var homeProvider =
                          Provider.of<HomeProvider>(context, listen: false);

                      articleProvider.addArticle(
                          articleTitleController.text,
                          articleContentController.text,
                          homeProvider.userModel.id);
                    } else {
                      var articleProvider =
                          Provider.of<ArticleProvider>(context, listen: false);

                      articleProvider.updateArticle(
                          articleTitleController.text,
                          articleContentController.text,
                          args.userModel.id,
                          args.newsmodel.id);
                    }
                  },
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  ),
                )
                // Divider(),
              ],
            ),
          ),
          // bottomNavigationBar: Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 7.h),
          //   child: _buildBottomBar(context),
          // ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "Article Manipulation",
        // margin: EdgeInsets.only(left: 10.h),
      ),
      actions: [
        // AppbarTrailingImage(
        //   imagePath: ImageConstant.imgDownload,
        //   margin: EdgeInsets.symmetric(
        //     horizontal: 40.h,
        //     vertical: 12.v,
        //   ),
        // )
      ],
    );
  }

  /// Section Widget
  Widget _buildTags(BuildContext context) {
    return Consumer<NewArticleProvider>(
      builder: (context, provider, child) {
        return Wrap(
          runSpacing: 30.55.v,
          spacing: 30.55.h,
          children: List<Widget>.generate(
            provider.newArticleModelObj.tagsItemList.length,
            (index) {
              TagsItemModel model =
                  provider.newArticleModelObj.tagsItemList[index];
              return TagsItemWidget(
                model,
                onSelectedChipView: (value) {
                  provider.onSelectedChipView(index, value);
                },
              );
            },
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
    );
  }
}
