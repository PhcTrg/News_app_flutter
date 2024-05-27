import 'package:flutter/material.dart';
import 'package:news_reading/core/app_export.dart';
import 'package:news_reading/model/news_model.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/widgets/app_bar/appbar_title.dart';
import 'package:news_reading/widgets/app_bar/appbar_trailing_image.dart';
import 'package:news_reading/widgets/app_bar/custom_app_bar.dart';
import 'package:news_reading/widgets/list_view_post.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key})
      : super(
          key: key,
        );

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<NewsModel>> futureNews;
  TextEditingController searchController = TextEditingController();

  bool firstUpdate = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    futureNews = context.read<HomeProvider>().getNewsData();
    firstUpdate = false;
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    PreferredSizeWidget _buildAppBar(BuildContext context) {
      return CustomAppBar(
        title: AppbarTitle(
          text: "Posts",
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

    Widget _buildColumnMyPosts(BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 20.v,
        ),
        decoration: AppDecoration.outlineBlueA2000f1.copyWith(
          borderRadius: BorderRadiusStyle.customBorderTL28,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            fetchData();
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // search bar
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      context
                          .read<HomeProvider>()
                          .searchArticle(input: searchController.text);
                    },
                  ),
                  hintText: 'Enter article title',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(15.0),
                ),
              ),

              SizedBox(height: 10),

              // articles display
              (context.watch<HomeProvider>().news.length == 0)
                  ? Text("There is no news")
                  : ListNews(news: context.watch<HomeProvider>().news)
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: _buildAppBar(context),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  width: 500,
                  height: 700,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(bottom: bottom),
                  child: Stack(
                    children: [
                      //article here

                      FutureBuilder<List<NewsModel>>(
                          future: futureNews,
                          builder: (context, data) {
                            if (data.hasData) {
                              if (!firstUpdate) {
                                context.watch<HomeProvider>().news = data.data!;
                                firstUpdate = true;
                              }

                              return _buildColumnMyPosts(context);
                            }

                            return Center(
                                child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue)));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
