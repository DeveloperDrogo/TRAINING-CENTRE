import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:intl/intl.dart';

class AddStaffPage extends StatefulWidget {
  const AddStaffPage({super.key});

  @override
  State<AddStaffPage> createState() => _AddStaffPageState();
}

class _AddStaffPageState extends State<AddStaffPage> {
  final _formkey = GlobalKey<FormState>();

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

  final format = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
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
        title: Text("Add Staff",
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
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AdaptiveTheme.of(context).mode.isDark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: SizedBox(
            height: 50,
            width:
                double.infinity, // Set width to take up the entire screen width
            child: ElevatedButton(
              onPressed: () {},
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
                          fontFamily: 'Lato', // Set the text color to white
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
      body: CustomScrollView(
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
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Container(
                        decoration: BoxDecoration(
                            color: AdaptiveTheme.of(context).mode.isDark
                                ? MyColors.secondaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        height:
                            AdaptiveTheme.of(context).mode.isDark ? 260 : 260,
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
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
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
                          fillColor: AdaptiveTheme.of(context).mode.isDark
                              ? const Color.fromARGB(255, 56, 56, 56)
                              : Colors.white,
                          // fillColor: Colors.white,
                          hintText: "Enter Your Name",
                          label: Text(
                            "Name",
                            style: GoogleFonts.lato(),
                          ),
                          hintStyle: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          prefixIcon: Icon(
                            IconlyBroken.profile,
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
                                width: 1, color: MyColors.primaryColor),
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
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: DateTimeFormField(
                            lastDate: DateTime(DateTime.now().year - 1, 12, 31),
                            dateFormat: format,
                            dateTextStyle:
                                const TextStyle(fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: AdaptiveTheme.of(context).mode.isDark
                                    ? const Color.fromARGB(255, 56, 56, 56)
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
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 98, 216, 127)),
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
                            mode: DateTimeFieldPickerMode.date,
                            autovalidateMode: AutovalidateMode.disabled,
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
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: TextFormField(
                      style: GoogleFonts.lato(),
                      controller: email,
                      // ignore: body_might_complete_normally_nullable
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter valid Email';
                      //   }
                      // },

                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          isBlankGmail = value;
                        });
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AdaptiveTheme.of(context).mode.isDark
                              ? const Color.fromARGB(255, 56, 56, 56)
                              : Colors.white,
                          hintText: "Enter your Email",
                          label: Text(
                            "Email",
                            style: GoogleFonts.lato(),
                          ),
                          hintStyle: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          prefixIcon: Icon(
                            IconlyBroken.message,
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
                                width: 1, color: MyColors.primaryColor),
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
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: DropdownButtonFormField(
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 15,
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? Colors.white
                                  : Colors.black)),
                      value: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          isBlankGender = value.toString();
                          _selectedGender = value!;
                        });
                      },
                      items: <String>['Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AdaptiveTheme.of(context).mode.isDark
                              ? const Color.fromARGB(255, 56, 56, 56)
                              : Colors.white,
                          hintText: "Select Your Gender",
                          label: Text(
                            "Gender",
                            style: GoogleFonts.lato(),
                          ),
                          hintStyle: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          prefixIcon: Icon(
                            IconlyBroken.arrow_down_circle,
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
                                width: 1, color: MyColors.primaryColor),
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
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: DropdownButtonFormField(
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 15,
                              color: AdaptiveTheme.of(context).mode.isDark
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
                          fillColor: AdaptiveTheme.of(context).mode.isDark
                              ? const Color.fromARGB(255, 56, 56, 56)
                              : Colors.white,
                          hintText: "Select Your Blood Gorup",
                          label: Text(
                            "Blood Group",
                            style: GoogleFonts.lato(),
                          ),
                          hintStyle: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          prefixIcon: Icon(
                            IconlyBroken.arrow_down_circle,
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
                                width: 1, color: MyColors.primaryColor),
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
                          fillColor: AdaptiveTheme.of(context).mode.isDark
                              ? const Color.fromARGB(255, 56, 56, 56)
                              : Colors.white,
                          hintText: "Enter your address",
                          label: Text(
                            "Address",
                            style: GoogleFonts.lato(),
                          ),
                          hintStyle: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
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
                                width: 1, color: MyColors.primaryColor),
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
                          fillColor: AdaptiveTheme.of(context).mode.isDark
                              ? const Color.fromARGB(255, 56, 56, 56)
                              : Colors.white,
                          hintText: "Enter Your Qualification",
                          label: Text(
                            "Qualification",
                            style: GoogleFonts.lato(),
                          ),
                          hintStyle: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          prefixIcon: Icon(
                            IconlyBroken.document,
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
                                width: 1, color: MyColors.primaryColor),
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
                          fillColor: AdaptiveTheme.of(context).mode.isDark
                              ? const Color.fromARGB(255, 56, 56, 56)
                              : Colors.white,
                          hintText: "Enter Your Work Experience",
                          label: Text(
                            "Work Experience",
                            style: GoogleFonts.lato(),
                          ),
                          hintStyle: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          prefixIcon: Icon(
                            IconlyBroken.document,
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
                                width: 1, color: MyColors.primaryColor),
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: TextFormField(
                      style: GoogleFonts.lato(),
                      controller: pancard,
                      onChanged: (value) {
                        setState(() {
                          if (value.length > 10) {
                            pancard.text = value.substring(0, 10);
                            // Move cursor to the end
                            pancard.selection = TextSelection.fromPosition(
                                TextPosition(offset: pancard.text.length));
                          }
                          isBlankPancard = value.toUpperCase();
                        });
                      },
                      maxLength: 10,
                      textCapitalization: TextCapitalization.characters,

                      // ignore: body_might_complete_normally_nullable
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter valid Address';
                      //   }
                      // },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AdaptiveTheme.of(context).mode.isDark
                              ? const Color.fromARGB(255, 56, 56, 56)
                              : Colors.white,
                          hintText: "Enter Your Government ID",
                          label: Text(
                            "Government ID",
                            style: GoogleFonts.lato(),
                          ),
                          hintStyle: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          prefixIcon: Icon(
                            IconlyBroken.document,
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
                                width: 1, color: MyColors.primaryColor),
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
                    ),
                  ),
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}
