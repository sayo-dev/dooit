import 'package:Dooit/features/screens/home/to_do/state/to_do_cubit.dart';
import 'package:Dooit/features/screens/home/to_do/widget/item_field.dart';
import 'package:Dooit/features/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/model.dart';
import '../../../utils/components/app_color.dart';
import '../../../utils/components/app_snackbar.dart';
import '../../../utils/components/asset_resources/resources.dart';
import '../../../utils/text_style.dart';

class CreateNewList extends HookWidget {
  const CreateNewList({super.key, this.pinned = false});

  final bool pinned;

  @override
  Widget build(BuildContext context) {
    final selectedLabel = useState<String?>(null);
    final titleController = useTextEditingController();
    final isPinned = useState<bool>(pinned);

    const labels = ['Personal', 'Work', 'Finance', 'Other'];

    useEffect(() {
      context.read<ToDoCubit>().initializeItem();
      return null;
    }, []);
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) return;
        context.read<ToDoCubit>().dispose();
      },
      child: BlocBuilder<ToDoCubit, ToDoState>(
        builder: (context, state) {
          if (state.todoItems.isEmpty) {
            context.read<ToDoCubit>().addNewTodoItem();
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomSheet: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: AppColor.kDADADA,
                    height: 0,
                    thickness: 0.5,
                  ).hPad,
                  SizedBox(height: 28.h),
                  Text(
                    'Choose a label',
                    textAlign: TextAlign.start,
                    style: Graphik.kFontW5.copyWith(fontSize: 24.spMin),
                  ).hPad,
                  SizedBox(height: 28.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Row(
                      children: [
                        SizedBox(width: 16.w),
                        ...labels.map(
                          (label) => Padding(
                            padding: EdgeInsets.only(right: 13.w),
                            child: InkWell(
                              onTap: () {
                                selectedLabel.value =
                                    selectedLabel.value == label ? null : label;
                              },
                              borderRadius: BorderRadius.circular(6.r),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  color: selectedLabel.value == label
                                      ? AppColor.black
                                      : AppColor.k898989,
                                  boxShadow: selectedLabel.value == label
                                      ? [
                                          BoxShadow(
                                            color: AppColor.black.withOpacity(
                                              0.2,
                                            ),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  label,
                                  style: Graphik.kFontW5.copyWith(
                                    color: AppColor.white,
                                    fontSize: 14.spMin,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              forceMaterialTransparency: true,
              leading: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: InkWell(
                  onTap: () {
                    context.read<ToDoCubit>().dispose();
                    context.pop();
                  },
                  borderRadius: BorderRadius.circular(20.r),
                  child: Transform.scale(
                    scale: 0.6,
                    child: SvgPicture.asset(Vectors.arrowBack),
                  ),
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 24.w),
                  child: InkWell(
                    onTap: () => isPinned.value = !isPinned.value,
                    borderRadius: BorderRadius.circular(5.r),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: AppColor.black),
                        color: isPinned.value ? AppColor.black : AppColor.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            isPinned.value ? Vectors.pinned : Vectors.pin,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            isPinned.value ? 'Pinned' : 'Pin',
                            style: Graphik.kFontW5.copyWith(
                              fontSize: 12.spMin,
                              color: isPinned.value
                                  ? AppColor.white
                                  : AppColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 120.h),
                // Space for bottom sheet
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextField(
                        controller: titleController,
                        cursorHeight: 24.h,
                        style: Graphik.kFontW6.copyWith(fontSize: 24.spMin),
                        decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: Graphik.kFontW6.copyWith(
                            fontSize: 24.spMin,
                            color: AppColor.k8C8E8F,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),

                    ...state.todoItems.map(
                      (todo) => ItemField(
                        itemFieldDetails: todo,

                        onDelete: () {
                          context.read<ToDoCubit>().removeTodoItem(todo.id);
                        },
                        onSubmitted: (val) {
                          if (val.isNotEmpty) {
                            context.read<ToDoCubit>().addNewTodoItem();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 28.h),
                  ],
                ),
              ),
            ),

            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                context
                    .read<ToDoCubit>()
                    .updateListLocally(
                      listDetails: ListDetails(
                        title: titleController.text.isEmpty
                            ? selectedLabel.value!
                            : titleController.text.trim(),
                        todoItems: state.todoItems,
                        label: selectedLabel.value!,
                        isPinned: isPinned.value,
                        dateTime: DateTime.now().millisecondsSinceEpoch,
                      ),
                    )
                    .then((_) {
                      AppSnackBar.showMessage(
                        context,
                        'To-do added to list successfully',
                      );
                      if (context.mounted) {
                        context.pop();
                      }
                    });
              },
              icon: const Icon(Icons.save),
              label: Text(
                'Save List',
                style: Graphik.kFontW5.copyWith(
                  color: AppColor.white,
                  fontSize: 14.spMin,
                ),
              ),
              backgroundColor: AppColor.black,
              foregroundColor: AppColor.white,
            ),
          );
        },
      ),
    );
  }
}
