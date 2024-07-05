// // ignore_for_file: file_names

// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconly/iconly.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:lottie/lottie.dart';
// import 'package:staff_client_side/colors/colors.dart';
// import 'package:staff_client_side/features/coachingManager/bloc/coaching_manager_bloc.dart';
// import 'package:staff_client_side/routes/routes.dart';

// class CreateClassShedulePage extends StatefulWidget {
//   const CreateClassShedulePage({super.key});

//   @override
//   State<CreateClassShedulePage> createState() => _CreateClassShedulePageState();
// }

// class _CreateClassShedulePageState extends State<CreateClassShedulePage> {
//   @override
//   void initState() {
//     super.initState();
//     coachingManagerBloc.add(CreateClassSheduleEvent());
//   }

//   String? staff;
//   String? staffUserId;
//   String? subject;
//   String? subjectId;
//   String? batch;
//   String? batchId;
//   String? classroom;
//   String? classroomId;

//   final CoachingManagerBloc coachingManagerBloc = CoachingManagerBloc();
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CoachingManagerBloc, CoachingManagerState>(
//       bloc: coachingManagerBloc,
//       listenWhen: (previous, current) => current is CoachingManagerActionState,
//       buildWhen: (previous, current) => current is! CoachingManagerActionState,
//       listener: (context, state) {
//         if (state is BackToDashboardPageState) {
//           Navigator.pushReplacementNamed(context, MyRoutes.bottom);
//         } else if (state is CoachingManagerActionLoader) {
//           showDialog(
//             context: context,

//             barrierDismissible:
//                 false, // Set to true if you want to dismiss the dialog on tap outside
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     LoadingAnimationWidget.hexagonDots(
//                       color: MyColors.primaryColor,
//                       size: 50,
//                     ),
//                     const SizedBox(height: 16.0),
//                     const Text('Please wait...'),
//                   ],
//                 ),
//               );
//             },
//           );
//         } else if (state is ClassSheduleInsertedSuccessState) {
//           Navigator.pushReplacementNamed(context, MyRoutes.listAllStaffs);
//           final snackBar = SnackBar(
//             /// need to set following properties for best effect of awesome_snackbar_content
//             elevation: 0,
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.transparent,
//             content: AwesomeSnackbarContent(
//               title: 'Success',
//               message: 'The class schedule has been successfully added.',

//               /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//               contentType: ContentType.success,
//             ),
//           );

//           ScaffoldMessenger.of(context)
//             ..hideCurrentSnackBar()
//             ..showSnackBar(snackBar);
//         } else if (state is ClassSheduleInsertedFailedState) {
//           Navigator.pushReplacementNamed(context, MyRoutes.listAllStaffs);
//           final snackBar = SnackBar(
//             /// need to set following properties for best effect of awesome_snackbar_content
//             elevation: 0,
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.transparent,
//             content: AwesomeSnackbarContent(
//               title: 'Failed',
//               message: 'The class schedule has been failed.',

//               /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//               contentType: ContentType.failure,
//             ),
//           );

//           ScaffoldMessenger.of(context)
//             ..hideCurrentSnackBar()
//             ..showSnackBar(snackBar);
//         }
//       },
//       builder: (context, state) {
//         switch (state.runtimeType) {
//           case ClassSheduleLoader:
//             return Scaffold(
//                 backgroundColor: AdaptiveTheme.of(context).mode.isDark
//                     ? const Color.fromARGB(255, 56, 56, 56)
//                     : Colors.white,
//                 appBar: AppBar(
//                   backgroundColor: AdaptiveTheme.of(context).mode.isDark
//                       ? const Color.fromARGB(255, 56, 56, 56)
//                       : Colors.white,
//                   elevation: 0,
//                   centerTitle: false,
//                   title: Text("Create Class Shedule",
//                       style: GoogleFonts.lato(
//                         textStyle: TextStyle(
//                             fontSize: 19,
//                             color: AdaptiveTheme.of(context).mode.isDark
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontFamily: "Lato",
//                             fontWeight: FontWeight.bold),
//                       )),
//                   leading: IconButton(
//                     onPressed: () {
//                       coachingManagerBloc.add(BacktoDashboardPage());
//                     },
//                     icon: Icon(
//                       Icons.arrow_back_ios_new,
//                       color: AdaptiveTheme.of(context).mode.isDark
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   ),
//                 ),
//                 body: const Center(
//                   child: CircularProgressIndicator(),
//                 ));
//           case CreateClassSheduleState:
//             final successState = state as CreateClassSheduleState;
//             return Scaffold(
//               backgroundColor: AdaptiveTheme.of(context).mode.isDark
//                   ? const Color.fromARGB(255, 56, 56, 56)
//                   : Colors.white,
//               appBar: AppBar(
//                 backgroundColor: AdaptiveTheme.of(context).mode.isDark
//                     ? const Color.fromARGB(255, 56, 56, 56)
//                     : Colors.white,
//                 elevation: 0,
//                 centerTitle: false,
//                 title: Text("Create Class Shedule",
//                     style: GoogleFonts.lato(
//                       textStyle: TextStyle(
//                           fontSize: 19,
//                           color: AdaptiveTheme.of(context).mode.isDark
//                               ? Colors.white
//                               : Colors.black,
//                           fontFamily: "Lato",
//                           fontWeight: FontWeight.bold),
//                     )),
//                 leading: IconButton(
//                   onPressed: () {
//                     coachingManagerBloc.add(BacktoDashboardPage());
//                   },
//                   icon: Icon(
//                     Icons.arrow_back_ios_new,
//                     color: AdaptiveTheme.of(context).mode.isDark
//                         ? Colors.white
//                         : Colors.black,
//                   ),
//                 ),
//               ),
//               bottomNavigationBar: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 15, right: 15, top: 10, bottom: 10),
//                   child: SizedBox(
//                       height: 50,
//                       width: double
//                           .infinity, // Set width to take up the entire screen width
//                       child: staffUserId != null &&
//                               subjectId != null &&
//                               batchId != null &&
//                               classroomId != null
//                           ? ElevatedButton(
//                               onPressed: () {
//                                 coachingManagerBloc.add(
//                                     OnClickCreateClassSheduleEvent(
//                                         staffId: staffUserId!,
//                                         subjectId: subjectId!,
//                                         batchId: batchId!,
//                                         classRoomId: classroomId!));
//                               },
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: MyColors.primaryColor,
//                                   // backgroundColor: const Color.fromARGB(255, 69, 160, 72),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           10)) // Set the button's background color to green
//                                   ),
//                               child: Row(
//                                 children: [
//                                   Text('SUBMIT',
//                                       style: GoogleFonts.lato(
//                                         textStyle: const TextStyle(
//                                           color: Colors.white,
//                                           fontFamily:
//                                               'Lato', // Set the text color to white
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       )),
//                                   const Spacer(),
//                                   SizedBox(
//                                     height: 20,
//                                     child: Lottie.asset(
//                                       'assets/lottie/right.json',
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )
//                           : ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.grey,
//                                   // backgroundColor: const Color.fromARGB(255, 69, 160, 72),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           10)) // Set the button's background color to green
//                                   ),
//                               child: Row(
//                                 children: [
//                                   Text('SUBMIT',
//                                       style: GoogleFonts.lato(
//                                         textStyle: const TextStyle(
//                                           color: Colors.white,
//                                           fontFamily:
//                                               'Lato', // Set the text color to white
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       )),
//                                   const Spacer(),
//                                   SizedBox(
//                                     height: 20,
//                                     child: Lottie.asset(
//                                       'assets/lottie/right.json',
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ))),
//               body: CustomScrollView(
//                 slivers: [
//                   SliverAppBar(
//                     backgroundColor: AdaptiveTheme.of(context).mode.isDark
//                         ? const Color.fromARGB(255, 56, 56, 56)
//                         : Colors.white,
//                     automaticallyImplyLeading: false,
//                     expandedHeight: 250,
//                     flexibleSpace: FlexibleSpaceBar(
//                       background: Stack(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 10, left: 15, right: 15),
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                     color: AdaptiveTheme.of(context).mode.isDark
//                                         ? Colors.transparent
//                                         : Colors.transparent,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 height: AdaptiveTheme.of(context).mode.isDark
//                                     ? 260
//                                     : 260,
//                                 width: MediaQuery.of(context).size.width,
//                                 child: AdaptiveTheme.of(context).mode.isDark
//                                     ? Image.asset(
//                                         'assets/images/classShedule.png',
//                                         fit: BoxFit.fitWidth,
//                                       )
//                                     : Image.asset(
//                                         'assets/images/classShedule.png',
//                                         fit: BoxFit.fitWidth,
//                                       )),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverList(
//                       delegate: SliverChildListDelegate([
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 15, right: 15, top: 25, bottom: 18),
//                       child: DropdownSearch<String>(
//                         items: successState.staffAllList
//                             .map((staff) => staff['name'])
//                             .toList()
//                             .cast<String>(),
//                         dropdownBuilder: (context, item) => ListTile(
//                           title: Text(staff != null
//                               ? staff.toString()
//                               : 'Select Staff'),
//                         ),
//                         popupProps: PopupPropsMultiSelection.modalBottomSheet(
//                           showSearchBox: true,
//                           searchDelay: const Duration(microseconds: 100),
//                           constraints: const BoxConstraints(),
//                           searchFieldProps: TextFieldProps(
//                               decoration: InputDecoration(
//                             prefixIcon: const Icon(IconlyBroken.search),
//                             fillColor: AdaptiveTheme.of(context).mode.isDark
//                                 ? const Color.fromARGB(255, 39, 39, 39)
//                                 : Colors.white,
//                             filled: true,
//                             hintText: 'Search staff here',
//                             hintStyle:
//                                 const TextStyle(fontWeight: FontWeight.w400),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 193, 193, 193),
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 98, 216, 127),
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           )),
//                           containerBuilder: (ctx, popupWidget) {
//                             return Container(
//                               color: AdaptiveTheme.of(context).mode.isDark
//                                   ? const Color.fromARGB(255, 49, 49, 49)
//                                   : Colors.white,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 20, left: 20, right: 20),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 10, bottom: 10),
//                                       child: Row(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.red),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   color: const Color.fromARGB(
//                                                       255, 253, 231, 229)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10,
//                                                     right: 10,
//                                                     top: 4,
//                                                     bottom: 4),
//                                                 child: Row(
//                                                   children: [
//                                                     //Spacer(),
//                                                     Icon(
//                                                       Icons.chevron_left_sharp,
//                                                       color: AdaptiveTheme.of(
//                                                                   context)
//                                                               .mode
//                                                               .isDark
//                                                           ? const Color
//                                                               .fromARGB(
//                                                               255, 39, 39, 39)
//                                                           : Colors.black,
//                                                     ),
//                                                     const SizedBox(
//                                                       width: 3,
//                                                     ),
//                                                     Text(
//                                                       "Back",
//                                                       style: TextStyle(
//                                                           color: AdaptiveTheme.of(
//                                                                       context)
//                                                                   .mode
//                                                                   .isDark
//                                                               ? const Color
//                                                                   .fromARGB(255,
//                                                                   39, 39, 39)
//                                                               : Colors.black),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(child: popupWidget),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             staff = value!;
//                             // Find the selected institution object
//                             var selectStaff =
//                                 successState.staffAllList.firstWhere(
//                               (staff) => staff['name'] == value,
//                               orElse: () => null,
//                             );

//                             // Check if the institution was found
//                             if (selectStaff != null) {
//                               staffUserId = selectStaff['_id'];
//                               print(staffUserId);
//                             }
//                           });

//                           // Handle search functionality here
//                         },
//                         dropdownDecoratorProps: DropDownDecoratorProps(
//                             dropdownSearchDecoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(2),
//                           filled: true,
//                           fillColor: AdaptiveTheme.of(context).mode.isDark
//                               ? const Color.fromARGB(255, 56, 56, 56)
//                               : Colors.white,
//                           hintText: "Select Staff",
//                           label: const Text("Staff"),
//                           hintStyle: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           prefixIcon: Icon(
//                             IconlyBroken.profile,
//                             color: AdaptiveTheme.of(context).mode.isDark
//                                 ? Colors.grey
//                                 : const Color.fromARGB(255, 72, 96, 176),
//                             size: 28,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               width: 1,
//                               color: Color.fromARGB(255, 193, 193, 193),
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               width: 1,
//                               color: Color.fromARGB(255, 98, 216, 127),
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(width: 1, color: Colors.red),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(width: 1, color: Colors.red),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           errorStyle: const TextStyle(color: Colors.red),
//                         )),
//                         validator: (value) {
//                           if (value == null && staff == null) {
//                             return 'Please select batch';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 15, right: 15, top: 0, bottom: 18),
//                       child: DropdownSearch<String>(
//                         items: successState.subjectList
//                             .map((subject) => subject['subject_name'])
//                             .toList()
//                             .cast<String>(),
//                         dropdownBuilder: (context, item) => ListTile(
//                           title: Text(subject != null
//                               ? subject.toString()
//                               : 'Select subject'),
//                         ),
//                         popupProps: PopupPropsMultiSelection.modalBottomSheet(
//                           showSearchBox: true,
//                           searchDelay: const Duration(microseconds: 100),
//                           constraints: const BoxConstraints(),
//                           searchFieldProps: TextFieldProps(
//                               decoration: InputDecoration(
//                             prefixIcon: const Icon(IconlyBroken.search),
//                             fillColor: AdaptiveTheme.of(context).mode.isDark
//                                 ? const Color.fromARGB(255, 39, 39, 39)
//                                 : Colors.white,
//                             filled: true,
//                             hintText: 'Search subject',
//                             hintStyle:
//                                 const TextStyle(fontWeight: FontWeight.w400),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 193, 193, 193),
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 98, 216, 127),
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           )),
//                           containerBuilder: (ctx, popupWidget) {
//                             return Container(
//                               color: AdaptiveTheme.of(context).mode.isDark
//                                   ? const Color.fromARGB(255, 49, 49, 49)
//                                   : Colors.white,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 20, left: 20, right: 20),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 10, bottom: 10),
//                                       child: Row(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.red),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   color: const Color.fromARGB(
//                                                       255, 253, 231, 229)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10,
//                                                     right: 10,
//                                                     top: 4,
//                                                     bottom: 4),
//                                                 child: Row(
//                                                   children: [
//                                                     //Spacer(),
//                                                     Icon(
//                                                       Icons.chevron_left_sharp,
//                                                       color: AdaptiveTheme.of(
//                                                                   context)
//                                                               .mode
//                                                               .isDark
//                                                           ? const Color
//                                                               .fromARGB(
//                                                               255, 39, 39, 39)
//                                                           : Colors.black,
//                                                     ),
//                                                     const SizedBox(
//                                                       width: 3,
//                                                     ),
//                                                     Text(
//                                                       "Back",
//                                                       style: TextStyle(
//                                                           color: AdaptiveTheme.of(
//                                                                       context)
//                                                                   .mode
//                                                                   .isDark
//                                                               ? const Color
//                                                                   .fromARGB(255,
//                                                                   39, 39, 39)
//                                                               : Colors.black),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(child: popupWidget),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             subject = value!;
//                             // Find the selected institution object
//                             var selectSubject =
//                                 successState.subjectList.firstWhere(
//                               (subject) => subject['subject_name'] == value,
//                               orElse: () => null,
//                             );

//                             // Check if the institution was found
//                             if (selectSubject != null) {
//                               subjectId = selectSubject['_id'];
//                               print(subjectId);
//                             }
//                           });

//                           // Handle search functionality here
//                         },
//                         dropdownDecoratorProps: DropDownDecoratorProps(
//                             dropdownSearchDecoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(2),
//                           filled: true,
//                           fillColor: AdaptiveTheme.of(context).mode.isDark
//                               ? const Color.fromARGB(255, 56, 56, 56)
//                               : Colors.white,
//                           hintText: "Select Subject",
//                           label: const Text("Subject"),
//                           hintStyle: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           prefixIcon: Icon(
//                             IconlyBroken.document,
//                             color: AdaptiveTheme.of(context).mode.isDark
//                                 ? Colors.grey
//                                 : const Color.fromARGB(255, 72, 96, 176),
//                             size: 28,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               width: 1,
//                               color: Color.fromARGB(255, 193, 193, 193),
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               width: 1,
//                               color: Color.fromARGB(255, 98, 216, 127),
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(width: 1, color: Colors.red),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(width: 1, color: Colors.red),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           errorStyle: const TextStyle(color: Colors.red),
//                         )),
//                         validator: (value) {
//                           if (value == null && subject == null) {
//                             return 'Please select subject';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 15, right: 15, top: 0, bottom: 18),
//                       child: DropdownSearch<String>(
//                         items: successState.batchTimeList
//                             .map((batch) => batch['batch_time'])
//                             .toList()
//                             .cast<String>(),
//                         dropdownBuilder: (context, item) => ListTile(
//                           title: Text(batch != null
//                               ? batch.toString()
//                               : 'Select Batch Time'),
//                         ),
//                         popupProps: PopupPropsMultiSelection.modalBottomSheet(
//                           showSearchBox: true,
//                           searchDelay: const Duration(microseconds: 100),
//                           constraints: const BoxConstraints(),
//                           searchFieldProps: TextFieldProps(
//                               decoration: InputDecoration(
//                             prefixIcon: const Icon(IconlyBroken.search),
//                             fillColor: AdaptiveTheme.of(context).mode.isDark
//                                 ? const Color.fromARGB(255, 39, 39, 39)
//                                 : Colors.white,
//                             filled: true,
//                             hintText: 'Search Batch Time',
//                             hintStyle:
//                                 const TextStyle(fontWeight: FontWeight.w400),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 193, 193, 193),
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 98, 216, 127),
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           )),
//                           containerBuilder: (ctx, popupWidget) {
//                             return Container(
//                               color: AdaptiveTheme.of(context).mode.isDark
//                                   ? const Color.fromARGB(255, 49, 49, 49)
//                                   : Colors.white,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 20, left: 20, right: 20),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 10, bottom: 10),
//                                       child: Row(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.red),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   color: const Color.fromARGB(
//                                                       255, 253, 231, 229)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10,
//                                                     right: 10,
//                                                     top: 4,
//                                                     bottom: 4),
//                                                 child: Row(
//                                                   children: [
//                                                     //Spacer(),
//                                                     Icon(
//                                                       Icons.chevron_left_sharp,
//                                                       color: AdaptiveTheme.of(
//                                                                   context)
//                                                               .mode
//                                                               .isDark
//                                                           ? const Color
//                                                               .fromARGB(
//                                                               255, 39, 39, 39)
//                                                           : Colors.black,
//                                                     ),
//                                                     const SizedBox(
//                                                       width: 3,
//                                                     ),
//                                                     Text(
//                                                       "Back",
//                                                       style: TextStyle(
//                                                           color: AdaptiveTheme.of(
//                                                                       context)
//                                                                   .mode
//                                                                   .isDark
//                                                               ? const Color
//                                                                   .fromARGB(255,
//                                                                   39, 39, 39)
//                                                               : Colors.black),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(child: popupWidget),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             batch = value!;
//                             // Find the selected institution object
//                             var selectBatch =
//                                 successState.batchTimeList.firstWhere(
//                               (batch) => batch['batch_time'] == value,
//                               orElse: () => null,
//                             );

//                             // Check if the institution was found
//                             if (selectBatch != null) {
//                               batchId = selectBatch['_id'];
//                               //print(batchId);
//                             }
//                           });

//                           // Handle search functionality here
//                         },
//                         dropdownDecoratorProps: DropDownDecoratorProps(
//                             dropdownSearchDecoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(2),
//                           filled: true,
//                           fillColor: AdaptiveTheme.of(context).mode.isDark
//                               ? const Color.fromARGB(255, 56, 56, 56)
//                               : Colors.white,
//                           hintText: "Select Batch Time",
//                           label: const Text("Batch Time"),
//                           hintStyle: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           prefixIcon: Icon(
//                             IconlyBroken.time_circle,
//                             color: AdaptiveTheme.of(context).mode.isDark
//                                 ? Colors.grey
//                                 : const Color.fromARGB(255, 72, 96, 176),
//                             size: 28,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               width: 1,
//                               color: Color.fromARGB(255, 193, 193, 193),
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               width: 1,
//                               color: Color.fromARGB(255, 98, 216, 127),
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(width: 1, color: Colors.red),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(width: 1, color: Colors.red),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           errorStyle: const TextStyle(color: Colors.red),
//                         )),
//                         validator: (value) {
//                           if (value == null && batch == null) {
//                             return 'Please select batch time';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 15, right: 15, top: 0, bottom: 18),
//                       child: DropdownSearch<String>(
//                         items: successState.classrooms
//                             .map((classRoom) => classRoom['class_room'])
//                             .toList()
//                             .cast<String>(),
//                         dropdownBuilder: (context, item) => ListTile(
//                           title: Text(classroom != null
//                               ? classroom.toString()
//                               : 'Select class room'),
//                         ),
//                         popupProps: PopupPropsMultiSelection.modalBottomSheet(
//                           showSearchBox: true,
//                           searchDelay: const Duration(microseconds: 100),
//                           constraints: const BoxConstraints(),
//                           searchFieldProps: TextFieldProps(
//                               decoration: InputDecoration(
//                             prefixIcon: const Icon(IconlyBroken.search),
//                             fillColor: AdaptiveTheme.of(context).mode.isDark
//                                 ? const Color.fromARGB(255, 39, 39, 39)
//                                 : Colors.white,
//                             filled: true,
//                             hintText: 'Search class room',
//                             hintStyle:
//                                 const TextStyle(fontWeight: FontWeight.w400),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 193, 193, 193),
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 98, 216, 127),
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           )),
//                           containerBuilder: (ctx, popupWidget) {
//                             return Container(
//                               color: AdaptiveTheme.of(context).mode.isDark
//                                   ? const Color.fromARGB(255, 49, 49, 49)
//                                   : Colors.white,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 20, left: 20, right: 20),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 10, bottom: 10),
//                                       child: Row(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.red),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   color: const Color.fromARGB(
//                                                       255, 253, 231, 229)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10,
//                                                     right: 10,
//                                                     top: 4,
//                                                     bottom: 4),
//                                                 child: Row(
//                                                   children: [
//                                                     //Spacer(),
//                                                     Icon(
//                                                       Icons.chevron_left_sharp,
//                                                       color: AdaptiveTheme.of(
//                                                                   context)
//                                                               .mode
//                                                               .isDark
//                                                           ? const Color
//                                                               .fromARGB(
//                                                               255, 39, 39, 39)
//                                                           : Colors.black,
//                                                     ),
//                                                     const SizedBox(
//                                                       width: 3,
//                                                     ),
//                                                     Text(
//                                                       "Back",
//                                                       style: TextStyle(
//                                                           color: AdaptiveTheme.of(
//                                                                       context)
//                                                                   .mode
//                                                                   .isDark
//                                                               ? const Color
//                                                                   .fromARGB(255,
//                                                                   39, 39, 39)
//                                                               : Colors.black),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(child: popupWidget),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             classroom = value!;
//                             // Find the selected institution object
//                             var selectClassRoom =
//                                 successState.classrooms.firstWhere(
//                               (classRoom) => classRoom['class_room'] == value,
//                               orElse: () => null,
//                             );

//                             // Check if the institution was found
//                             if (selectClassRoom != null) {
//                               classroomId = selectClassRoom['_id'];
//                               print(classroomId);
//                             }
//                           });

//                           // Handle search functionality here
//                         },
//                         dropdownDecoratorProps: DropDownDecoratorProps(
//                             dropdownSearchDecoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(2),
//                           filled: true,
//                           fillColor: AdaptiveTheme.of(context).mode.isDark
//                               ? const Color.fromARGB(255, 56, 56, 56)
//                               : Colors.white,
//                           hintText: "Select Class Room",
//                           label: const Text("Class Room"),
//                           hintStyle: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           prefixIcon: Icon(
//                             IconlyBroken.profile,
//                             color: AdaptiveTheme.of(context).mode.isDark
//                                 ? Colors.grey
//                                 : const Color.fromARGB(255, 72, 96, 176),
//                             size: 28,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               width: 1,
//                               color: Color.fromARGB(255, 193, 193, 193),
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               width: 1,
//                               color: Color.fromARGB(255, 98, 216, 127),
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(width: 1, color: Colors.red),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(width: 1, color: Colors.red),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           errorStyle: const TextStyle(color: Colors.red),
//                         )),
//                         validator: (value) {
//                           if (value == null && staff == null) {
//                             return 'Please select class room';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ]))
//                 ],
//               ),
//             );
//           default:
//             return const SizedBox();
//         }
//       },
//     );
//   }
// }
