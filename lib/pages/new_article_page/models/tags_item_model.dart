/// This class is used in the [tags_item_widget] screen.

// ignore_for_file: must_be_immutable
class TagsItemModel {
  TagsItemModel({this.addtags, this.isSelected}) {
    addtags = addtags ?? "Add Tags";
    isSelected = isSelected ?? false;
  }

  String? addtags;

  bool? isSelected;
}
