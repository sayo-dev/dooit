import 'package:Dooit/features/screens/home/to_do/state/to_do_cubit.dart';
import 'package:Dooit/features/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';


import '../../core/model.dart';
import '../../core/storage.dart';
import '../../utils/components/app_color.dart';
import '../../utils/components/app_route.dart';
import '../../utils/components/asset_resources/resources.dart';
import '../../utils/constants.dart';
import '../../utils/text_style.dart';
import '../../utils/widgets/app_button.dart';

class Home extends HookWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final tabCtrl = useTabController(initialLength: 2);

    useEffect(() {
      final todoList = LocalStorage.readObjectList(
        'to-do-list',
        (details) => ListDetails.fromJson(details),
      );
      context.read<ToDoCubit>().initializeList(todoList);
      return null;
    }, []);
    return BlocBuilder<ToDoCubit, ToDoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            leading: Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: SvgPicture.asset(Vectors.logoBlack),
            ),
            titleSpacing: 12.w,
            title: Text(
              'Dooit',
              style: Graphik.kFontW6.copyWith(fontSize: 18.spMin),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 24.w),
                child: InkWell(
                  onTap: () {
                    context.pushNamed(AppRoute.search);
                  },
                  child: SvgPicture.asset(Vectors.search),
                ),
              ),
            ],
          ),
          floatingActionButton:
              ((tabCtrl.index == 0 ? state.todoList : state.pinnedList)
                  .isNotEmpty)
              ? FloatingActionButton.small(
                  onPressed: () {
                    context.pushNamed(
                      AppRoute.newList,
                      extra: tabCtrl.index == 0 ? false : true,
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(123.r),
                  ),
                  backgroundColor: AppColor.black,
                  foregroundColor: AppColor.white,
                  child: SvgPicture.asset(Vectors.add),
                )
              : null,

          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.h),
                decoration: BoxDecoration(
                  color: AppColor.kE5E5E5,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TabBar(
                  controller: tabCtrl,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: AppColor.black.withOpacity(.4),
                  labelColor: AppColor.white,
                  labelStyle: Graphik.kFontW6.copyWith(
                    fontSize: 14.spMin,
                    color: AppColor.white,
                  ),
                  dividerHeight: 0,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColor.black,
                  ),
                  tabs: [
                    Tab(text: 'All List '),
                    Tab(text: 'Pinned'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabCtrl,
                  children: [AllListView(), PinnedListView()],
                ),
              ),
            ],
          ).hPad,
        );
      },
    );
  }
}

class PinnedListView extends StatelessWidget {
  const PinnedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, ToDoState>(
      builder: (context, state) {
        if (state.pinnedList.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              h(28),
              ...state.pinnedList.map((todo) => TaskCard(todo: todo)),
            ],
          );
        }
        return EmptyList(isPinned: true);
      },
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.todo});

  final ListDetails todo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoute.task, extra: todo);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
        decoration: BoxDecoration(
          color: AppColor.kF5F5F5,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              todo.title,
              style: Graphik.kFontW5.copyWith(fontSize: 18.spMin),
            ),
            h(14),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: AppColor.black,
                  ),
                  child: Text(
                    todo.label,
                    style: Graphik.kFontW5.copyWith(
                      color: AppColor.white,
                      fontSize: 12.spMin,
                    ),
                  ),
                ),
                Spacer(),
                SvgPicture.asset(Vectors.calendar),
                w(4),
                Text(
                  DateFormat(
                    'dd-MM-yyyy',
                  ).format(DateTime.fromMillisecondsSinceEpoch(todo.dateTime)),
                  style: Graphik.kFontW4.copyWith(fontSize: 13.spMin),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AllListView extends StatelessWidget {
  const AllListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, ToDoState>(
      builder: (context, state) {
        if (state.todoList.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              h(28),
              ...state.todoList.map((todo) => TaskCard(todo: todo)),
            ],
          );
        }
        return EmptyList();
      },
    );
  }
}

class EmptyList extends StatelessWidget {
  const EmptyList({super.key, this.isPinned = false});

  final bool isPinned;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(isPinned ? Images.noPinned : Images.hr, height: 200.h),
        h(80),
        Text(
          isPinned ? 'Ooops! No pinned list yet...' : 'Create a to-do list...',
          style: Graphik.kFontW6,
        ),
        h(28),
        AppButton(
          text: 'New List',
          onPressed: () {
            context.pushNamed(AppRoute.newList, extra: isPinned);
          },
        ),
      ],
    );
  }
}
