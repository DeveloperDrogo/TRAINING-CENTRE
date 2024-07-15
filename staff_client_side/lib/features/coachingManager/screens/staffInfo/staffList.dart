// ignore_for_file: file_names

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:staff_client_side/features/coachingManager/bloc/coaching_manager_bloc.dart';
import 'package:staff_client_side/features/coachingManager/screens/staffInfo/editStaff.dart';
import 'package:staff_client_side/main.dart';
import 'package:staff_client_side/routes/routes.dart';
import 'package:staff_client_side/widget/emptyMessage.dart';

class AllStaffListPage extends StatefulWidget {
  const AllStaffListPage({super.key});

  @override
  State<AllStaffListPage> createState() => _AllStaffListPageState();
}

class _AllStaffListPageState extends State<AllStaffListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    coachingManagerBloc.add(ListAllStaffEvent());
    super.initState();
  }

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
        } else if (state is NavigateToAddStaffPageState) {
          Navigator.pushReplacementNamed(context, MyRoutes.addStaff);
        } else if (state is AskPermissionforDeleteStaffState) {}
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
                  title: Text("Staffs",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 19,
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
          case ListAllStaffsState:
            final successState = state as ListAllStaffsState;
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
                title: Text("Staffs",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 19,
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
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                child: SizedBox(
                    height: 50,
                    width: double
                        .infinity, // Set width to take up the entire screen width
                    child: ElevatedButton(
                      onPressed: () {
                        coachingManagerBloc.add(NavigateToAddStaff());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primaryColor,
                          // backgroundColor: const Color.fromARGB(255, 69, 160, 72),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10)) // Set the button's background color to green
                          ),
                      child: Row(
                        children: [
                          Text('ADD STAFF',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily:
                                      'Lato', // Set the text color to white
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          const Spacer(),
                          SizedBox(
                            height: 20,
                            child: Lottie.asset(
                              'assets/lottie/right.json',
                            ),
                          )
                        ],
                      ),
                    )),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Stack(
                            children: [
                              TextFormField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  filled: true,
                                  fillColor: AdaptiveTheme.of(context)
                                          .mode
                                          .isDark
                                      ? const Color.fromARGB(255, 67, 67, 67)
                                      : const Color.fromARGB(
                                          255, 252, 254, 255),
                                  hintText: " ",
                                  hintStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  prefixIcon: Icon(
                                    IconlyBroken.search,
                                    color: AdaptiveTheme.of(context).mode.isDark
                                        ? Colors.white
                                        : Colors.black,
                                    size: 28,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // PermissionPage.isLoading = true;

                                        _searchController.clear();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      });
                                    },
                                    child: const Icon(
                                      Icons.cancel,
                                      color: Color.fromARGB(255, 234, 104, 95),
                                      size: 28,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 0.8,
                                        color: Color.fromARGB(
                                            255, 193, 193, 193)), //<-- SEE HERE
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: const BorderSide(
                                        width: 0.8,
                                        color:
                                            Color.fromARGB(255, 193, 193, 193)),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: const BorderSide(
                                        width: 0.8, color: Colors.red),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: const BorderSide(
                                        width: 0.8, color: Colors.red),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {

                                  });
                                },
                              ),
                            if(  _searchController.text.isEmpty)
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0, top: 0),
                                          child: Text(
                                            'Search ',
                                            style: GoogleFonts.lato(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ),
                                       
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0, top: 0),
                                          child: DefaultTextStyle(
                                            
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: AdaptiveTheme.of(
                                                                context)
                                                            .mode
                                                            .isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            child: AnimatedTextKit(
                                              
                                              animatedTexts: [
                                                RotateAnimatedText('Staff Name'),
                                                RotateAnimatedText('Staff Id'),
                                                RotateAnimatedText('Staff Role'),
                                              ],
                                              repeatForever: true,
                                              onTap: () {
                                                
                                              },
                                            ),
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    successState.staffList
                            .where((staff) =>
                                _searchController.text.isEmpty ||
                                staff.name.toLowerCase().contains(
                                    _searchController.text.toLowerCase()) ||
                                staff.roleName.toLowerCase().contains(
                                    _searchController.text.toLowerCase()) ||
                                staff.staffId.toLowerCase().contains(
                                    _searchController.text.toLowerCase()))
                            .isEmpty
                        ? const EmptyPage(
                            description:
                                "There are no staff members to display",
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListView.builder(
                              itemCount: successState.staffList.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (_searchController.text.isNotEmpty &&
                                    !(successState.staffList[index].name
                                            .toLowerCase()
                                            .contains(_searchController.text
                                                .toLowerCase()) ||
                                        successState.staffList[index].roleName
                                            .toLowerCase()
                                            .contains(_searchController.text
                                                .toLowerCase()) ||
                                        successState.staffList[index].staffId
                                            .toLowerCase()
                                            .contains(_searchController.text
                                                .toLowerCase()))) {
                                  return const SizedBox
                                      .shrink(); // Hide the item if not found
                                }
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      delay: const Duration(microseconds: 1000),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditStaffPage(
                                                        userId: successState
                                                            .staffList[index]
                                                            .userId,
                                                        staffId: successState
                                                            .staffList[index]
                                                            .staffId,
                                                        name: successState
                                                            .staffList[index]
                                                            .name,
                                                        dob: successState
                                                            .staffList[index]
                                                            .dob,
                                                        email: successState
                                                            .staffList[index]
                                                            .email,
                                                        gender: successState
                                                            .staffList[index]
                                                            .gender,
                                                        blood: successState
                                                            .staffList[index]
                                                            .blood,
                                                        address: successState
                                                            .staffList[index]
                                                            .address,
                                                        qualification:
                                                            successState
                                                                .staffList[
                                                                    index]
                                                                .qualification,
                                                        workExperience:
                                                            successState
                                                                .staffList[
                                                                    index]
                                                                .workExperience,
                                                        governmentId:
                                                            successState
                                                                .staffList[
                                                                    index]
                                                                .governmentId,
                                                        contact: successState
                                                            .staffList[index]
                                                            .contact,
                                                        roleid: successState
                                                            .staffList[index]
                                                            .roleid,
                                                        roleName: successState
                                                            .staffList[index]
                                                            .roleName),
                                              ));
                                        },
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
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
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
                                                            const EdgeInsets
                                                                .only(
                                                                right: 60),
                                                        child: RichText(
                                                            text: TextSpan(
                                                                text:
                                                                    'Staff Name : ',
                                                                style:
                                                                    GoogleFonts
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
                                                                  text: successState
                                                                      .staffList[
                                                                          index]
                                                                      .name
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
                                                    if (successState
                                                            .staffList[index]
                                                            .staffId !=
                                                        '')
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10,
                                                          top: 10,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 60),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  text:
                                                                      'Staff ID : ',
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    textStyle: TextStyle(
                                                                        color: AdaptiveTheme.of(context).mode.isDark
                                                                            ? const Color.fromARGB(
                                                                                255,
                                                                                178,
                                                                                178,
                                                                                178)
                                                                            : const Color.fromARGB(
                                                                                255,
                                                                                140,
                                                                                140,
                                                                                140)),
                                                                  ),
                                                                  children: [
                                                                TextSpan(
                                                                    text: successState
                                                                        .staffList[
                                                                            index]
                                                                        .staffId
                                                                        .capitalizeFirstLetter(),
                                                                    style: GoogleFonts.lato(
                                                                        textStyle: TextStyle(
                                                                            height:
                                                                                1.5,
                                                                            color: AdaptiveTheme.of(context).mode.isDark
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                            fontFamily: "Lato",
                                                                            fontWeight: FontWeight.w600)))
                                                              ])),
                                                        ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              top: 10,
                                                              bottom: 20),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 60),
                                                        child: RichText(
                                                            text: TextSpan(
                                                                text: 'Role : ',
                                                                style:
                                                                    GoogleFonts
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
                                                                  text: successState
                                                                      .staffList[
                                                                          index]
                                                                      .roleName
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
                                                        IconlyBroken.profile,
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
                            ),
                          )
                  ],
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
