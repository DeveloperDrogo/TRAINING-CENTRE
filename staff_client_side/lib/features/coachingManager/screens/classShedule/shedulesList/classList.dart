// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

typedef BatchDeleteCallback = void Function(String classId, String classRoom);

class ClassRoomListPage extends StatelessWidget {
  const ClassRoomListPage(
      {super.key,
      required this.classRoom,
      required this.onClassDelete,
      required this.classId});

  final String classRoom;
  final String classId;
  final BatchDeleteCallback onClassDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 0.5)),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: ListTile(
            leading: const Icon(IconlyBroken.tick_square),
            trailing: GestureDetector(
              onTap: () => onClassDelete(classId,classRoom),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color.fromARGB(255, 243, 77, 65),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const Stack(
                    children: [
                      Positioned(
                          right: -15,
                          top: -15,
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 199, 37, 26),
                          )),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          IconlyBroken.delete,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: Text(
              classRoom.toUpperCase(),
              style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 14.5),
            ),
          ),
        ),
      ),
    );
  }
}
