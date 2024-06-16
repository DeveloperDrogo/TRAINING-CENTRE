import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTutionCenterPage extends StatefulWidget {
  const AddTutionCenterPage({super.key});

  @override
  State<AddTutionCenterPage> createState() => _AddTutionCenterPageState();
}

class _AddTutionCenterPageState extends State<AddTutionCenterPage> {
  final _formKey = GlobalKey<FormState>();
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
        title: Text("Add Tution Center",
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
      body: WillPopScope(
        onWillPop: () async {
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
                                  fit: BoxFit.cover,
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
                  ],
                ),
              )
            ]))
          ],
        ),
      ),
    );
  }
}
