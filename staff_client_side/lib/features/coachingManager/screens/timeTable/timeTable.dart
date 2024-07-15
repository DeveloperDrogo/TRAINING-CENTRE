import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:staff_client_side/features/coachingManager/bloc/coaching_manager_bloc.dart';
import 'package:staff_client_side/features/coachingManager/screens/classShedule/createClassShedule.dart';
import 'package:staff_client_side/features/coachingManager/screens/timeTable/widget/timetablewidgets.dart';
import 'package:staff_client_side/main.dart';
import 'package:staff_client_side/routes/routes.dart';
import 'package:staff_client_side/widget/emptyMessage.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  final String selectedDay;

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  late String selectedDay;

  final CoachingManagerBloc coachingManagerBloc = CoachingManagerBloc();

  List? staffAllList;
  List? batchTimeList;
  List? subjectList;
  List? classrooms;

  @override
  void initState() {
    super.initState();
    selectedDay = widget.selectedDay;
    coachingManagerBloc.add(TimeTableFetchState());
    // coachingManagerBloc.add(CreateTimeTableEvent());
  }

  // Method to handle day selection
  void onDaySelected(String day) {
    setState(() {
      selectedDay = day;
    });

    switch (day) {
      case 'mon':

        // Handle Monday selection
        break;
      case 'tue':
        // Handle Tuesday selection
        break;
      case 'wed':
        // Handle Wednesday selection
        break;
      case 'thu':
        // Handle Thursday selection
        break;
      case 'fri':
        // Handle Friday selection
        break;
      case 'sat':
        // Handle Saturday selection
        break;
      case 'sun':
        // Handle Sunday selection
        break;
    }
  }

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
        //  else if (state is CreateTimeTableState) {
        //   final listState = state;
        //   staffAllList = listState.staffAllList;
        //   subjectList = listState.subjectList;
        //   batchTimeList = listState.batchTimeList;
        //   classrooms = listState.classrooms;
        // }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case CoachingLoaderState:
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
                title: Text(
                  "Time Table",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? Colors.white
                          : Colors.black,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    coachingManagerBloc.add(BacktoDashboardPage());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case TimeTableCompleteFetchSuccess:
            final successState = state as TimeTableCompleteFetchSuccess;
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
                title: Text(
                  "Time Table",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? Colors.white
                          : Colors.black,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    coachingManagerBloc.add(BacktoDashboardPage());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 201, 201, 201)
                                          .withOpacity(0.5),
                                  spreadRadius:
                                      AdaptiveTheme.of(context).mode.isDark
                                          ? 0
                                          : 1,
                                  blurRadius:
                                      AdaptiveTheme.of(context).mode.isDark
                                          ? 0
                                          : 4,
                                  offset: AdaptiveTheme.of(context).mode.isDark
                                      ? const Offset(0, 0)
                                      : const Offset(0, 1),
                                ),
                              ],
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? const Color.fromARGB(255, 72, 72, 72)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            height: 47,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  DayTab(
                                    label: 'MON',
                                    isSelected: selectedDay == 'mon',
                                    onTap: () => onDaySelected('mon'),
                                  ),
                                  DayTab(
                                    label: 'TUE',
                                    isSelected: selectedDay == 'tue',
                                    onTap: () => onDaySelected('tue'),
                                  ),
                                  DayTab(
                                    label: 'WED',
                                    isSelected: selectedDay == 'wed',
                                    onTap: () => onDaySelected('wed'),
                                  ),
                                  DayTab(
                                    label: 'THU',
                                    isSelected: selectedDay == 'thu',
                                    onTap: () => onDaySelected('thu'),
                                  ),
                                  DayTab(
                                    label: 'FRI',
                                    isSelected: selectedDay == 'fri',
                                    onTap: () => onDaySelected('fri'),
                                  ),
                                  DayTab(
                                    label: 'SAT',
                                    isSelected: selectedDay == 'sat',
                                    onTap: () => onDaySelected('sat'),
                                  ),
                                  DayTab(
                                    label: 'SUN',
                                    isSelected: selectedDay == 'sun',
                                    onTap: () => onDaySelected('sun'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    successState.timetable.where((element) {
                      switch (selectedDay) {
                        case 'mon':
                          return element.day == 'Monday';
                        case 'tue':
                          return element.day == 'Tuesday';
                        case 'wed':
                          return element.day == 'Wednesday';
                        case 'thu':
                          return element.day == 'Thursday';
                        case 'fri':
                          return element.day == 'Friday';
                        case 'sat':
                          return element.day == 'Saturday';
                        case 'sun':
                          return element.day == 'Sunday';
                        default:
                          return element.day == 'Monday';
                      }
                    }).isEmpty
                        ? const EmptyPage(
                            description: "No timetable added",
                          )
                        : ListView.builder(
                            itemCount: successState.timetable.where((element) {
                              switch (selectedDay) {
                                case 'mon':
                                  return element.day == 'Monday';
                                case 'tue':
                                  return element.day == 'Tuesday';
                                case 'wed':
                                  return element.day == 'Wednesday';
                                case 'thu':
                                  return element.day == 'Thursday';
                                case 'fri':
                                  return element.day == 'Friday';
                                case 'sat':
                                  return element.day == 'Saturday';
                                case 'sun':
                                  return element.day == 'Sunday';
                                default:
                                  return element.day == 'Monday';
                              }
                            }).length,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final timetAbleData =
                                  successState.timetable.where((element) {
                                switch (selectedDay) {
                                  case 'mon':
                                    return element.day == 'Monday';
                                  case 'tue':
                                    return element.day == 'Tuesday';
                                  case 'wed':
                                    return element.day == 'Wednesday';
                                  case 'thu':
                                    return element.day == 'Thursday';
                                  case 'fri':
                                    return element.day == 'Friday';
                                  case 'sat':
                                    return element.day == 'Saturday';
                                  case 'sun':
                                    return element.day == 'Sunday';
                                  default:
                                    return element.day == 'Monday';
                                }
                              }).toList();
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 1000),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    delay: const Duration(microseconds: 1000),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, right: 15, top: 10),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                        255, 201, 201, 201)
                                                    .withOpacity(0.5),
                                                spreadRadius:
                                                    AdaptiveTheme.of(context)
                                                            .mode
                                                            .isDark
                                                        ? 0
                                                        : 1,
                                                blurRadius:
                                                    AdaptiveTheme.of(context)
                                                            .mode
                                                            .isDark
                                                        ? 0
                                                        : 4,
                                                offset:
                                                    AdaptiveTheme.of(context)
                                                            .mode
                                                            .isDark
                                                        ? const Offset(0, 0)
                                                        : const Offset(0, 1),
                                              ),
                                            ],
                                            color: AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark
                                                ? const Color.fromARGB(
                                                    255, 68, 68, 68)
                                                : Colors.white,
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 0.2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                  right: -30,
                                                  top: -50,
                                                  child: Container(
                                                      height: 120,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: MyColors
                                                            .extraLightBlue,
                                                      ))),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                      top: 15,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 60),
                                                      child: RichText(
                                                          text: TextSpan(
                                                              text:
                                                                  'Staff Name : ',
                                                              style: GoogleFonts
                                                                  .lato(
                                                                textStyle: TextStyle(
                                                                    color: AdaptiveTheme.of(context)
                                                                            .mode
                                                                            .isDark
                                                                        ? const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            178,
                                                                            178,
                                                                            178)
                                                                        : const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            140,
                                                                            140,
                                                                            140)),
                                                              ),
                                                              children: [
                                                            TextSpan(
                                                                text: timetAbleData[
                                                                        index]
                                                                    .staffName
                                                                    .capitalizeFirstLetter(),
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        height:
                                                                            1.5,
                                                                        color: AdaptiveTheme.of(context).mode.isDark
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black,
                                                                        fontFamily:
                                                                            "Lato",
                                                                        fontWeight:
                                                                            FontWeight.w600)))
                                                          ])),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                      top: 10,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 60),
                                                      child: RichText(
                                                          text: TextSpan(
                                                              text:
                                                                  'Subject : ',
                                                              style: GoogleFonts
                                                                  .lato(
                                                                textStyle: TextStyle(
                                                                    color: AdaptiveTheme.of(context)
                                                                            .mode
                                                                            .isDark
                                                                        ? const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            178,
                                                                            178,
                                                                            178)
                                                                        : const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            140,
                                                                            140,
                                                                            140)),
                                                              ),
                                                              children: [
                                                            TextSpan(
                                                                text: timetAbleData[
                                                                        index]
                                                                    .subjectName
                                                                    .capitalizeFirstLetter(),
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        height:
                                                                            1.5,
                                                                        color: AdaptiveTheme.of(context).mode.isDark
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black,
                                                                        fontFamily:
                                                                            "Lato",
                                                                        fontWeight:
                                                                            FontWeight.w600)))
                                                          ])),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            top: 10,
                                                            bottom: 10),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 60),
                                                      child: RichText(
                                                          text: TextSpan(
                                                              text: 'Batch : ',
                                                              style: GoogleFonts
                                                                  .lato(
                                                                textStyle: TextStyle(
                                                                    color: AdaptiveTheme.of(context)
                                                                            .mode
                                                                            .isDark
                                                                        ? const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            178,
                                                                            178,
                                                                            178)
                                                                        : const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            140,
                                                                            140,
                                                                            140)),
                                                              ),
                                                              children: [
                                                            TextSpan(
                                                                text: timetAbleData[
                                                                        index]
                                                                    .batchName
                                                                    .capitalizeFirstLetter(),
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        height:
                                                                            1.5,
                                                                        color: AdaptiveTheme.of(context).mode.isDark
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black,
                                                                        fontFamily:
                                                                            "Lato",
                                                                        fontWeight:
                                                                            FontWeight.w600)))
                                                          ])),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            top: 0,
                                                            bottom: 20),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 60),
                                                      child: RichText(
                                                          text: TextSpan(
                                                              text:
                                                                  'Classroom : ',
                                                              style: GoogleFonts
                                                                  .lato(
                                                                textStyle: TextStyle(
                                                                    color: AdaptiveTheme.of(context)
                                                                            .mode
                                                                            .isDark
                                                                        ? const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            178,
                                                                            178,
                                                                            178)
                                                                        : const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            140,
                                                                            140,
                                                                            140)),
                                                              ),
                                                              children: [
                                                            TextSpan(
                                                                text: timetAbleData[
                                                                        index]
                                                                    .classRoomName
                                                                    .capitalizeFirstLetter(),
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        height:
                                                                            1.5,
                                                                        color: AdaptiveTheme.of(context).mode.isDark
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black,
                                                                        fontFamily:
                                                                            "Lato",
                                                                        fontWeight:
                                                                            FontWeight.w600)))
                                                          ])),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Positioned(
                                                  right: 10,
                                                  top: 8,
                                                  child: CircleAvatar(
                                                    radius: 17,
                                                    backgroundColor:
                                                        MyColors.primaryColor,
                                                    child: const Icon(
                                                      IconlyBroken.calendar,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CreateClassShedulePage(),
                          ));
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      // selectedDay == 'mon'
                      //     ? 'Monday'
                      //     : selectedDay == 'tue'
                      //         ? 'Tuesday'
                      //         : selectedDay == 'wed'
                      //             ? 'Wedensday'
                      //             : selectedDay == 'thu'
                      //                 ? 'Thursday'
                      //                 : selectedDay == 'fri'
                      //                     ? 'Friday'
                      //                     : selectedDay == 'sat'
                      //                         ? 'Saturday'
                      //                         : selectedDay == 'sun'
                      //                             ? 'Sunday'
                      //                             : '',
                      'Add ',
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
