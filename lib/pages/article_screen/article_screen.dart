import 'package:flutter/material.dart';
import 'package:news_reading/model/news_model.dart';
import 'package:news_reading/pages/argumennt/article_argument.dart';
import 'package:news_reading/provider/article_provider.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/widgets/app_bar/appbar_leading_image.dart';
import 'package:news_reading/widgets/app_bar/appbar_trailing_image.dart';
import 'package:news_reading/widgets/app_bar/custom_app_bar.dart';
import '../../core/app_export.dart';

import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key})
      : super(
          key: key,
        );

  @override
  ArticleScreenState createState() => ArticleScreenState();

  static Widget builder(BuildContext context, NewsModel news) {
    return ChangeNotifierProvider(
      create: (context) => ArticleProvider(),
      child: ArticleScreen(),
    );
  }
}

enum TtsState { playing, stopped, paused, continued }

class ArticleScreenState extends State<ArticleScreen> {
  //text to speech
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 1.0;
  double pitch = 1.0;
  double rate = 1.0;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  bool get isPlaying => ttsState == TtsState.playing;
  bool get isStopped => ttsState == TtsState.stopped;
  bool get isPaused => ttsState == TtsState.paused;
  bool get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  final translator = GoogleTranslator();

  var args;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();

  Future<String>? _futureSummarize;

  @override
  void initState() {
    super.initState();
    initTts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as ArticleArguments;
    context.watch<ArticleProvider>().articleContent = args.newsmodel.content;
    context.watch<ArticleProvider>().contentLanguage = "en-US";

    changeSpeechLanguage(args.newsmodel.content,
        context.watch<ArticleProvider>().contentLanguage);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  // text to speech
  void changeSpeechLanguage(String textVal, String language) {
    setState(() {
      _newVoiceText = textVal;
    });
    flutterTts.setLanguage(language);
  }

  void translate(String to) {
    translator
        .translate(context.read<ArticleProvider>().articleContent, to: to)
        .then((result) {
      setState(() {
        context.read<ArticleProvider>().articleContent = result.text;
        changeSpeechLanguage(
            result.text, context.read<ArticleProvider>().contentLanguage);
        print(context.read<ArticleProvider>().contentLanguage);
      });
    });
  }

  void onClickChangeLanguage() {
    if (context.read<ArticleProvider>().contentLanguage == "en-US") {
      context.read<ArticleProvider>().contentLanguage = "vi-VN";
      translate("vi");
    } else {
      context.read<ArticleProvider>().contentLanguage = "en-US";
      translate("en");
    }
  }

  dynamic initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });

    // flutterTts.setLanguage(language)
  }

  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future<void> _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future<void> _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts.speak(_newVoiceText!);
      }
    }
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future<void> _pause() async {
    if (isPlaying) {
      var result = await flutterTts.pause();
      if (result == 1) setState(() => ttsState = TtsState.paused);
    }
  }

  void _handleSubmittedComment() {
    setState(() {
      // handle submit
      var articleProvider =
          Provider.of<ArticleProvider>(context, listen: false);

      articleProvider.addComment(
          _commentController.text, args.userModel.id, args.newsmodel.id);
      _commentController.clear(); // Clear the input field
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: EdgeInsets.only(bottom: bottom),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 13.v),
                  Container(
                    width: 295.h,
                    margin: EdgeInsets.only(
                      left: 40.h,
                      right: 39.h,
                    ),
                    child: Text(
                      args.newsmodel.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(height: 33.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 39.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(10))),
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "lbl_richard_gervain".tr,
                                style: CustomTextStyles.bodyMediumIndigo800_1,
                              ),
                              SizedBox(height: 5.v),
                              Padding(
                                padding: EdgeInsets.only(left: 3.h),
                                child: Text(
                                  "lbl_2m_ago".tr,
                                  style:
                                      CustomTextStyles.bodySmallBluegray400_1,
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        CustomImageView(
                          imagePath: ImageConstant.imgSend,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          margin: EdgeInsets.only(
                            top: 7.v,
                            bottom: 8.v,
                          ),
                          color: Colors.blue,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 23.v),
                  SizedBox(
                    height: 508.v,
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.h),
                                decoration:
                                    AppDecoration.outlineBlueAF.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.customBorderTL28,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgImage,
                                        height: 219.v,
                                        width: 375.h,
                                        radius: BorderRadius.circular(8.0),
                                        alignment: Alignment.topCenter,
                                      ),
                                      SizedBox(height: 13.v),
                                      Container(
                                        width: 293.h,
                                        margin: EdgeInsets.only(right: 84.h),
                                        child: Text(
                                          "Content",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(
                                            height: 1.11,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 13.v),
                                      SizedBox(
                                        width: 293.h,
                                        child: Text(
                                          context
                                              .read<ArticleProvider>()
                                              .articleContent,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyles
                                              .bodyMediumIndigo800_1
                                              .copyWith(
                                            height: 1.43,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 13.v),

                                      // summary
                                      _summarySection(),
                                      SizedBox(height: 13.v),

                                      // text to speech
                                      _soundBar(),
                                      SizedBox(height: 13.v),

                                      // comment
                                      Container(
                                        width: 293.h,
                                        margin: EdgeInsets.only(right: 84.h),
                                        child: Text(
                                          "Comment Section",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(
                                            height: 1.11,
                                          ),
                                        ),
                                      ),

                                      (args.userModel.id != 0)
                                          ? (_commentSection())
                                          : Center(
                                              child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: (Text(
                                                  "Please login to comment")),
                                            )),
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
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(const Radius.circular(10))),
          child: IconButton(
            icon: Icon(Icons.translate),
            onPressed: onClickChangeLanguage,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _commentSection() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                ),
                onChanged: (newComment) {
                  // Handle user input here (optional)
                  // Store the new comment in a variable (if needed)
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(const Radius.circular(10))),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _handleSubmittedComment,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      Center(
        child: Text(context.watch<ArticleProvider>().createCommentStatus),
      ),
      SizedBox(
        width: 293.h,
        height: (args.newsmodel.comments?.length ?? 0) * 150.v,
        child: ListView.builder(
          itemCount: args.newsmodel.comments?.length ?? 0,
          itemBuilder: (context, index) {
            final comment = args.newsmodel.comments![index];
            return ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(const Radius.circular(10))),
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: Text('${comment.user.toString()}'),
              subtitle: Text(comment.content),
            );
          },
        ),
      ),
    ]);
  }

  Widget _summarySection() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _futureSummarize = context
                    .read<ArticleProvider>()
                    .summarizeArticle(
                        context.read<ArticleProvider>().articleContent);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Summarize',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(height: 8), // Add some spacing
        if (_futureSummarize != null)
          FutureBuilder<String>(
            future: _futureSummarize,
            builder: (context, data) {
              if (data.hasData) {
                return Text(data.data!);
              }
              return Center(child: const CircularProgressIndicator());
            },
          ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 72.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgChevronLeft,
        margin: EdgeInsets.only(
          left: 40.h,
          top: 12.v,
          bottom: 12.v,
        ),
        onTap: () {
          onTapChevronleftone(context);
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

  Widget _soundBar() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(Colors.white, Colors.greenAccent,
                Icons.play_arrow, 'PLAY', _speak),
            _buildButtonColumn(
                Colors.white, Colors.redAccent, Icons.stop, 'STOP', _stop),
            _buildButtonColumn(
                Colors.white, Colors.blueAccent, Icons.pause, 'PAUSE', _pause),
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon, size: 30),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
        ]);
  }

  /// Navigates to the previous screen.
  onTapChevronleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}
