// ignore_for_file: file_names

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_client_side/features/coachingManager/bloc/coaching_manager_bloc.dart';
import 'package:staff_client_side/routes/routes.dart';

class CreateClassShedulePage extends StatefulWidget {
  const CreateClassShedulePage({super.key});

  @override
  State<CreateClassShedulePage> createState() => _CreateClassShedulePageState();
}

class _CreateClassShedulePageState extends State<CreateClassShedulePage> {

  @override
  void initState() {
    super.initState();
    coachingManagerBloc.add(CreateClassSheduleEvent());
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
        }
      },
      builder: (context, state) {
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
            title: Text("Create Class Shedule",
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
        );
      },
    );
  }
}
