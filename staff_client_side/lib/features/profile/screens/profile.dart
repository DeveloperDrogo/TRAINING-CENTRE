// ignore_for_file: unused_import, unnecessary_import, use_build_context_synchronously, unnecessary_string_interpolations, unused_local_variable, depend_on_referenced_packages

import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:staff_client_side/constant/sharedprefs.dart';
import 'package:staff_client_side/features/profile/bloc/profile_bloc.dart';
import 'package:staff_client_side/routes/routes.dart';
import 'package:staff_client_side/server/server.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static File? imageFile; // Use nullable File

  static List? location;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mblNumber = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pancard = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController workExperience = TextEditingController();

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

  Future<void> openGallery() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    //var img = await ImagePicker().getImage(source: ImageSource.gallery);
    if (img != null) {
      var file = File(img.path);
      var fileSize = await file.length();
      var fileSizeInKB = fileSize / 1024;
      //  print(fileSizeInKB);
      if (fileSizeInKB > 3000) {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,

          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error!',
            message: 'Selected image exceeds the file size limit of 3.0MB',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        // Show an error message or perform any required action for exceeding the file size limit.
        // Constant.imageError="Image should be below 200kb";
        //  print(Constant.imageError);
      } else {
        setState(() {
          ProfilePage.imageFile = file;
        });
      }
    }
  }

  final ProfileBloc profileBloc = ProfileBloc();

  @override
  void initState() {
    // CheckInternet.checkInternet(context);

    // print('login thorugh ${SharedPrefs().loginThrough}');
    //print('mobile is ${SharedPrefs().mblnumber}');
    emailIS = SharedPrefs().email;
    //  print('email is ${SharedPrefs().email}');
    name.text = SharedPrefs().name != '' ? SharedPrefs().name : '';
    mblNumber.text =
        SharedPrefs().onlyNumber != '' ? SharedPrefs().onlyNumber : '';
    email.text = SharedPrefs().email != '' ? SharedPrefs().email : '';
    address.text = SharedPrefs().address != '' ? SharedPrefs().address : '';

    qualification.text =
        SharedPrefs().qualification != '' ? SharedPrefs().qualification : '';
    workExperience.text =
        SharedPrefs().workExperience != '' ? SharedPrefs().workExperience : '';
    pancard.text =
        SharedPrefs().governemntId != '' ? SharedPrefs().governemntId : '';
    _selectedGender = SharedPrefs().gender != '' ? SharedPrefs().gender : null;
    bloodGorup =
        SharedPrefs().bloodGroup != '' ? SharedPrefs().bloodGroup : null;
    setState(() {
      ProfilePage.imageFile = null;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final format = DateFormat("dd-MM-yyyy");
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String initialtodateString = '${SharedPrefs().dob}';
    DateFormat toformat = DateFormat('dd-MM-yyyy');

    // Declare formattedDate outside the try-catch block
    String formattedDate = '';

    try {
      DateTime initialtodate = toformat.parse(initialtodateString);
      // print(initialtodate);

      String originalDate = SharedPrefs().dob;
      List<String> parts = originalDate.split(' ');
      String datePart = parts[0];
      List<String> dateParts = datePart.split('-');
      formattedDate = SharedPrefs().dob != ''
          ? "${dateParts[2]}-${dateParts[1]}-${dateParts[0]}"
          : '';

      // Continue with the rest of your code...
    } catch (e) {
      // print('Error parsing date: $e');
      // You can set a default date or take appropriate action based on your use case
      // For example:
      // DateTime initialtodate = DateTime.now();
      // formattedDate = '';
    }

    // name.text = SharedPrefs().name != '' ? SharedPrefs().name : '';
    // mblNumber.text =
    //     SharedPrefs().mblnumber != '' ? SharedPrefs().mblnumber : '';
    // email.text = SharedPrefs().email != '' ? SharedPrefs().email : '';
    // address.text = SharedPrefs().address != '' ? SharedPrefs().address : '';
    // pancard.text = SharedPrefs().pancard != '' ? SharedPrefs().pancard : '';
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listenWhen: (previous, current) => current is ProfileActionState,
      buildWhen: (previous, current) => current is! ProfileActionState,
      listener: (context, state) {
        if (state is UpdateSuccess) {
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Success',
              message: 'Your profile updated Successfully',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is UpdateFailed) {
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Failed',
              message: 'Your profile update Failed',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is NavigateToDahsboardPage) {
          Navigator.pushReplacementNamed(context, MyRoutes.bottom);
        } else if (state is UpdateLoading) {
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

          // Simulate a time-consuming task
        } else if (state is UpdateSuccessNavigate) {
          Navigator.pushReplacementNamed(context, MyRoutes.profile);
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context, MyRoutes.bottom);
            return false;
          },
          child: Scaffold(
            backgroundColor: AdaptiveTheme.of(context).mode.isDark
                ? const Color.fromARGB(255, 56, 56, 56)
                : Colors.white,
            bottomNavigationBar: isBlankName != '' ||
                    isBlankNumber != '' ||
                    isDob != '' ||
                    isBlankGmail != '' ||
                    isBlankGender != '' ||
                    isBlankBloodGroup != '' ||
                    isBlankQualification != '' ||
                    isBlankWorkExperience != '' ||
                    isBlankAddress != '' ||
                    isBlankPancard != '' ||
                    ProfilePage.imageFile != null
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: SizedBox(
                        height: 50,
                        width: double
                            .infinity, // Set width to take up the entire screen width
                        child: ElevatedButton(
                          onPressed: () {
                            profileBloc.add(UpdateProfileEvent(
                                name: name.text,
                                dob:
                                    userDob != '' ? userDob : SharedPrefs().dob,
                                email: email.text,
                                gender: _selectedGender == null
                                    ? ''
                                    : _selectedGender!,
                                blood: bloodGorup == null ? '' : bloodGorup!,
                                address: address.text,
                                qualification: qualification.text,
                                workExperience: workExperience.text,
                                governmentId: pancard.text));
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
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: SizedBox(
                        height: 50,
                        width: double
                            .infinity, // Set width to take up the entire screen width
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
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
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? const Color.fromARGB(255, 56, 56, 56)
                          : Colors.white),
                  Column(
                    children: [
                      Container(
                        // height: 250.0,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text("Profile",
                                              style: GoogleFonts.lato(
                                                textStyle: const TextStyle(
                                                  fontFamily: "Lato",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      child: IconButton(
                                        onPressed: () {
                                          profileBloc
                                              .add(BacktoDashboardPage());
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios_new,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              //
                              ,
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 201, 201, 201)
                                            .withOpacity(0.5),
                                        spreadRadius: AdaptiveTheme.of(context)
                                                .mode
                                                .isDark
                                            ? 0
                                            : 1,
                                        blurRadius: AdaptiveTheme.of(context)
                                                .mode
                                                .isDark
                                            ? 0
                                            : 2,
                                        offset: AdaptiveTheme.of(context)
                                                .mode
                                                .isDark
                                            ? const Offset(0, 0)
                                            : const Offset(0, 1),
                                      ),
                                    ],
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 193, 193, 193),
                                        width: 0.0),
                                    color: AdaptiveTheme.of(context).mode.isDark
                                        ? const Color.fromARGB(255, 78, 76, 76)
                                        : Colors.white,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        MyColors.primaryColor,
                                        MyColors.secondaryColor
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          //positioned helps to position widget wherever we want.
                                          top: 70,
                                          bottom: -50,
                                          left: 310,
                                          right: -50, //position of the widget
                                          child: Container(
                                              height: 150,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: MyColors.blueFilter))),
                                      Positioned(
                                          left: -80,
                                          top: -70,
                                          child: Container(
                                              height: 150,
                                              width: 180,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: MyColors.blueFilter))),
                                      // Positioned(
                                      //     left: -50,
                                      //     top: -50,
                                      //     child: CircleAvatar(
                                      //         radius: 70,
                                      //         backgroundColor:
                                      //             AdaptiveTheme.of(context)
                                      //                     .mode
                                      //                     .isDark
                                      //                 ? Colors.transparent
                                      //                 : MyColors
                                      //                     .secondaryColor)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 20),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Stack(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 55,
                                                      backgroundColor:
                                                          AdaptiveTheme.of(context)
                                                                  .mode
                                                                  .isDark
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  56, 56, 56)
                                                              : Colors.white,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Container(
                                                            width: 110,
                                                            height: 110,
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    100),
                                                              ),
                                                            ),
                                                            child: ClipOval(
                                                              child: ProfilePage
                                                                          .imageFile !=
                                                                      null
                                                                  ? Image.file(
                                                                      ProfilePage
                                                                          .imageFile!,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : SharedPrefs()
                                                                              .imagePath !=
                                                                          ''
                                                                      ? Image
                                                                          .network(
                                                                          Server.img +
                                                                              SharedPrefs().imagePath,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )
                                                                      : Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                100,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(100),
                                                                              color: const Color.fromARGB(255, 234, 242, 255),
                                                                              boxShadow: [
                                                                                BoxShadow(color: const Color.fromARGB(255, 61, 61, 61).withOpacity(0.5), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 1)),
                                                                              ],
                                                                            ),
                                                                            child:
                                                                                Icon(
                                                                              IconlyBold.profile,
                                                                              color: MyColors.primaryColor,
                                                                              size: 60,
                                                                            ),
                                                                          ),
                                                                        ),
                                                            )),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 2,
                                                      bottom: 5,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          openGallery();
                                                        }, // Trigger the gallery picker when the button is tapped.
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: MyColors
                                                                    .primaryColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            // boxShadow: [
                                                            //   BoxShadow(
                                                            //     color: const Color
                                                            //             .fromARGB(
                                                            //             255,
                                                            //             201,
                                                            //             201,
                                                            //             201)
                                                            //         .withOpacity(
                                                            //             0.5),
                                                            //     spreadRadius: 1,
                                                            //     blurRadius: 3,
                                                            //     offset:
                                                            //         const Offset(
                                                            //             0, 2),
                                                            //   ),
                                                            // ],
                                                            color: AdaptiveTheme.of(
                                                                        context)
                                                                    .mode
                                                                    .isDark
                                                                ? const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    60,
                                                                    60,
                                                                    60)
                                                                : Colors.white,
                                                          ),
                                                          child: Icon(
                                                            IconlyBroken.edit,
                                                            color: AdaptiveTheme.of(
                                                                        context)
                                                                    .mode
                                                                    .isDark
                                                                ? Colors.white
                                                                : MyColors
                                                                    .primaryColor,
                                                            size: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 0,
                                                            bottom: 4,
                                                            left: 20,
                                                            right: 20),
                                                    child: Text(
                                                      SharedPrefs().name,
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            color: AdaptiveTheme.of(
                                                                        context)
                                                                    .mode
                                                                    .isDark
                                                                ? Colors.white
                                                                : Colors.white,
                                                            fontFamily: "Lato",
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4, left: 0),
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 20),
                                                            child: Icon(
                                                              IconlyBroken
                                                                  .bookmark,
                                                              color: AdaptiveTheme.of(
                                                                          context)
                                                                      .mode
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .white,
                                                              size: 20,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                                SharedPrefs()
                                                                    .role,
                                                                style:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  textStyle: TextStyle(
                                                                      color: AdaptiveTheme.of(context)
                                                                              .mode
                                                                              .isDark
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .white,
                                                                      fontFamily:
                                                                          "Lato",
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                )
                                                                // textAlign: TextAlign.center,
                                                                ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 20),
                                                            child: Icon(
                                                              IconlyBroken.call,
                                                              color: AdaptiveTheme.of(
                                                                          context)
                                                                      .mode
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .white,
                                                              size: 20,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                                SharedPrefs()
                                                                    .mobile,
                                                                style:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  textStyle: TextStyle(
                                                                      color: AdaptiveTheme.of(context)
                                                                              .mode
                                                                              .isDark
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .white,
                                                                      fontFamily:
                                                                          "Lato",
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                )
                                                                //textAlign: TextAlign.center,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    // height: 250.0,
                                    decoration: BoxDecoration(
                                        color: AdaptiveTheme.of(context)
                                                .mode
                                                .isDark
                                            ? const Color.fromARGB(
                                                255, 56, 56, 56)
                                            : Colors.white),
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       top: 10,
                                              //       left: 20,
                                              //       bottom: 10),
                                              //   child: Row(
                                              //     children: [
                                              //       Text(
                                              //         'Edit Profile',
                                              //         style: GoogleFonts.lato(
                                              //             textStyle:
                                              //                 const TextStyle(
                                              //                     fontSize: 16,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .w600)),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 20, 20, 15),
                                                child: TextFormField(
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
                                                      fillColor:
                                                          AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .isDark
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  56, 56, 56)
                                                              : Colors.white,
                                                      // fillColor: Colors.white,
                                                      hintText:
                                                          "Enter Your Name",
                                                      label: Text(
                                                        "Name",
                                                        style:
                                                            GoogleFonts.lato(),
                                                      ),
                                                      hintStyle:
                                                          GoogleFonts.lato(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      prefixIcon: Icon(
                                                        IconlyBroken.profile,
                                                        color: AdaptiveTheme.of(
                                                                    context)
                                                                .mode
                                                                .isDark
                                                            ? Colors.grey
                                                            : MyColors
                                                                .primaryColor,
                                                        size: 28,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            width: 1,
                                                            color: Color.fromARGB(
                                                                255,
                                                                193,
                                                                193,
                                                                193)), //<-- SEE HERE
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                  maxLines: 3,
                                                  minLines: 1,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          20, 0, 20, 15),
                                                      child: DateTimeFormField(
                                                        initialValue:
                                                            formattedDate
                                                                    .isNotEmpty
                                                                ? format.parse(
                                                                    formattedDate)
                                                                : null,

                                                        lastDate: DateTime(
                                                            DateTime.now()
                                                                    .year -
                                                                1,
                                                            12,
                                                            31),
                                                        dateFormat: format,
                                                        dateTextStyle:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                        decoration:
                                                            InputDecoration(
                                                                filled: true,
                                                                fillColor: AdaptiveTheme.of(
                                                                            context)
                                                                        .mode
                                                                        .isDark
                                                                    ? const Color
                                                                        .fromARGB(255,
                                                                        56, 56, 56)
                                                                    : Colors
                                                                        .white,
                                                                hintText:
                                                                    "Update your DOB",
                                                                label: Text(
                                                                  "DOB",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(),
                                                                ),
                                                                hintStyle:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  textStyle: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                prefixIcon:
                                                                    Icon(
                                                                  IconlyBroken
                                                                      .calendar,
                                                                  color: AdaptiveTheme.of(
                                                                              context)
                                                                          .mode
                                                                          .isDark
                                                                      ? Colors
                                                                          .grey
                                                                      : MyColors
                                                                          .primaryColor,
                                                                  size: 28,
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                      width: 1,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          193,
                                                                          193,
                                                                          193)), //<-- SEE HERE
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  //<-- SEE HERE
                                                                  borderSide: const BorderSide(
                                                                      width: 1,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          98,
                                                                          216,
                                                                          127)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  //<-- SEE HERE
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.red),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  //<-- SEE HERE
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.red),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                errorStyle:
                                                                    const TextStyle(
                                                                        color: Colors
                                                                            .red)),
                                                        mode:
                                                            DateTimeFieldPickerMode
                                                                .date,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .disabled,
                                                        onDateSelected:
                                                            (DateTime value) {
                                                          userDob =
                                                              value.toString();
                                                          setState(() {
                                                            isDob = value
                                                                .toString();
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
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 20, 15),
                                                child: TextFormField(
                                                  style: GoogleFonts.lato(),
                                                  controller: email,
                                                  // ignore: body_might_complete_normally_nullable
                                                  // validator: (value) {
                                                  //   if (value == null || value.isEmpty) {
                                                  //     return 'Please enter valid Email';
                                                  //   }
                                                  // },

                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isBlankGmail = value;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .isDark
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  56, 56, 56)
                                                              : Colors.white,
                                                      hintText:
                                                          "Enter your Email",
                                                      label: Text(
                                                        "Email",
                                                        style:
                                                            GoogleFonts.lato(),
                                                      ),
                                                      hintStyle:
                                                          GoogleFonts.lato(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      prefixIcon: Icon(
                                                        IconlyBroken.message,
                                                        color: AdaptiveTheme.of(
                                                                    context)
                                                                .mode
                                                                .isDark
                                                            ? Colors.grey
                                                            : MyColors
                                                                .primaryColor,
                                                        size: 28,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            width: 1,
                                                            color: Color.fromARGB(
                                                                255,
                                                                193,
                                                                193,
                                                                193)), //<-- SEE HERE
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 15),
                                                child: DropdownButtonFormField(
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 15,
                                                          color: AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black)),
                                                  value: _selectedGender,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isBlankGender =
                                                          value.toString();
                                                      _selectedGender = value!;
                                                    });
                                                  },
                                                  items: <String>[
                                                    'Male',
                                                    'Female'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .isDark
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  56, 56, 56)
                                                              : Colors.white,
                                                      hintText:
                                                          "Select Your Gender",
                                                      label: Text(
                                                        "Gender",
                                                        style:
                                                            GoogleFonts.lato(),
                                                      ),
                                                      hintStyle:
                                                          GoogleFonts.lato(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      prefixIcon: Icon(
                                                        IconlyBroken
                                                            .arrow_down_circle,
                                                        color: AdaptiveTheme.of(
                                                                    context)
                                                                .mode
                                                                .isDark
                                                            ? Colors.grey
                                                            : MyColors
                                                                .primaryColor,
                                                        size: 28,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            width: 1,
                                                            color: Color.fromARGB(
                                                                255,
                                                                193,
                                                                193,
                                                                193)), //<-- SEE HERE
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 15),
                                                child: DropdownButtonFormField(
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 15,
                                                          color: AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black)),
                                                  value: bloodGorup,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isBlankGender =
                                                          value.toString();
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
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .isDark
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  56, 56, 56)
                                                              : Colors.white,
                                                      hintText:
                                                          "Select Your Blood Gorup",
                                                      label: Text(
                                                        "Blood Group",
                                                        style:
                                                            GoogleFonts.lato(),
                                                      ),
                                                      hintStyle:
                                                          GoogleFonts.lato(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      prefixIcon: Icon(
                                                        IconlyBroken
                                                            .arrow_down_circle,
                                                        color: AdaptiveTheme.of(
                                                                    context)
                                                                .mode
                                                                .isDark
                                                            ? Colors.grey
                                                            : MyColors
                                                                .primaryColor,
                                                        size: 28,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            width: 1,
                                                            color: Color.fromARGB(
                                                                255,
                                                                193,
                                                                193,
                                                                193)), //<-- SEE HERE
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 20, 5),
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
                                                      fillColor:
                                                          AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .isDark
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  56, 56, 56)
                                                              : Colors.white,
                                                      hintText:
                                                          "Enter your address",
                                                      label: Text(
                                                        "Address",
                                                        style:
                                                            GoogleFonts.lato(),
                                                      ),
                                                      hintStyle:
                                                          GoogleFonts.lato(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      prefixIcon: Icon(
                                                        IconlyBroken.location,
                                                        color: AdaptiveTheme.of(
                                                                    context)
                                                                .mode
                                                                .isDark
                                                            ? Colors.grey
                                                            : MyColors
                                                                .primaryColor,
                                                        size: 28,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            width: 1,
                                                            color: Color.fromARGB(
                                                                255,
                                                                193,
                                                                193,
                                                                193)), //<-- SEE HERE
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 10, 20, 5),
                                                child: TextFormField(
                                                  style: GoogleFonts.lato(),
                                                  controller: qualification,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isBlankQualification =
                                                          value.toUpperCase();
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .isDark
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  56, 56, 56)
                                                              : Colors.white,
                                                      hintText:
                                                          "Enter Your Qualification",
                                                      label: Text(
                                                        "Qualification",
                                                        style:
                                                            GoogleFonts.lato(),
                                                      ),
                                                      hintStyle:
                                                          GoogleFonts.lato(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      prefixIcon: Icon(
                                                        IconlyBroken.document,
                                                        color: AdaptiveTheme.of(
                                                                    context)
                                                                .mode
                                                                .isDark
                                                            ? Colors.grey
                                                            : MyColors
                                                                .primaryColor,
                                                        size: 28,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            width: 1,
                                                            color: Color.fromARGB(
                                                                255,
                                                                193,
                                                                193,
                                                                193)), //<-- SEE HERE
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 10, 20, 5),
                                                child: TextFormField(
                                                  style: GoogleFonts.lato(),
                                                  controller: workExperience,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isBlankWorkExperience =
                                                          value.toUpperCase();
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .isDark
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  56, 56, 56)
                                                              : Colors.white,
                                                      hintText:
                                                          "Enter Your Work Experience",
                                                      label: Text(
                                                        "Work Experience",
                                                        style:
                                                            GoogleFonts.lato(),
                                                      ),
                                                      hintStyle:
                                                          GoogleFonts.lato(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      prefixIcon: Icon(
                                                        IconlyBroken.document,
                                                        color: AdaptiveTheme.of(
                                                                    context)
                                                                .mode
                                                                .isDark
                                                            ? Colors.grey
                                                            : MyColors
                                                                .primaryColor,
                                                        size: 28,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            width: 1,
                                                            color: Color.fromARGB(
                                                                255,
                                                                193,
                                                                193,
                                                                193)), //<-- SEE HERE
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 10, 20, 10),
                                                child: TextFormField(
                                                  style: GoogleFonts.lato(),
                                                  controller: pancard,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value.length > 10) {
                                                        pancard.text = value
                                                            .substring(0, 10);
                                                        // Move cursor to the end
                                                        pancard.selection =
                                                            TextSelection.fromPosition(
                                                                TextPosition(
                                                                    offset: pancard
                                                                        .text
                                                                        .length));
                                                      }
                                                      isBlankPancard =
                                                          value.toUpperCase();
                                                    });
                                                  },
                                                  maxLength: 10,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,

                                                  // ignore: body_might_complete_normally_nullable
                                                  // validator: (value) {
                                                  //   if (value == null || value.isEmpty) {
                                                  //     return 'Please enter valid Address';
                                                  //   }
                                                  // },
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .isDark
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  56, 56, 56)
                                                              : Colors.white,
                                                      hintText:
                                                          "Enter Your Government ID",
                                                      label: Text(
                                                        "Government ID",
                                                        style:
                                                            GoogleFonts.lato(),
                                                      ),
                                                      hintStyle:
                                                          GoogleFonts.lato(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      prefixIcon: Icon(
                                                        IconlyBroken.document,
                                                        color: AdaptiveTheme.of(
                                                                    context)
                                                                .mode
                                                                .isDark
                                                            ? Colors.grey
                                                            : MyColors
                                                                .primaryColor,
                                                        size: 28,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            width: 1,
                                                            color: Color.fromARGB(
                                                                255,
                                                                193,
                                                                193,
                                                                193)), //<-- SEE HERE
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
