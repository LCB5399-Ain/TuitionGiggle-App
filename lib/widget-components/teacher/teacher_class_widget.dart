import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Class information and task in widgets
class TeacherClassWidget extends StatelessWidget {
  final String classroom;
  final String subject;
  final String classTime;
  final VoidCallback voidFunction;

  TeacherClassWidget({this.classroom="", this.subject="", this.classTime="", required this.voidFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('assets/class_icon.png',
                fit: BoxFit.contain,
                width: 60,
                height: 45,
            ),
          ),

            title: Text(classroom,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            subtitle:
                Text(
                  classTime,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
            // Trailing section
            trailing: TextButton(
              child: Text('Add Task',
                style: TextStyle(
                    color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Color.fromRGBO(116, 164, 199, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
              ),
              onPressed: voidFunction,
            ),
            onTap: voidFunction,
          ),
        ),
      ],
    );
  }
}