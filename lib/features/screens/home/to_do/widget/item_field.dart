import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/model.dart';
import '../../../../utils/components/app_color.dart';
import '../../../../utils/components/asset_resources/resources.dart';
import '../../../../utils/text_style.dart';

class ItemField extends HookWidget {
  const ItemField({
    super.key,
    required this.itemFieldDetails,
    required this.onSubmitted,
    required this.onDelete,
  });

  final TodoItem itemFieldDetails;
  final void Function(String) onSubmitted;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();

    useEffect(() {
      focusNode.requestFocus();
      return null;
    }, []);

    return Padding(
      padding: EdgeInsets.only(left: 16.w, bottom: 16.h, right: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(onTap: onDelete, child: SvgPicture.asset(Vectors.union)),
          SizedBox(width: 6.5.w),
          SvgPicture.asset(Vectors.untick),
          SizedBox(width: 6.5.w),
          Expanded(
            child: TextField(
              controller: itemFieldDetails.todoController,
              focusNode: focusNode,
              cursorHeight: 18.h,
              style: Graphik.kFontW4.copyWith(fontSize: 16.spMin),
              decoration: InputDecoration(
                hintText: 'Add a to-do item',
                hintStyle: Graphik.kFontW4.copyWith(
                  color: AppColor.k8C8E8F,
                  fontSize: 16.spMin,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
              ),
              textInputAction: TextInputAction.next,
              onSubmitted: onSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
