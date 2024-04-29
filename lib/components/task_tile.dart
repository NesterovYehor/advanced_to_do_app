import 'package:advanced_to_do_app/models/tesk_model.dart';
import 'package:advanced_to_do_app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final Task? task;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height * 0.13,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _getBGClr(task?.color ?? 0)
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title.toString() ?? "", 
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white
                    )
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, color: Colors.grey[200], size: 18,),
                    Text("${task?.startTime}-${task?.endTime}", style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 15, color: Colors.grey[200])),)
                  ],
                ),
                Text(task?.note ?? "", style: GoogleFonts.lato( textStyle: TextStyle(fontSize: 15, color: Colors.grey[100])),)
              ],
            ),
            const Spacer(),
            Container(
              width: 2,
              height: 60,
              color: Colors.grey[200]?.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task?.isCompleted == 1 ? "COMPLETED" : "TODO",
                style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getBGClr(int colorIndex){ 
    switch (colorIndex){
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowlr;
      default:
        return bluishClr;
    }

  }
}