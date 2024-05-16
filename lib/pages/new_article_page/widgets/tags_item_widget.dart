import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/tags_item_model.dart'; // ignore: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class TagsItemWidget extends StatelessWidget {
  TagsItemWidget(this.tagsItemModelObj, {Key? key, this.onSelectedChipView})
      : super(
          key: key,
        );

  TagsItemModel tagsItemModelObj;

  Function(bool)? onSelectedChipView;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
      ),
      child: RawChip(
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          tagsItemModelObj.addtags!,
          style: TextStyle(
            color: appTheme.indigoA40001,
            fontSize: 14.fSize,
            fontFamily: 'Abel',
            fontWeight: FontWeight.w400,
          ),
        ),
        selected: (tagsItemModelObj.isSelected ?? false),
        backgroundColor: Colors.transparent,
        selectedColor: Colors.transparent,
        onSelected: (value) {
          onSelectedChipView?.call(value);
        },
      ),
    );
  }
}
