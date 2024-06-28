import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:staff_client_side/features/tutionCenter/bloc/tution_center_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:staff_client_side/features/tutionCenter/screens/editTution.dart';
import 'package:staff_client_side/routes/routes.dart';

class TrainingCenterInfo extends StatefulWidget {
  const TrainingCenterInfo({super.key});

  @override
  State<TrainingCenterInfo> createState() => _TrainingCenterInfoState();
}

class _TrainingCenterInfoState extends State<TrainingCenterInfo> {
  @override
  void initState() {
    super.initState();
    tutionCenterBloc.add(ListAllTrainingCentersEvent());
  }

  TextEditingController _searchController = TextEditingController();

  bool allfilterStatus = true;
  bool pendingfilterstatus = false;
  bool subscribedfilterstatus = false;
  bool deactivatedfilterstatus = false;

  String? filterStatus;

  TutionCenterBloc tutionCenterBloc = TutionCenterBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TutionCenterBloc, TutionCenterState>(
      bloc: tutionCenterBloc,
      listenWhen: (previous, current) => current is TutionActionCenterState,
      buildWhen: (previous, current) => current is! TutionActionCenterState,
      listener: (context, state) {
        if (state is BackToBottomPageState) {
          Navigator.pushReplacementNamed(context, MyRoutes.bottom);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ListTrainingCenterLoadState:
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
                title: Text("Training Centers",
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
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          case ListAllTrainingCentersState:
            final successState = state as ListAllTrainingCentersState;
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
                title: Text("Training Centers",
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
                child: SingleChildScrollView(
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
                            child: TextFormField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(15),
                                filled: true,
                                fillColor: AdaptiveTheme.of(context).mode.isDark
                                    ? const Color.fromARGB(255, 67, 67, 67)
                                    : const Color.fromARGB(255, 252, 254, 255),
                                hintText: "Search Training Center ",
                                hintStyle: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
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
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
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
                                        allfilterStatus = true;
                                        pendingfilterstatus = false;
                                        subscribedfilterstatus = false;
                                        deactivatedfilterstatus = false;
                                        filterStatus = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5),
                                          color: allfilterStatus
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
                                        child: Text('ALL',
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: allfilterStatus
                                                      ? Colors.white
                                                      : AdaptiveTheme.of(
                                                                  context)
                                                              .mode
                                                              .isDark
                                                          ? Colors.white
                                                          : const Color
                                                              .fromARGB(255,
                                                              111, 111, 111),
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
                                        allfilterStatus = false;
                                        pendingfilterstatus = true;
                                        subscribedfilterstatus = false;
                                        deactivatedfilterstatus = false;
                                        filterStatus = 'PENDING';
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5),
                                          color: pendingfilterstatus
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
                                        child: Text('PENDING',
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: pendingfilterstatus
                                                      ? Colors.white
                                                      : AdaptiveTheme.of(
                                                                  context)
                                                              .mode
                                                              .isDark
                                                          ? Colors.white
                                                          : const Color
                                                              .fromARGB(255,
                                                              111, 111, 111),
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
                                        allfilterStatus = false;
                                        pendingfilterstatus = false;
                                        subscribedfilterstatus = true;
                                        deactivatedfilterstatus = false;
                                        filterStatus = 'SUBSCRIBED';
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5),
                                          color: subscribedfilterstatus
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
                                        child: Text('SUBSCRIBED',
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: subscribedfilterstatus
                                                      ? Colors.white
                                                      : AdaptiveTheme.of(
                                                                  context)
                                                              .mode
                                                              .isDark
                                                          ? Colors.white
                                                          : const Color
                                                              .fromARGB(255,
                                                              111, 111, 111),
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
                                        allfilterStatus = false;
                                        pendingfilterstatus = false;
                                        subscribedfilterstatus = false;
                                        deactivatedfilterstatus = true;
                                        filterStatus = 'DEACTIVATED';
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5),
                                          color: deactivatedfilterstatus
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
                                        child: Text('DEACTIVATED',
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: deactivatedfilterstatus
                                                      ? Colors.white
                                                      : AdaptiveTheme.of(
                                                                  context)
                                                              .mode
                                                              .isDark
                                                          ? Colors.white
                                                          : const Color
                                                              .fromARGB(255,
                                                              111, 111, 111),
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
                      successState.trainingCenters
                              .where((training) =>
                                  _searchController.text.isEmpty ||
                                  training.trainingCenterName
                                      .toLowerCase()
                                      .contains(
                                          _searchController.text.toLowerCase()))
                              .isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 60),
                                    child: Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                          // image: DecorationImage(
                                          //     image: AssetImage(
                                          //         'assets/images/nonoti.jpg'))
                                          ),
                                      child: Lottie.asset(
                                          'assets/lottie/empty.json'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text("No Training Centers",
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                            fontSize: 24,
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.bold),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "No training centers found at the moment.",
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.w500),
                                      )),
                                  const SizedBox(
                                    height: 120,
                                  ),
                                ],
                              ),
                            )
                          : successState.trainingCenters
                                  .where((element) => filterStatus != null
                                      ? element.trainingCenterStatus ==
                                          filterStatus
                                      : element.isEmptyaFilter == '')
                                  .isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 60),
                                        child: Container(
                                          height: 200,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                              // image: DecorationImage(
                                              //     image: AssetImage(
                                              //         'assets/images/nonoti.jpg'))
                                              ),
                                          child: Lottie.asset(
                                              'assets/lottie/empty.json'),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text("No Training Centers",
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                fontSize: 24,
                                                fontFamily: "Lato",
                                                fontWeight: FontWeight.bold),
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "No training centers found at the moment.",
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Lato",
                                                fontWeight: FontWeight.w500),
                                          )),
                                      const SizedBox(
                                        height: 120,
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ListView.builder(
                                    itemCount: successState.trainingCenters
                                        .where((element) => filterStatus != null
                                            ? element.trainingCenterStatus ==
                                                filterStatus
                                            : element.isEmptyaFilter == '')
                                        .length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                     

                                      final trainingListInfo = successState
                                          .trainingCenters
                                          .where((element) => filterStatus !=
                                                  null
                                              ? element.trainingCenterStatus ==
                                                  filterStatus
                                              : element.isEmptyaFilter == '')
                                          .toList();

                                           if (_searchController.text.isNotEmpty &&
                                          !trainingListInfo[index]
                                              .trainingCenterName
                                              .toLowerCase()
                                              .contains(_searchController.text
                                                  .toLowerCase())) {
                                        return const SizedBox
                                            .shrink(); // Hide the item if not found
                                      }

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
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditTrainingCenterPage(
                                                          status: trainingListInfo[
                                                                  index]
                                                              .trainingCenterStatus,
                                                          isActivate:
                                                              trainingListInfo[
                                                                      index]
                                                                  .isActivate,
                                                          trainingCenterName:
                                                              trainingListInfo[
                                                                      index]
                                                                  .trainingCenterName,
                                                          trainingCenterAddress:
                                                              trainingListInfo[
                                                                      index]
                                                                  .trainingCenterAddress,
                                                          subscriptionAmount:
                                                              trainingListInfo[
                                                                      index]
                                                                  .trainingCenterSubscriptionAmount,
                                                          managerName:
                                                              trainingListInfo[
                                                                      index]
                                                                  .managerName,
                                                          managerMobile:
                                                              trainingListInfo[
                                                                      index]
                                                                  .managerNumber,
                                                          managerEmail:
                                                              trainingListInfo[
                                                                      index]
                                                                  .managerEmail,
                                                          managerAddress:
                                                              trainingListInfo[
                                                                      index]
                                                                  .managerAddress,
                                                          trainingCenterId:
                                                              trainingListInfo[
                                                                      index]
                                                                  .trainingCenterId,
                                                          managerUserId:
                                                              trainingListInfo[
                                                                      index]
                                                                  .managerUserId,
                                                          isSubscribed:
                                                              trainingListInfo[
                                                                      index]
                                                                  .isSubscribed,
                                                        ),
                                                      ));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 0.2,
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: AdaptiveTheme.of(
                                                                context)
                                                            .mode
                                                            .isDark
                                                        ? const Color.fromARGB(
                                                            255, 78, 78, 78)
                                                        : const Color.fromARGB(
                                                            255, 255, 255, 255),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color
                                                                .fromARGB(255,
                                                                201, 201, 201)
                                                            .withOpacity(0.5),
                                                        spreadRadius:
                                                            AdaptiveTheme.of(
                                                                        context)
                                                                    .mode
                                                                    .isDark
                                                                ? 0
                                                                : 0.5,
                                                        blurRadius:
                                                            AdaptiveTheme.of(
                                                                        context)
                                                                    .mode
                                                                    .isDark
                                                                ? 0
                                                                : 1,
                                                        offset: AdaptiveTheme
                                                                    .of(context)
                                                                .mode
                                                                .isDark
                                                            ? const Offset(0, 0)
                                                            : const Offset(
                                                                0, 1),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        leading: const Icon(Icons
                                                            .apartment_rounded),
                                                        title: Text(
                                                            trainingListInfo[
                                                                    index]
                                                                .trainingCenterName,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            )),
                                                        subtitle: Text(
                                                            trainingListInfo[
                                                                    index]
                                                                .trainingCenterAddress,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            )),
                                                       // minVerticalPadding: 0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 56,
                                                                bottom: 15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Status : ',
                                                              style: GoogleFonts
                                                                  .lato(),
                                                            ),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: trainingListInfo[index].trainingCenterStatus ==
                                                                              'PENDING'
                                                                          ? const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              234,
                                                                              143,
                                                                              39)
                                                                          : trainingListInfo[index].trainingCenterStatus ==
                                                                                  'SUBSCRIBED'
                                                                              ? Colors
                                                                                  .green
                                                                              : Colors
                                                                                  .red,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10,
                                                                        top: 3,
                                                                        bottom:
                                                                            3),
                                                                child: Text(
                                                                    trainingListInfo[
                                                                            index]
                                                                        .trainingCenterStatus,
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      textStyle: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              12.5,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
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
                                ),
                    ],
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
