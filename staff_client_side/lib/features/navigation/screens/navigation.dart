import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:staff_client_side/constant/sharedprefs.dart';
import 'package:staff_client_side/features/auth/login/screens/login.dart';
import 'package:staff_client_side/features/navigation/bloc/navigation_bloc.dart';
import 'package:staff_client_side/features/profile/screens/profile.dart';
import 'package:staff_client_side/main.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:staff_client_side/routes/routes.dart';
import 'package:staff_client_side/server/server.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  void initState() {
    navigationBloc.add(ListMenu());
    getVersionNumber();

    super.initState();
  }

  String version = '';

  void getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });

    // print('App version: $version');
  }

  final NavigationBloc navigationBloc = NavigationBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      bloc: navigationBloc,
      listenWhen: (previous, current) => current is NavigationActionState,
      buildWhen: (previous, current) => current is! NavigationActionState,
      listener: (context, state) {
        if (state is BackToBottomPageState) {
          Navigator.pushReplacementNamed(context, MyRoutes.bottom);
        } else if (state is NavigateToProfilePageState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ));
        } else if (state is NavigateToLoginPageState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Are you sure want to logout?',
            titleTextStyle: const TextStyle(fontSize: 16, height: 3),
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              navigationBloc.add(BackToLoginPage());
            },
          ).show();
        } else if (state is NavigateToLoginPage) {
          AdaptiveTheme.of(context).setLight();
          SharedPrefs().clear();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const LoginPage(
                        number: '',
                      )),
              (Route<dynamic> route) => true);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case NavigationLoadState:
            return Scaffold(
              backgroundColor: AdaptiveTheme.of(context).mode.isDark
                  ? const Color.fromARGB(255, 56, 56, 56)
                  : Colors.white,
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  'version $version',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: AdaptiveTheme.of(context).mode.isDark
                      ? const Color.fromARGB(255, 56, 56, 56)
                      : Colors.white,
                  title: Text(
                    "Account",
                    style: TextStyle(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white
                            : const Color.fromARGB(255, 68, 68, 68),
                        fontSize: 22,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
                  leading: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: IconButton(
                        onPressed: () {
                          navigationBloc.add(BackToBottomPageEvent());
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: AdaptiveTheme.of(context).mode.isDark
                              ? Colors.white
                              : const Color.fromARGB(255, 68, 68, 68),
                        )),
                  )),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ListMenuState:
            final successState = state as ListMenuState;
            return Scaffold(
              backgroundColor: AdaptiveTheme.of(context).mode.isDark
                  ? const Color.fromARGB(255, 56, 56, 56)
                  : Colors.white,
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  'version $version',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: AdaptiveTheme.of(context).mode.isDark
                      ? const Color.fromARGB(255, 56, 56, 56)
                      : Colors.white,
                  title: Text(
                    "Account",
                    style: TextStyle(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white
                            : const Color.fromARGB(255, 68, 68, 68),
                        fontSize: 22,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
                  leading: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: IconButton(
                        onPressed: () {
                          navigationBloc.add(BackToBottomPageEvent());
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: AdaptiveTheme.of(context).mode.isDark
                              ? Colors.white
                              : const Color.fromARGB(255, 68, 68, 68),
                        )),
                  )),
              body: WillPopScope(
                onWillPop: () async {
                  navigationBloc.add(BackToBottomPageEvent());
                  return false;
                },
                child: SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GestureDetector(
                            onTap: () {
                              navigationBloc.add(NavigateToProfilePageEvent());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                //color: const Color(0xff495F81),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    MyColors.primaryColor,
                                    MyColors.secondaryColor
                                  ],
                                ),
                              ),
                              child: Stack(children: [
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
                                            color: MyColors.lightblue))),
                                Positioned(
                                    left: -80,
                                    top: -70,
                                    child: Container(
                                        height: 150,
                                        width: 180,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColors.lightblue))),
                                Positioned(
                                    right: 20,
                                    bottom: 10,

                                    //positioned helps to position widget wherever we want.

                                    child: CircleAvatar(
                                      backgroundColor: const Color.fromARGB(
                                          255, 236, 239, 244),
                                      radius: 19,
                                      child: Icon(
                                          Icons.arrow_circle_right_rounded,
                                          size: 38,
                                          color: MyColors.primaryColor),
                                    )),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 20, bottom: 20),
                                      child: Container(
                                          width: 78,
                                          height: 78,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: const Color.fromARGB(
                                                      255, 234, 242, 255),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: const Color
                                                                .fromARGB(
                                                                255, 61, 61, 61)
                                                            .withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 1)),
                                                  ],
                                                ),
                                                child: Icon(
                                                  IconlyBold.profile,
                                                  color: MyColors.primaryColor,
                                                  size: 60,
                                                ),
                                              ),
                                            ),
                                          )),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                SharedPrefs()
                                                    .name
                                                    .capitalizeFirstLetter(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontFamily: "Lato",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(SharedPrefs().mobile,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontFamily: "Lato",
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 201, 201, 201)
                                          .withOpacity(0.5),
                                  spreadRadius:
                                      AdaptiveTheme.of(context).mode.isDark
                                          ? 0
                                          : 2,
                                  blurRadius:
                                      AdaptiveTheme.of(context).mode.isDark
                                          ? 0
                                          : 5,
                                  offset: AdaptiveTheme.of(context).mode.isDark
                                      ? const Offset(0, 0)
                                      : const Offset(0, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? const Color.fromARGB(255, 78, 78, 78)
                                  : const Color.fromARGB(255, 255, 255, 255),
                              border:
                                  Border.all(color: Colors.grey, width: 0.4)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: successState.menuList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          top: 15,
                                          right: 10,
                                          bottom: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context,
                                              successState
                                                  .menuList[index].route);
                                        },
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    AdaptiveTheme.of(context)
                                                            .mode
                                                            .isDark
                                                        ? const Color.fromARGB(
                                                            255, 52, 52, 52)
                                                        : const Color.fromARGB(
                                                            255, 237, 243, 248),
                                                child: CachedNetworkImage(
                                                  filterQuality:
                                                      FilterQuality.low,
                                                  imageUrl: Server.img +
                                                      successState
                                                          .menuList[index]
                                                          .iconPath,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                (successState
                                                        .menuList[index].title
                                                        .toLowerCase())
                                                    .capitalizeFirstLetter(),
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      color: AdaptiveTheme.of(
                                                                  context)
                                                              .mode
                                                              .isDark
                                                          ? const Color
                                                              .fromARGB(255,
                                                              220, 220, 220)
                                                          : Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                            const Spacer(),
                                            Icon(
                                              Icons.chevron_right_sharp,
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? const Color.fromARGB(
                                                      255, 220, 220, 220)
                                                  : Colors.black,
                                              // color: AdaptiveTheme.of(context).mode.isDark?const Color.fromARGB(255, 220, 220, 220):Colors.grey,
                                              size: 30,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    navigationBloc.add(NavigateToLogoutEvent());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                AdaptiveTheme.of(context)
                                                        .mode
                                                        .isDark
                                                    ? const Color.fromARGB(
                                                        255, 52, 52, 52)
                                                    : const Color.fromARGB(
                                                        255, 237, 243, 248),
                                            child: Image.asset(
                                                'assets/images/logout.png')),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? const Color.fromARGB(
                                                      255, 220, 220, 220)
                                                  : Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.chevron_right_sharp,
                                          color: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? const Color.fromARGB(
                                                  255, 220, 220, 220)
                                              : Colors.black,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: const Color.fromARGB(
                                      //             255, 201, 201, 201)
                                      //         .withOpacity(0.4),
                                      //     spreadRadius: AdaptiveTheme.of(context)
                                      //             .mode
                                      //             .isDark
                                      //         ? 0
                                      //         : 2,
                                      //     blurRadius: AdaptiveTheme.of(context)
                                      //             .mode
                                      //             .isDark
                                      //         ? 0
                                      //         : 2,
                                      //     offset: AdaptiveTheme.of(context)
                                      //             .mode
                                      //             .isDark
                                      //         ? const Offset(0, 0)
                                      //         : const Offset(0, 1),
                                      //   ),
                                      // ],
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? const Color.fromARGB(
                                                  255, 78, 78, 78)
                                              : const Color.fromARGB(
                                                  255, 255, 255, 255),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            // const SizedBox(
                                            //   width: 8,
                                            // ),
                                            CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    AdaptiveTheme.of(context)
                                                            .mode
                                                            .isDark
                                                        ? const Color.fromARGB(
                                                            255, 52, 52, 52)
                                                        : const Color.fromARGB(
                                                            255, 237, 243, 248),
                                                child: AdaptiveTheme.of(context)
                                                        .mode
                                                        .isDark
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Image.asset(
                                                            'assets/images/brightness.png'),
                                                      )
                                                    : Image.asset(
                                                        'assets/images/night-mode.png')),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? "Enable light mode"
                                                  : "Enable dark mode",
                                              style: TextStyle(
                                                  color: AdaptiveTheme.of(
                                                              context)
                                                          .mode
                                                          .isDark
                                                      ? const Color.fromARGB(
                                                          255, 220, 220, 220)
                                                      : Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              height: 20,
                                              child: Switch(
                                                value: AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark,
                                                onChanged: (value) {
                                                  if (value) {
                                                    AdaptiveTheme.of(context)
                                                        .setDark();
                                                  } else {
                                                    AdaptiveTheme.of(context)
                                                        .setLight();
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                )),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
