// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class BatchListPage extends StatelessWidget {
  const BatchListPage(
      {super.key,
      required this.batch,
      required this.onBatchDelete,
      required this.batchId});

  final String batch;
  final String batchId;
  final ValueChanged onBatchDelete;

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
            leading: const Icon(IconlyBroken.time_circle),
            trailing: GestureDetector(
              onTap: () => onBatchDelete(batchId),
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
              batch,
              style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
