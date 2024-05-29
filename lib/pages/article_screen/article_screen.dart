import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_reading/argumennt/userid_argument.dart';
import 'package:news_reading/model/news_model.dart';
import 'package:news_reading/argumennt/article_argument.dart';
import 'package:news_reading/provider/article_provider.dart';
import 'package:news_reading/provider/profile_provider.dart';
import 'package:news_reading/widgets/app_bar/appbar_leading_image.dart';
import 'package:news_reading/widgets/app_bar/appbar_trailing_image.dart';
import 'package:news_reading/widgets/app_bar/custom_app_bar.dart';
import 'package:news_reading/widgets/button.dart';
import 'package:news_reading/widgets/contentCard.dart';
import '../../core/app_export.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';
import 'package:image/image.dart' as img;

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

  // bool isFollow = false;

  Future<String>? _futureSummarize;

  // Future<Bool>? futureAddFollowers;

  @override
  void initState() {
    super.initState();
    initTts();

    context.read<ArticleProvider>().newAddedComment = CommentsModel(
        id: 0,
        content: "",
        createdAt: "",
        updatedAt: "",
        user_id: 0,
        // article: 0,
        username: "");
    context.read<ArticleProvider>().createCommentStatus = "";
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

  void handleSummarize() {
    setState(() {
      _futureSummarize = context
          .read<ArticleProvider>()
          .summarizeArticle(context.read<ArticleProvider>().articleContent);
    });
  }

  bool isValidImage(String base64Image) {
    try {
      final bytes = base64Decode(base64Image);
      final image = img.decodeImage(bytes);
      return image != null;
    } catch (e) {
      return false;
    }
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // title
                  ContentCard(
                    widget: Row(
                      children: [
                        Text(
                          args.newsmodel.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),

                  // user
                  ContentCard(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //this is image
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(50))),
                          // padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                            onPressed: (() {
                              // nav uer profile
                              Navigator.pushNamed(
                                  context, AppRoutes.userProfile,
                                  arguments:
                                      UserIdArgument(args.newsmodel.user));
                            }),
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),

                        SizedBox(width: 10),

                        // this is other widget
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              args.newsmodel.username,
                              style: CustomTextStyles.bodyLarge16,
                            ),
                            SizedBox(height: 5.v),
                            FutureBuilder<bool>(
                              future: context
                                  .read<ProfileProvider>()
                                  .isFollowingOrNot(
                                      args.userModel.id, args.newsmodel.user),
                              builder: (context, data) {
                                // if fetch data successful and not the owner of that article
                                if (data.hasData &&
                                    (args.newsmodel.user !=
                                        args.userModel.id)) {
                                  return ElevatedButton(
                                    style: ButtonStyle(
                                      // if current login user follow the user writting this article, color is blue
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              data.data!
                                                  ? Colors.blue
                                                  : Colors.black),
                                    ),
                                    onPressed: () {
                                      // add followers if is not follow yet
                                      if (!data.data!) {
                                        // current login user is follower
                                        // and follow the one that write article
                                        if (args.userModel.id != 0)
                                          context
                                              .read<ArticleProvider>()
                                              .addFollowers(args.newsmodel.user,
                                                  args.userModel.id);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Follow',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                }

                                return OutlinedButton(
                                  onPressed: null,
                                  child: Text('Follow'),
                                );
                              },
                            )
                          ],
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),

                  // image
                  if (args.newsmodel.image != null &&
                      isValidImage(args.newsmodel.image))
                    Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.memory(
                                base64Decode(args.newsmodel.image))),
                        SpacePaddingHeight(),
                      ],
                    ),

                  // article
                  ContentCard(
                    widget: Column(children: [
                      Row(
                        children: [
                          Text(
                            "Content",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyLarge!.copyWith(
                              height: 1.11,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        context.read<ArticleProvider>().articleContent,
                        maxLines: 50,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.bodyMediumIndigo800_1.copyWith(
                          height: 1.43,
                        ),
                      ),
                      SpacePaddingHeight(),

                      // text to speech and translate
                      Row(
                        children: [
                          Flexible(flex: 4, child: _soundBar()),
                          SizedBox(width: 16),
                          Flexible(
                            flex: 2,
                            child: MainButton(
                                onPressedFunc: onClickChangeLanguage,
                                btnText: "Translate"),
                          )
                        ],
                      )
                    ]),
                  ),

                  // summary
                  ContentCard(widget: _summarySection()),

                  // comment
                  ContentCard(
                    widget: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Comment Section",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge!.copyWith(
                                height: 1.11,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        (args.userModel.id != 0)
                            ? (_commentSection())
                            : Row(
                                children: [
                                  (Text(
                                      "Want writter to see your thought, login now!!")),
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // floatingActionButton: Container(
        //   decoration: BoxDecoration(
        //       color: Colors.blue,
        //       borderRadius: BorderRadius.all(const Radius.circular(10))),
        //   child: IconButton(
        //     icon: Icon(Icons.translate),
        //     onPressed: onClickChangeLanguage,
        //     color: Colors.white,
        //   ),
        // ),
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

      // logic: if user add a new comment, this widget will show the new comment without causing the entire page to reload -> improve UX
      (context.watch<ArticleProvider>().newAddedComment.user_id != 0)
          ? SizedBox(
              width: 293.h,
              child: (ListTile(
                leading: Container(
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

                // the recently added commennts value
                title: Text(
                    '${context.watch<ArticleProvider>().newAddedComment.user_id.toString()}'),
                subtitle: Text(
                    context.watch<ArticleProvider>().newAddedComment.content),
              )),
            )
          : (SizedBox(
              height: 0,
            )),

      // the rest of comments that display dynamicly
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
              title: Text('${comment.username}'),
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
        Row(
          children: [
            Text(
              "Summarization",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyLarge!.copyWith(
                height: 1.11,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),

        // content
        (_futureSummarize != null)
            ? FutureBuilder<String>(
                future: _futureSummarize,
                builder: (context, data) {
                  if (data.hasData) {
                    return Text(data.data!);
                  }
                  return Center(
                      child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue)));
                },
              )
            : Text("Want a shorter content, try this out!!"),
        SpacePaddingHeight(),

        // button
        MainButton(onPressedFunc: handleSummarize, btnText: "Summarize")
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
      padding: const EdgeInsets.all(3.0),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
              icon: Icon(icon, size: 25),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
        ]);
  }

  /// Navigates to the previous screen.
  onTapChevronleftone(BuildContext context) {
    NavigatorService.goBack();
  }

  Widget SpacePaddingHeight() {
    return SizedBox(height: 16);
  }

  Widget SpacePaddingWidth() {
    return SizedBox(width: 16);
  }
}
