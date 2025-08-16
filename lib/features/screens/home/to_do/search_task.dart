import 'dart:async';

import 'package:Dooit/features/screens/home/to_do/state/to_do_cubit.dart';
import 'package:Dooit/features/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/components/app_color.dart';
import '../../../utils/components/asset_resources/resources.dart';
import '../../../utils/constants.dart';
import '../../../utils/text_style.dart';
import '../home.dart';

class SearchTask extends HookWidget {
  const SearchTask({super.key});

  @override
  Widget build(BuildContext context) {
    final queryCtrl = useTextEditingController();
    var debouncer = useMemoized(() => Timer(Duration.zero, () {}));

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        actions: [
          w(24),
          Expanded(
            child: TextField(
              controller: queryCtrl,
              onChanged: (val) {
                debouncer.cancel();
                debouncer = Timer(const Duration(milliseconds: 300), () {
                  context.read<ToDoCubit>().initializeQuery(val.trim());
                });
              },
              decoration: InputDecoration(
                fillColor: AppColor.kF4F4F4,
                filled: true,
                prefixIcon: SvgPicture.asset(
                  Vectors.search,
                  fit: BoxFit.scaleDown,
                ),
                hintText: 'Search your list',
                hintStyle: Graphik.kFontW4.copyWith(color: AppColor.k8C8E8F),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 11.h,
                  horizontal: 11.w,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColor.kE3E2E2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColor.kE3E2E2),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Text(
              'Cancel',
              style: Graphik.kFontW6.copyWith(color: AppColor.black),
            ),
          ).hPad,
        ],
      ),
      body: BlocBuilder<ToDoCubit, ToDoState>(
        builder: (context, state) {
          if (state.filteredList.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                h(28),
                ...state.filteredList.map((todo) => TaskCard(todo: todo)),
              ],
            );
          }
          return EmptyList();
        },
      ).hPad,
    );
  }
}
