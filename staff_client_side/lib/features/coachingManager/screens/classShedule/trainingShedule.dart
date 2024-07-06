// ignore_for_file: file_names

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:staff_client_side/features/coachingManager/bloc/coaching_manager_bloc.dart';
import 'package:staff_client_side/features/coachingManager/screens/classShedule/shedulesList/batchList.dart';
import 'package:staff_client_side/features/coachingManager/screens/classShedule/shedulesList/classList.dart';
import 'package:staff_client_side/features/coachingManager/screens/classShedule/shedulesList/subjectList.dart';
import 'package:staff_client_side/routes/routes.dart';
import 'package:staff_client_side/widget/emptyMessage.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:intl/intl.dart';

class TrainingShedulePage extends StatefulWidget {
  const TrainingShedulePage(
      {super.key,
      required this.subjectStatus,
      required this.batchStatus,
      required this.classStatus});
  final bool subjectStatus;
  final bool batchStatus;
  final bool classStatus;
  @override
  State<TrainingShedulePage> createState() => _TrainingShedulePageState();
}

class _TrainingShedulePageState extends State<TrainingShedulePage> {
  final _formKey = GlobalKey<FormState>();

  final addSubjectController = TextEditingController();
  final addClassroomController = TextEditingController();

  @override
  void initState() {
    super.initState();
    subjectFilterStatus = widget.subjectStatus;
    batchFilterStatus = widget.batchStatus;
    classRoomFilterStatus = widget.classStatus;
    coachingManagerBloc.add(CreateClassSheduleEvent());
  }

  final format = DateFormat("dd-MM-yyyy");

  Time _batchTime = Time(hour: 11, minute: 30, second: 20);
  String selectedBatchTime = '';

  void onTimeCheckOutChanged(Time newTime) {
    setState(() {
      _batchTime = newTime;
      print(selectedBatchTime);
      selectedBatchTime = newTime.toString();
      coachingManagerBloc.add(InsertBatchEvent(batchTime: selectedBatchTime));
    });
  }

  bool? subjectFilterStatus;
  bool? batchFilterStatus;
  bool? classRoomFilterStatus;

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
        } else if (state is AddSubjectDialougeBoxState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.noHeader,
            animType: AnimType.bottomSlide,
            // closeIcon: Icon(
            //   IconlyBroken.close_square,
            //   size: 40,
            //   color: MyColors.primaryColor,
            // ),
            showCloseIcon: true,
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: MyColors.extraLightBlue,
                    radius: 50,
                    child: Icon(
                      IconlyBroken.document,
                      size: 50,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Add Subject',
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(fontSize: 15)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 10, top: 0),
                    child: TextFormField(
                      controller: addSubjectController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid subject';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(18),
                          filled: true,
                          fillColor: AdaptiveTheme.of(context).mode.isDark
                              ? const Color.fromARGB(255, 56, 56, 56)
                              : Colors.white,
                          // fillColor: Colors.white,
                          hintText: "Enter subject ",
                          label: Text("Subject",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AdaptiveTheme.of(context).mode.isDark
                                        ? const Color.fromARGB(
                                            255, 195, 195, 195)
                                        : const Color.fromARGB(
                                            255, 99, 99, 99)),
                              )),
                          hintStyle: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(
                                    255, 193, 193, 193)), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 0.8, color: MyColors.primaryColor),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                const BorderSide(width: 1, color: Colors.red),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                const BorderSide(width: 1, color: Colors.red),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorStyle: const TextStyle(color: Colors.red)),
                      maxLines: 3,
                      minLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.red),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Cancel",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              coachingManagerBloc.add(InsertSubjectEvent(
                                  subjectName: addSubjectController.text));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color.fromARGB(255, 87, 200, 115)),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Add",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ).show();
        } else if (state is AddClassRoomDialougeBoxState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.noHeader,
            animType: AnimType.bottomSlide,
            // closeIcon: Icon(
            //   IconlyBroken.close_square,
            //   size: 40,
            //   color: MyColors.primaryColor,
            // ),
            showCloseIcon: true,
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: MyColors.extraLightBlue,
                    radius: 50,
                    child: Icon(
                      IconlyBroken.tick_square,
                      size: 50,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Add Clssroom',
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(fontSize: 15)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 10, top: 0),
                    child: TextFormField(
                      controller: addClassroomController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid classroom';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(18),
                          filled: true,
                          fillColor: AdaptiveTheme.of(context).mode.isDark
                              ? const Color.fromARGB(255, 56, 56, 56)
                              : Colors.white,
                          // fillColor: Colors.white,
                          hintText: "Enter Classroom ",
                          label: Text("Classroom",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AdaptiveTheme.of(context).mode.isDark
                                        ? const Color.fromARGB(
                                            255, 195, 195, 195)
                                        : const Color.fromARGB(
                                            255, 99, 99, 99)),
                              )),
                          hintStyle: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(
                                    255, 193, 193, 193)), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 0.8, color: MyColors.primaryColor),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                const BorderSide(width: 1, color: Colors.red),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                const BorderSide(width: 1, color: Colors.red),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorStyle: const TextStyle(color: Colors.red)),
                      maxLines: 3,
                      minLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.red),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Cancel",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              coachingManagerBloc.add(InsertClassRoomEvent(
                                  classRoom: addClassroomController.text));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color.fromARGB(255, 87, 200, 115)),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Add",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ).show();
        } else if (state is CoachingManagerActionLoader) {
          showDialog(
            context: context,

            barrierDismissible:
                false, // Set to true if you want to dismiss the dialog on tap outside
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    LoadingAnimationWidget.hexagonDots(
                      color: MyColors.primaryColor,
                      size: 50,
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Please wait...'),
                  ],
                ),
              );
            },
          );
        } else if (state is OnclickDeleteActionState) {
          final dialogState = state;
          AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Are you sure?',
            desc: dialogState.description,
            titleTextStyle: const TextStyle(fontSize: 16, height: 3),
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              coachingManagerBloc.add(DeleteEventActionEvent(
                  type: dialogState.type, id: dialogState.id));
            },
          ).show();
        } else if (state is ClassSheduleSuccessState) {
          final successState = state;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrainingShedulePage(
                    subjectStatus: successState.subjectStatus,
                    batchStatus: successState.batchStatus,
                    classStatus: successState.classStatus),
              ));
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Success',
              message: successState.description,

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          Future.delayed(Duration(milliseconds: 300)).then((value) {});
        } else if (state is ClassSheduleFailedState) {
          final failedState = state;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrainingShedulePage(
                    subjectStatus: failedState.subjectStatus,
                    batchStatus: failedState.batchStatus,
                    classStatus: failedState.classStatus),
              ));

          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Failed',
              message: failedState.description,

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
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
                                        color: subjectFilterStatus!
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
                                                color: subjectFilterStatus!
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
                                        color: batchFilterStatus!
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
                                                color: batchFilterStatus!
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
                                        color: classRoomFilterStatus!
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
                                                color: classRoomFilterStatus!
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
                    if (classRoomFilterStatus!)
                      Column(
                        children: [
                          successState.classrooms.isEmpty
                              ? const EmptyPage(
                                  description: 'No classrooms found.')
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 100),
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
                                                  onClassDelete:
                                                      (classRoomId, classRoom) {
                                                    coachingManagerBloc.add(
                                                        OnClickDeleteActionEvent(
                                                            type: 'CLASS',
                                                            description:
                                                                "Are you sure you want to delete this classroom: $classRoom ?",
                                                            value: classRoom,
                                                            id: classRoomId));
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
                    if (batchFilterStatus!)
                      Column(
                        children: [
                          successState.batchTimeList.isEmpty
                              ? const EmptyPage(description: 'No batch found.')
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 100),
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
                                                  onBatchDelete:
                                                      (batchId, batch) {
                                                    coachingManagerBloc.add(
                                                        OnClickDeleteActionEvent(
                                                            type: 'BATCH',
                                                            description:
                                                                "Are you sure you want to delete this batch: $batch ?",
                                                            value: batch,
                                                            id: batchId));
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
                    if (subjectFilterStatus!)
                      Column(
                        children: [
                          successState.subjectList.isEmpty
                              ? const EmptyPage(
                                  description: 'No subject found.')
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 100),
                                  child: ListView.builder(
                                    itemCount: successState.subjectList.length,
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
                                                child: SubjectListPage(
                                                  subjectId: successState
                                                      .subjectList[index]
                                                      .subjectId,
                                                  subjectName: successState
                                                      .subjectList[index]
                                                      .subjectName,
                                                  onSubjectDelete:
                                                      (subjectId, subject) {
                                                    coachingManagerBloc.add(
                                                        OnClickDeleteActionEvent(
                                                            type: 'SUBJECT',
                                                            description:
                                                                "Are you sure you want to delete this subject: $subject ?",
                                                            value: subject,
                                                            id: subjectId));
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
                      if (subjectFilterStatus!) {
                        coachingManagerBloc.add(OnClickAddSubjectEvent());
                      } else if (batchFilterStatus!) {
                        Navigator.of(context).push(
                          showPicker(
                            okText: "Add Batch",
                            context: context,
                            value: _batchTime,
                            is24HrFormat: false,
                            sunrise:
                                const TimeOfDay(hour: 6, minute: 0), // optional
                            sunset: const TimeOfDay(
                                hour: 18, minute: 0), // optional
                            duskSpanInMinutes: 120, // optional
                            onChange: onTimeCheckOutChanged,
                          ),
                        );
                      } else if (classRoomFilterStatus!) {
                        coachingManagerBloc.add(OnclickAddClassroomEvent());
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      subjectFilterStatus!
                          ? 'Subject'
                          : batchFilterStatus!
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
