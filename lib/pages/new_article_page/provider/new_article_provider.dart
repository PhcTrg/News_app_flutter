import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/new_article_model.dart';
import '../models/tags_item_model.dart';

/// A provider class for the NewArticlePage.
///
/// This provider manages the state of the NewArticlePage, including the
/// current newArticleModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class NewArticleProvider extends ChangeNotifier {
  NewArticleModel newArticleModelObj = NewArticleModel();

  @override
  void dispose() {
    super.dispose();
  }

  void onSelectedChipView(
    int index,
    bool value,
  ) {
    newArticleModelObj.tagsItemList.forEach((element) {
      element.isSelected = false;
    });
    newArticleModelObj.tagsItemList[index].isSelected = value;
    notifyListeners();
  }
}
