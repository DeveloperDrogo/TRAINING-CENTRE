// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage(
                  //         'assets/images/nonoti.jpg'))
                  ),
              child: Lottie.asset('assets/lottie/empty.json'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(description,
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
    );
  }
}
