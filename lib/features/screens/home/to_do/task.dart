import 'package:Dooit/features/screens/home/to_do/state/to_do_cubit.dart';
import 'package:Dooit/features/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/model.dart';
import '../../../utils/components/app_color.dart';
import '../../../utils/components/asset_resources/resources.dart';
import '../../../utils/constants.dart';
import '../../../utils/text_style.dart';

class Task extends HookWidget {
  const Task({super.key, required this.task});

  final ListDetails task;

  @override
  Widget build(BuildContext context) {
    final isPinned = useState<bool>(false);

    useEffect(() {
      context.read<ToDoCubit>().initializeItem();
      return null;
    }, []);
    return BlocBuilder<ToDoCubit, ToDoState>(
      builder: (context, state) {
        final currentTask = state.todoList.firstWhere(
          (t) => t.dateTime == task.dateTime,
          orElse: () => task,
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          isPinned.value = currentTask.isPinned;
        });

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            leading: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: InkWell(
                onTap: () {
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
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
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
                        color: isPinned.value ? AppColor.white : AppColor.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 120.h), // Space for bottom sheet
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          currentTask.title,
                          style: Graphik.kFontW6.copyWith(fontSize: 24.spMin),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: AppColor.black,
                        ),
                        child: Text(
                          currentTask.label,
                          style: Graphik.kFontW5.copyWith(
                            color: AppColor.white,
                            fontSize: 12.spMin,
                          ),
                        ),
                      ),
                    ],
                  ),
                  h(20),
                  ...currentTask.todoItems.map(
                    (todo) => Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Dismissible(
                        key: Key('${todo.id}_${DateTime.now().millisecondsSinceEpoch}'),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          context.read<ToDoCubit>().deleteTodo(
                            task.dateTime,
                            todo.id,
                          );
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 16.w),
                          color: Colors.red,
                          child: Icon(Icons.delete, color: AppColor.white),
                        ),
                        child: InkWell(
                          onTap: () {
                            context.read<ToDoCubit>().toggleTodoCompletion(
                              task.dateTime,
                              todo.id,
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                todo.completed ? Vectors.tick : Vectors.untick,
                              ),
                              SizedBox(width: 6.5.w),
                              Expanded(
                                child: Text(
                                  todo.todoController.text,
                                  style: Graphik.kFontW4.copyWith(
                                    fontSize: 16.spMin,
                                    decoration: todo.completed
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.5.w),
                              IconButton(
                                onPressed: () {
                                  context.read<ToDoCubit>().deleteTodo(
                                    task.dateTime,
                                    todo.id,
                                  );
                                },
                                icon: Icon(
                                  Icons.remove_circle_outlined,
                                  size: 20,
                                  color: AppColor.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 28.h),
                ],
              ).hPad,
            ),
          ),
        );
      },
    );
  }
}
