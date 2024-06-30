// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:staff_client_side/features/coachingManager/bloc/coaching_manager_bloc.dart';
import 'package:staff_client_side/routes/routes.dart';
import 'package:dropdown_search/dropdown_search.dart';

class EditStaffPage extends StatefulWidget {
  const EditStaffPage(
      {super.key,
      required this.userId,
      required this.staffId,
      required this.name,
      required this.dob,
      required this.email,
      required this.gender,
      required this.blood,
      required this.address,
      required this.qualification,
      required this.workExperience,
      required this.governmentId,
      required this.contact,
      required this.roleid,
      required this.roleName});

  final String userId;
  final String staffId;
  final String name;
  final String dob;
  final String email;
  final String gender;
  final String blood;
  final String address;
  final String qualification;
  final String workExperience;
  final String governmentId;
  final String contact;
  final String roleid;
  final String roleName;

  @override
  State<EditStaffPage> createState() => _EditStaffPageState();
}

class _EditStaffPageState extends State<EditStaffPage> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pancard = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController workExperience = TextEditingController();
  TextEditingController contact = TextEditingController();

  String userDob = '';

  String isBlankName = '';
  String isBlankNumber = '';
  String isBlankGmail = '';
  String isBlankAddress = '';
  String isBlankPancard = '';
  String isBlankQualification = '';
  String isBlankBloodGroup = '';
  String isBlankWorkExperience = '';
  String isBlankGender = '';
  String isDob = '';
  String emailIS = '';
  String? _selectedGender;
  String? bloodGorup;

  final format = DateFormat("dd-MM-yyyy");

  final CoachingManagerBloc coachingManagerBloc = CoachingManagerBloc();

  List<String> roles = [];

  String? roleName;

  String? roleId;

  @override
  void initState() {
    coachingManagerBloc.add(CoachingInitialEvent());
    contact = TextEditingController(text: widget.contact);
    name = TextEditingController(text: widget.name);
    email = TextEditingController(text: widget.email);
    address = TextEditingController(text: widget.address);
    pancard = TextEditingController(text: widget.governmentId);
    qualification = TextEditingController(text: widget.qualification);
    workExperience = TextEditingController(text: widget.workExperience);
    _selectedGender = widget.gender != '' ? widget.gender : null;
    bloodGorup = widget.blood != '' ? widget.blood : null;
    roleName = widget.roleName != '' ? widget.roleName : null;
    roleId = widget.roleid != '' ? widget.roleid : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoachingManagerBloc, CoachingManagerState>(
      bloc: coachingManagerBloc,
      listenWhen: (previous, current) => current is CoachingManagerActionState,
      buildWhen: (previous, current) => current is! CoachingManagerActionState,
      listener: (context, state) {
        if (state is BackToDashboardPageState) {
          Navigator.pushReplacementNamed(context, MyRoutes.listAllStaffs);
        } else if (state is AddStaffLoadState) {
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
        } else if (state is AddStaffSuccessState) {
          Navigator.pushReplacementNamed(context, MyRoutes.listAllStaffs);
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Success',
              message: 'Staff has been added successfully.',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is AddStaffFailedState) {
          Navigator.pushReplacementNamed(context, MyRoutes.listAllStaffs);
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Failed',
              message: 'Staff addition failed.',

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
                  title: Text("Update Staff Info",
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
          case CoachingMangerAddStaffState:
            final successState = state as CoachingMangerAddStaffState;
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
                title: Text("Update Staff Info",
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
                        if (_formkey.currentState!.validate()) {
                          coachingManagerBloc.add(OnClickAddStaffEvent(
                              name: name.text,
                              dob: userDob,
                              email: email.text,
                              gender: _selectedGender!,
                              blood: bloodGorup != null ? bloodGorup! : '',
                              address: address.text,
                              qualification: qualification.text,
                              workExperience: workExperience.text,
                              governmentId: pancard.text,
                              contact: contact.text,
                              roleid: roleId!));
                        }
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
                          Text('UPDATE',
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
              body: WillPopScope(
                onWillPop: () async {
                  coachingManagerBloc.add(BacktoDashboardPage());
                  return false;
                },
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: AdaptiveTheme.of(context).mode.isDark
                          ? const Color.fromARGB(255, 56, 56, 56)
                          : Colors.white,
                      automaticallyImplyLeading: false,
                      expandedHeight: 250,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, right: 15),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? MyColors.secondaryColor
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: AdaptiveTheme.of(context).mode.isDark
                                      ? 260
                                      : 260,
                                  width: MediaQuery.of(context).size.width,
                                  child: AdaptiveTheme.of(context).mode.isDark
                                      ? Image.asset(
                                          'assets/images/addStaff.png',
                                          // fit: BoxFit.fitWidth,
                                        )
                                      : Image.asset(
                                          'assets/images/addStaff.png',
                                          //fit: BoxFit.fitWidth,
                                        )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 20, 15, 15),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter valid Name';
                                  }
                                  return null;
                                },
                                style: GoogleFonts.lato(),
                                controller: name,
                                onChanged: (value) {
                                  setState(() {
                                    setState(() {
                                      isBlankName = value;
                                    });
                                  });
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? const Color.fromARGB(255, 56, 56, 56)
                                        : Colors.white,
                                    // fillColor: Colors.white,
                                    hintText: "Enter Name",
                                    label: Text(
                                      "Name",
                                      style: GoogleFonts.lato(),
                                    ),
                                    hintStyle: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    prefixIcon: Icon(
                                      IconlyBroken.profile,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.grey
                                              : MyColors.primaryColor,
                                      size: 28,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 193, 193,
                                              193)), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: MyColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorStyle:
                                        const TextStyle(color: Colors.red)),
                                maxLines: 3,
                                minLines: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                              child: TextFormField(
                                style: GoogleFonts.lato(),
                                controller: contact,
                                // ignore: body_might_complete_normally_nullable
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter valid number';
                                  } else if (value.length != 10) {
                                    return 'Mobile Number must be 10 digits';
                                  }
                                  return null;
                                },
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? const Color.fromARGB(255, 56, 56, 56)
                                        : Colors.white,
                                    hintText: "Enter Contact Number",
                                    label: Text(
                                      "Contact Number",
                                      style: GoogleFonts.lato(),
                                    ),
                                    hintStyle: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    prefixIcon: Icon(
                                      IconlyBroken.call,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.grey
                                              : MyColors.primaryColor,
                                      size: 28,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 193, 193,
                                              193)), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: MyColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorStyle:
                                        const TextStyle(color: Colors.red)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                              child: TextFormField(
                                style: GoogleFonts.lato(),
                                controller: email,
                                // ignore: body_might_complete_normally_nullable
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter valid email';
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return 'Please enter valid email';
                                  }
                                  return null;
                                },

                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  setState(() {
                                    isBlankGmail = value;
                                  });
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? const Color.fromARGB(255, 56, 56, 56)
                                        : Colors.white,
                                    hintText: "Enter your Email",
                                    label: Text(
                                      "Email",
                                      style: GoogleFonts.lato(),
                                    ),
                                    hintStyle: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    prefixIcon: Icon(
                                      IconlyBroken.message,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.grey
                                              : MyColors.primaryColor,
                                      size: 28,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 193, 193,
                                              193)), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: MyColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorStyle:
                                        const TextStyle(color: Colors.red)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0, bottom: 15),
                              child: DropdownSearch<String>(
                                items: successState.roles
                                    .map((roles) => roles['role'])
                                    .toList()
                                    .cast<String>(),
                                dropdownBuilder: (context, item) => ListTile(
                                  title: Text(roleName != null
                                      ? roleName.toString()
                                      : 'Select Role'),
                                ),
                                popupProps:
                                    PopupPropsMultiSelection.modalBottomSheet(
                                  showSearchBox: true,
                                  searchDelay:
                                      const Duration(microseconds: 100),
                                  constraints: const BoxConstraints(),
                                  searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                    prefixIcon: const Icon(IconlyBroken.search),
                                    fillColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? const Color.fromARGB(255, 39, 39, 39)
                                        : Colors.white,
                                    filled: true,
                                    hintText: 'Search role here',
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 193, 193, 193),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 98, 216, 127),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  )),
                                  containerBuilder: (ctx, popupWidget) {
                                    return Container(
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? const Color.fromARGB(
                                                  255, 49, 49, 49)
                                              : Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 20, right: 20),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, bottom: 10),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.red),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: const Color
                                                              .fromARGB(255,
                                                              253, 231, 229)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 4,
                                                                bottom: 4),
                                                        child: Row(
                                                          children: [
                                                            //Spacer(),
                                                            Icon(
                                                              Icons
                                                                  .chevron_left_sharp,
                                                              color: AdaptiveTheme.of(
                                                                          context)
                                                                      .mode
                                                                      .isDark
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      39,
                                                                      39,
                                                                      39)
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              "Back",
                                                              style: TextStyle(
                                                                  color: AdaptiveTheme.of(
                                                                              context)
                                                                          .mode
                                                                          .isDark
                                                                      ? const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          39,
                                                                          39,
                                                                          39)
                                                                      : Colors
                                                                          .black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: popupWidget),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    roleName = value!;
                                    // Find the selected institution object
                                    var selectedRole =
                                        successState.roles.firstWhere(
                                      (roles) => roles['role'] == value,
                                      orElse: () => null,
                                    );

                                    // Check if the institution was found
                                    if (selectedRole != null) {
                                      roleId = selectedRole['_id'];
                                    }
                                  });

                                  // Handle search functionality here
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  filled: true,
                                  fillColor: AdaptiveTheme.of(context)
                                          .mode
                                          .isDark
                                      ? const Color.fromARGB(255, 56, 56, 56)
                                      : Colors.white,
                                  hintText: "Select Role",
                                  label: const Text("Role"),
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  prefixIcon: Icon(
                                    IconlyBroken.bookmark,
                                    color: AdaptiveTheme.of(context).mode.isDark
                                        ? Colors.grey
                                        : const Color.fromARGB(
                                            255, 72, 96, 176),
                                    size: 28,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 193, 193, 193),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 98, 216, 127),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.red),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.red),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorStyle:
                                      const TextStyle(color: Colors.red),
                                )),
                                validator: (value) {
                                  if (value == null && roleName == null) {
                                    return 'Please select role';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              child: DropdownButtonFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select gender';
                                  }
                                  return null;
                                },
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: AdaptiveTheme.of(context)
                                                .mode
                                                .isDark
                                            ? Colors.white
                                            : Colors.black)),
                                value: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    isBlankGender = value.toString();
                                    _selectedGender = value!;
                                  });
                                },
                                items: <String>[
                                  'Male',
                                  'Female'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? const Color.fromARGB(255, 56, 56, 56)
                                        : Colors.white,
                                    hintText: "Select Your Gender",
                                    label: Text(
                                      "Gender",
                                      style: GoogleFonts.lato(),
                                    ),
                                    hintStyle: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    prefixIcon: Icon(
                                      IconlyBroken.arrow_down_circle,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.grey
                                              : MyColors.primaryColor,
                                      size: 28,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 193, 193,
                                              193)), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: MyColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorStyle:
                                        const TextStyle(color: Colors.red)),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 15),
                                    child: DateTimeFormField(
                                      lastDate: DateTime(
                                          DateTime.now().year - 1, 12, 31),
                                      dateFormat: format,
                                      dateTextStyle: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? const Color.fromARGB(
                                                  255, 56, 56, 56)
                                              : Colors.white,
                                          hintText: "Update your DOB",
                                          label: Text(
                                            "DOB",
                                            style: GoogleFonts.lato(),
                                          ),
                                          hintStyle: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          prefixIcon: Icon(
                                            IconlyBroken.calendar,
                                            color: AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark
                                                ? Colors.grey
                                                : MyColors.primaryColor,
                                            size: 28,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(255, 193,
                                                    193, 193)), //<-- SEE HERE
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            //<-- SEE HERE
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 98, 216, 127)),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            //<-- SEE HERE
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            //<-- SEE HERE
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          errorStyle: const TextStyle(
                                              color: Colors.red)),
                                      mode: DateTimeFieldPickerMode.date,
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      onDateSelected: (DateTime value) {
                                        userDob = value.toString();
                                        setState(() {
                                          isDob = value.toString();
                                        });
                                      },
                                      // ignore: body_might_complete_normally_nullable
                                      // validator: (value) {
                                      //   if (value == null) {
                                      //     return 'Please enter valid DOB';
                                      //   }
                                      // },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              child: DropdownButtonFormField(
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: AdaptiveTheme.of(context)
                                                .mode
                                                .isDark
                                            ? Colors.white
                                            : Colors.black)),
                                value: bloodGorup,
                                onChanged: (value) {
                                  setState(() {
                                    isBlankGender = value.toString();
                                    bloodGorup = value!;
                                  });
                                },
                                items: <String>[
                                  'A +ve',
                                  'A -ve',
                                  'B +ve',
                                  'B -ve',
                                  'O +ve',
                                  'O -ve',
                                  'AB +ve',
                                  'AB -ve'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? const Color.fromARGB(255, 56, 56, 56)
                                        : Colors.white,
                                    hintText: "Select Your Blood Gorup",
                                    label: Text(
                                      "Blood Group",
                                      style: GoogleFonts.lato(),
                                    ),
                                    hintStyle: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    prefixIcon: Icon(
                                      IconlyBroken.arrow_down_circle,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.grey
                                              : MyColors.primaryColor,
                                      size: 28,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 193, 193,
                                              193)), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: MyColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorStyle:
                                        const TextStyle(color: Colors.red)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                              child: TextFormField(
                                style: GoogleFonts.lato(),
                                controller: address,
                                onChanged: (value) {
                                  setState(() {
                                    isBlankAddress = value;
                                  });
                                },
                                // ignore: body_might_complete_normally_nullable
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter valid Address';
                                //   }
                                // },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? const Color.fromARGB(255, 56, 56, 56)
                                        : Colors.white,
                                    hintText: "Enter your address",
                                    label: Text(
                                      "Address",
                                      style: GoogleFonts.lato(),
                                    ),
                                    hintStyle: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    prefixIcon: Icon(
                                      IconlyBroken.location,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.grey
                                              : MyColors.primaryColor,
                                      size: 28,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 193, 193,
                                              193)), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: MyColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorStyle:
                                        const TextStyle(color: Colors.red)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                              child: TextFormField(
                                style: GoogleFonts.lato(),
                                controller: qualification,
                                onChanged: (value) {
                                  setState(() {
                                    isBlankQualification = value.toUpperCase();
                                  });
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? const Color.fromARGB(255, 56, 56, 56)
                                        : Colors.white,
                                    hintText: "Enter Your Qualification",
                                    label: Text(
                                      "Qualification",
                                      style: GoogleFonts.lato(),
                                    ),
                                    hintStyle: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    prefixIcon: Icon(
                                      IconlyBroken.document,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.grey
                                              : MyColors.primaryColor,
                                      size: 28,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 193, 193,
                                              193)), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: MyColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorStyle:
                                        const TextStyle(color: Colors.red)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                              child: TextFormField(
                                style: GoogleFonts.lato(),
                                controller: workExperience,
                                onChanged: (value) {
                                  setState(() {
                                    isBlankWorkExperience = value.toUpperCase();
                                  });
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? const Color.fromARGB(255, 56, 56, 56)
                                        : Colors.white,
                                    hintText: "Enter Your Work Experience",
                                    label: Text(
                                      "Work Experience",
                                      style: GoogleFonts.lato(),
                                    ),
                                    hintStyle: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    prefixIcon: Icon(
                                      IconlyBroken.document,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.grey
                                              : MyColors.primaryColor,
                                      size: 28,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 193, 193,
                                              193)), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: MyColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorStyle:
                                        const TextStyle(color: Colors.red)),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: TextFormField(
                                style: GoogleFonts.lato(),
                                controller: pancard,
                                onChanged: (value) {
                                  setState(() {
                                    if (value.length > 10) {
                                      pancard.text = value.substring(0, 10);
                                      // Move cursor to the end
                                      pancard.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: pancard.text.length));
                                    }
                                    isBlankPancard = value.toUpperCase();
                                  });
                                },

                                textCapitalization:
                                    TextCapitalization.characters,

                                // ignore: body_might_complete_normally_nullable
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter valid Address';
                                //   }
                                // },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? const Color.fromARGB(255, 56, 56, 56)
                                        : Colors.white,
                                    hintText: "Enter Your Government ID",
                                    label: Text(
                                      "Government ID",
                                      style: GoogleFonts.lato(),
                                    ),
                                    hintStyle: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    prefixIcon: Icon(
                                      IconlyBroken.document,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.grey
                                              : MyColors.primaryColor,
                                      size: 28,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 193, 193,
                                              193)), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: MyColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorStyle:
                                        const TextStyle(color: Colors.red)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]))
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
