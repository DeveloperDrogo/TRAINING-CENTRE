import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:staff_client_side/features/tutionCenter/bloc/tution_center_bloc.dart';
import 'package:staff_client_side/routes/routes.dart';

class AddTutionCenterPage extends StatefulWidget {
  const AddTutionCenterPage({super.key});

  @override
  State<AddTutionCenterPage> createState() => _AddTutionCenterPageState();
}

class _AddTutionCenterPageState extends State<AddTutionCenterPage> {
  @override
  void initState() {
    super.initState();
  }

  String managerNameSelected = '';
  String managerMobileSelected = '';
  String managerEmailSelected = '';
  String managerAddressSelected = '';

  void _showDialog() {
    final mangerName = TextEditingController(text: managerNameSelected);
    final managerMobile = TextEditingController(text: managerMobileSelected);
    final managerEmail = TextEditingController(text: managerEmailSelected);
    final managerAdress = TextEditingController(text: managerAddressSelected);

    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      closeIcon: Icon(
        IconlyBroken.close_square,
        size: 40,
        color: MyColors.primaryColor,
      ),
      showCloseIcon: true,
      body: Form(
        key: _mangerkey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Training Center Manager Info',
              style:
                  GoogleFonts.aBeeZee(textStyle: const TextStyle(fontSize: 15)),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 10, top: 15),
              child: TextFormField(
                controller: mangerName,
                onChanged: (value) {
                  setState(() {});
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid Name';
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
                    hintText: "Enter name",
                    label: Text("Name",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? const Color.fromARGB(255, 195, 195, 195)
                                  : const Color.fromARGB(255, 99, 99, 99)),
                        )),
                    hintStyle: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    prefixIcon: Icon(
                      Icons.assignment_ind_outlined,
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? Colors.grey
                          : const Color.fromARGB(255, 72, 96, 176),
                      size: 28,
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
                      borderSide:
                          BorderSide(width: 0.8, color: MyColors.primaryColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorStyle: const TextStyle(color: Colors.red)),
                maxLines: 3,
                minLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 10,
              ),
              child: TextFormField(
                controller: managerMobile,
                onChanged: (value) {
                  setState(() {});
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10), // Limit to 10 digits
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid Mobile Number';
                  } else if (value.length != 10) {
                    return 'Mobile Number must be 10 digits';
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
                    hintText: "Enter Contact Number",
                    label: Text("Contact Number",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? const Color.fromARGB(255, 195, 195, 195)
                                  : const Color.fromARGB(255, 99, 99, 99)),
                        )),
                    hintStyle: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? Colors.grey
                          : const Color.fromARGB(255, 72, 96, 176),
                      size: 28,
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
                      borderSide:
                          BorderSide(width: 0.8, color: MyColors.primaryColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorStyle: const TextStyle(color: Colors.red)),
                maxLines: 3,
                minLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 10, top: 0),
              child: TextFormField(
                controller: managerEmail,
                onChanged: (value) {
                  setState(() {});
                },
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
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(18),
                    filled: true,
                    fillColor: AdaptiveTheme.of(context).mode.isDark
                        ? const Color.fromARGB(255, 56, 56, 56)
                        : Colors.white,
                    // fillColor: Colors.white,
                    hintText: "Enter email",
                    label: Text("Email",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? const Color.fromARGB(255, 195, 195, 195)
                                  : const Color.fromARGB(255, 99, 99, 99)),
                        )),
                    hintStyle: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? Colors.grey
                          : const Color.fromARGB(255, 72, 96, 176),
                      size: 28,
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
                      borderSide:
                          BorderSide(width: 0.8, color: MyColors.primaryColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorStyle: const TextStyle(color: Colors.red)),
                maxLines: 3,
                minLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 10, top: 0),
              child: TextFormField(
                controller: managerAdress,
                onChanged: (value) {
                  setState(() {});
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid address';
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
                    hintText: "Enter address",
                    label: Text("Address",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? const Color.fromARGB(255, 195, 195, 195)
                                  : const Color.fromARGB(255, 99, 99, 99)),
                        )),
                    hintStyle: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? Colors.grey
                          : const Color.fromARGB(255, 72, 96, 176),
                      size: 28,
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
                      borderSide:
                          BorderSide(width: 0.8, color: MyColors.primaryColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: const BorderSide(width: 1, color: Colors.red),
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
                              color: Colors.white, fontWeight: FontWeight.w500),
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
                      if (_mangerkey.currentState!.validate()) {
                        setState(() {
                          managerNameSelected = mangerName.text;
                          managerAddressSelected = managerAdress.text;
                          managerEmailSelected = managerEmail.text;
                          managerMobileSelected = managerMobile.text;
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color.fromARGB(255, 87, 200, 115)),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Submit",
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
  }

  final TutionCenterBloc tutionCenterBloc = TutionCenterBloc();

  final TextEditingController _tutionName = TextEditingController();
  final TextEditingController _tutionadress = TextEditingController();
  final TextEditingController _tutionSubcription = TextEditingController();

  String namechange = '';
  String addressChange = '';
  String subscriptionChange = '';

  final _formKey = GlobalKey<FormState>();
  final _mangerkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TutionCenterBloc, TutionCenterState>(
      bloc: tutionCenterBloc,
      listenWhen: (previous, current) => current is TutionActionCenterState,
      buildWhen: (previous, current) => current is! TutionActionCenterState,
      listener: (context, state) {
        if (state is BackToBottomPageState) {
          Navigator.pushReplacementNamed(context, MyRoutes.bottom);
        } else if (state is ErrorWithoutAddingMangerInfoState) {
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Warning',
              message: 'Please enter Manager Info before submitting.',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.warning,
              color: MyColors.primaryColor,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is TrainingCenterLoadingState) {
          showDialog(
            context: context,

            barrierDismissible:
                false, // Set to true if you want to dismiss the dialog on tap outside
            builder: (BuildContext context) {
              return  AlertDialog(
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
        } else if (state is TrainingCenterSuccessInsertState) {
          Navigator.pushReplacementNamed(context, MyRoutes.addCenter);
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Success',
              message: 'Training center added successfully.',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is TrainingCenterFailedInsertState) {
          Navigator.pushReplacementNamed(context, MyRoutes.addCenter);
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Failed',
              message: 'Failed to add training center.',

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
        return Scaffold(
          backgroundColor: AdaptiveTheme.of(context).mode.isDark
              ? const Color.fromARGB(255, 56, 56, 56)
              : Colors.white,
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 10),
            child: SizedBox(
              height: 50,
              width: double
                  .infinity, // Set width to take up the entire screen width
              child: managerNameSelected != ''
                  ? ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          tutionCenterBloc.add(OnSubmitTrainingCenterEvent(
                              trainingCenterName: _tutionName.text,
                              trainingCenterAddress: _tutionadress.text,
                              trainingCenterSubscriptionAmount:
                                  _tutionSubcription.text,
                              managerName: managerNameSelected,
                              managerContact: managerMobileSelected,
                              managerEmail: managerEmailSelected,
                              managerAddress: managerAddressSelected));
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
                          Text('SUBMIT',
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
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          tutionCenterBloc
                              .add(ErrorWithoutAddingMangerInfoEvent());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          // backgroundColor: const Color.fromARGB(255, 69, 160, 72),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10)) // Set the button's background color to green
                          ),
                      child: Row(
                        children: [
                          Text('SUBMIT',
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
                    ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: AdaptiveTheme.of(context).mode.isDark
                ? const Color.fromARGB(255, 56, 56, 56)
                : Colors.white,
            elevation: 0,
            centerTitle: false,
            title: Text("Add Training Center",
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
                tutionCenterBloc.add(BackToBottomPage());
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AdaptiveTheme.of(context).mode.isDark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              tutionCenterBloc.add(BackToBottomPage());
              return false;
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AdaptiveTheme.of(context).mode.isDark
                      ? const Color.fromARGB(255, 56, 56, 56)
                      : Colors.white,
                  automaticallyImplyLeading: false,
                  expandedHeight: 330,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                              height: 330,
                              width: MediaQuery.of(context).size.width,
                              child: AdaptiveTheme.of(context).mode.isDark
                                  ? Image.asset(
                                      'assets/images/center_add_dark.png',
                                      fit: BoxFit.fitWidth,
                                    )
                                  : Image.asset(
                                      'assets/images/center_add_light.png',
                                      fit: BoxFit.fitWidth,
                                    )),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: namechange != '' ? 15 : 10),
                          child: TextFormField(
                            controller: _tutionName,
                            onChanged: (value) {
                              setState(() {
                                namechange = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid Name';
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
                                hintText: "Enter Training Center Name",
                                label: Text("Training Center Name",
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? const Color.fromARGB(
                                                  255, 195, 195, 195)
                                              : const Color.fromARGB(
                                                  255, 99, 99, 99)),
                                    )),
                                hintStyle: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                prefixIcon: Icon(
                                  Icons.account_balance_sharp,
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.grey
                                      : MyColors.primaryColor,
                                  size: 28,
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
                                errorStyle: const TextStyle(color: Colors.red)),
                            maxLines: 3,
                            minLines: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: addressChange != '' ? 15 : 10),
                          child: TextFormField(
                            controller: _tutionadress,
                            onChanged: (value) {
                              setState(() {
                                addressChange = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid address';
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
                                hintText: "Enter Training Center Address",
                                label: Text("Training Center Address",
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? const Color.fromARGB(
                                                  255, 195, 195, 195)
                                              : const Color.fromARGB(
                                                  255, 99, 99, 99)),
                                    )),
                                hintStyle: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                prefixIcon: Icon(
                                  IconlyBroken.location,
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.grey
                                      : MyColors.primaryColor,
                                  size: 28,
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
                                errorStyle: const TextStyle(color: Colors.red)),
                            maxLines: 3,
                            minLines: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: subscriptionChange != '' ? 15 : 10),
                          child: TextFormField(
                            controller: _tutionSubcription,
                            onChanged: (value) {
                              subscriptionChange = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid amount';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18),
                                filled: true,
                                fillColor: AdaptiveTheme.of(context).mode.isDark
                                    ? const Color.fromARGB(255, 56, 56, 56)
                                    : Colors.white,
                                // fillColor: Colors.white,
                                hintText: "Enter Subscription Amount",
                                label: Text("Subscription Amount",
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? const Color.fromARGB(
                                                  255, 195, 195, 195)
                                              : const Color.fromARGB(
                                                  255, 99, 99, 99)),
                                    )),
                                hintStyle: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                prefixIcon: Icon(
                                  IconlyLight.ticket,
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.grey
                                      : MyColors.primaryColor,
                                  size: 28,
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
                                errorStyle: const TextStyle(color: Colors.red)),
                            maxLines: 3,
                            minLines: 1,
                          ),
                        ),
                        managerNameSelected == ''
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, top: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _showDialog();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                           color:MyColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Add Manger Info',
                                                style: GoogleFonts.lato(
                                                    textStyle: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Icon(
                                                IconlyBroken.add_user,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color.fromARGB(
                                              255, 193, 193, 193))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5,
                                        left: 10,
                                        right: 10,
                                        bottom: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                            visualDensity: const VisualDensity(
                                                vertical: -4, horizontal: 0),
                                            leading: CircleAvatar(
                                              child: Image.asset(
                                                  'assets/images/malemanager.png'),
                                            ),
                                            trailing: GestureDetector(
                                                onTap: () {
                                                  _showDialog();
                                                },
                                                child: const Icon(
                                                    IconlyBroken.edit)),
                                            title: Text(
                                              'Training Center Manager',
                                              style: GoogleFonts.aBeeZee(
                                                  fontSize: 16),
                                            ),
                                            subtitle: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 0),
                                              child: Text(
                                                'Name : $managerNameSelected',
                                                style: GoogleFonts.lato(
                                                    fontSize: 15),
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0.0,
                                                    horizontal: 0.0),
                                            minVerticalPadding: 0),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 56,
                                              top: 0), // Adjust padding here
                                          child: Text(
                                            'Contact : $managerMobileSelected',
                                            style:
                                                GoogleFonts.lato(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 56,
                                              top: 0), // Adjust padding here
                                          child: Text(
                                            'Email : $managerEmailSelected',
                                            style:
                                                GoogleFonts.lato(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 56,
                                              top: 0), // Adjust padding here
                                          child: Text(
                                            'Address : $managerAddressSelected',
                                            style:
                                                GoogleFonts.lato(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  )
                ]))
              ],
            ),
          ),
        );
      },
    );
  }
}
