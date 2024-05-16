import '../../../core/app_export.dart';
import 'tags_item_model.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class NewArticleModel {
  List<TagsItemModel> tagsItemList =
      List.generate(5, (index) => TagsItemModel());
}
