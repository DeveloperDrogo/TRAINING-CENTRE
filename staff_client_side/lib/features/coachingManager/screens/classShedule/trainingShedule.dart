// ignore_for_file: file_names

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:staff_client_side/features/coachingManager/bloc/coaching_manager_bloc.dart';
import 'package:staff_client_side/features/coachingManager/screens/classShedule/shedulesList/batchList.dart';
import 'package:staff_client_side/features/coachingManager/screens/classShedule/shedulesList/classList.dart';
import 'package:staff_client_side/features/coachingManager/screens/classShedule/shedulesList/subjectList.dart';
import 'package:staff_client_side/routes/routes.dart';
import 'package:staff_client_side/widget/emptyMessage.dart';

class TrainingShedulePage extends StatefulWidget {
  const TrainingShedulePage({super.key});

  @override
  State<TrainingShedulePage> createState() => _TrainingShedulePageState();
}

class _TrainingShedulePageState extends State<TrainingShedulePage> {
  @override
  void initState() {
    super.initState();
    coachingManagerBloc.add(CreateClassSheduleEvent());
  }

  bool subjectFilterStatus = true;
  bool batchFilterStatus = false;
  bool classRoomFilterStatus = false;

  final CoachingManagerBloc coachingManagerBloc = CoachingManagerBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoachingManagerBloc, CoachingManagerState>(
      bloc: coachingManagerBloc,
      listenWhen: (previous, current) => current is CoachingManagerActionState,
      buildWhen: (previous, current) => current is! CoachingManagerActionState,
      listener: (context, state) {
        if (state is BackToDashboardPageState) {
          Navigator.pushReplacementNamed(context, MyRoutes.bottom);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ClassSheduleLoader:
            return Scaffold(
                backgroundColor: AdaptiveTheme.of(context).mode.isDark
                    ? const Color.fromARGB(255, 56, 56, 56)
                    : Colors.white,
                appBar: AppBar(
                  backgroundColor: AdaptiveTheme.of(context).mode.isDark
                      ? const Color.fromARGB(255, 56, 56, 56)
                      : Colors.white,
                  elevation: 0,
                  centerTitle: false,
                  title: Text("Training Shedule Resources",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 18,
                            color: AdaptiveTheme.of(context).mode.isDark
                                ? Colors.white
                                : Colors.black,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.bold),
                      )),
                  leading: IconButton(
                    onPressed: () {
                      coachingManagerBloc.add(BacktoDashboardPage());
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ));
          case CreateClassSheduleState:
            final successState = state as CreateClassSheduleState;
            return Scaffold(
              backgroundColor: AdaptiveTheme.of(context).mode.isDark
                  ? const Color.fromARGB(255, 56, 56, 56)
                  : Colors.white,
              appBar: AppBar(
                backgroundColor: AdaptiveTheme.of(context).mode.isDark
                    ? const Color.fromARGB(255, 56, 56, 56)
                    : Colors.white,
                elevation: 0,
                centerTitle: false,
                title: Text("Training Shedule Resources",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 18,
                          color: AdaptiveTheme.of(context).mode.isDark
                              ? Colors.white
                              : Colors.black,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.bold),
                    )),
                leading: IconButton(
                  onPressed: () {
                    coachingManagerBloc.add(BacktoDashboardPage());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: AdaptiveTheme.of(context).mode.isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 2,
                          ),
                          SizedBox(
                            height: 29,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      subjectFilterStatus = true;
                                      batchFilterStatus = false;
                                      classRoomFilterStatus = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 0.5),
                                        color: subjectFilterStatus
                                            ? MyColors.primaryColor
                                            : AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark
                                                ? const Color.fromARGB(
                                                    255, 56, 56, 56)
                                                : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: Text('SUBJECT INFO',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: subjectFilterStatus
                                                    ? Colors.white
                                                    : AdaptiveTheme.of(context)
                                                            .mode
                                                            .isDark
                                                        ? Colors.white
                                                        : const Color.fromARGB(
                                                            255, 111, 111, 111),
                                                fontSize: 12.5,
                                                fontFamily: "Lato",
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      subjectFilterStatus = false;
                                      batchFilterStatus = true;
                                      classRoomFilterStatus = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 0.5),
                                        color: batchFilterStatus
                                            ? MyColors.primaryColor
                                            : AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark
                                                ? const Color.fromARGB(
                                                    255, 56, 56, 56)
                                                : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: Text('BATCH INFO',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: batchFilterStatus
                                                    ? Colors.white
                                                    : AdaptiveTheme.of(context)
                                                            .mode
                                                            .isDark
                                                        ? Colors.white
                                                        : const Color.fromARGB(
                                                            255, 111, 111, 111),
                                                fontSize: 12.5,
                                                fontFamily: "Lato",
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      subjectFilterStatus = false;
                                      batchFilterStatus = false;
                                      classRoomFilterStatus = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 0.5),
                                        color: classRoomFilterStatus
                                            ? MyColors.primaryColor
                                            : AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark
                                                ? const Color.fromARGB(
                                                    255, 56, 56, 56)
                                                : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: Text('CLASSROOM INFO',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: classRoomFilterStatus
                                                    ? Colors.white
                                                    : AdaptiveTheme.of(context)
                                                            .mode
                                                            .isDark
                                                        ? Colors.white
                                                        : const Color.fromARGB(
                                                            255, 111, 111, 111),
                                                fontSize: 12.5,
                                                fontFamily: "Lato",
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (classRoomFilterStatus)
                      Column(
                        children: [
                          successState.classrooms.isEmpty
                              ? const EmptyPage(
                                  description: 'No classrooms found.')
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 50),
                                  child: ListView.builder(
                                    itemCount: successState.classrooms.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 8,
                                                ),
                                                child: ClassRoomListPage(
                                                  classId: successState
                                                      .classrooms[index]
                                                      .classId,
                                                  classRoom: successState
                                                      .classrooms[index]
                                                      .classRoom,
                                                  onClassDelete: (classRoomId) {
                                                    debugPrint(classRoomId);
                                                  },
                                                )),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    if (batchFilterStatus)
                      Column(
                        children: [
                          successState.batchTimeList.isEmpty
                              ? const EmptyPage(description: 'No batch found.')
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 50),
                                  child: ListView.builder(
                                    itemCount:
                                        successState.batchTimeList.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 8,
                                                ),
                                                child: BatchListPage(
                                                  batchId: successState
                                                      .batchTimeList[index]
                                                      .batchId,
                                                  batch: successState
                                                      .batchTimeList[index]
                                                      .batchTime,
                                                  onBatchDelete: (batchId) {
                                                    debugPrint(batchId);
                                                  },
                                                )),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    if (subjectFilterStatus)
                      Column(
                        children: [
                          successState.subjectList.isEmpty
                              ? const EmptyPage(description: 'No subject found.')
                              :
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 50),
                            child: ListView.builder(
                              itemCount: successState.subjectList.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            bottom: 8,
                                          ),
                                          child: SubjectListPage(
                                            subjectId: successState
                                                .subjectList[index].subjectId,
                                            subjectName: successState
                                                .subjectList[index].subjectName,
                                            onSubjectDelete: (subjectId) {
                                              debugPrint(subjectId);
                                            },
                                          )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 15, right: 0),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.blue.shade800,
                    onPressed: () {
                      // Add your action for the FAB here
                      // print("FAB clicked");
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      subjectFilterStatus
                          ? 'Subject'
                          : batchFilterStatus
                              ? 'Batch'
                              : 'Classroom',
                      style: GoogleFonts.lato(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
