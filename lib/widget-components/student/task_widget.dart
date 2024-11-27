import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/AnimationWidget.dart';

class TaskWidget extends StatelessWidget {
  final String subjectOfTask;
  final String task;
  final String taskDate;

  TaskWidget({this.subjectOfTask="", this.task="", this.taskDate=""});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white, // Box background color
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
            leading: Container(
              width: 60,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
            ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/task_icon.png',
                fit: BoxFit.contain,
                ),
              ),
            ),

            title: Text(subjectOfTask,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                taskDate,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
                const SizedBox(height: 4),
            ],
          ),
            // Code adapted from Yassein, 2020
          onTap:() {
            showDialog(
                context: context,
                builder: (_) {
                  return WidgetFadeAnimation(1.3,
                    AlertDialog(
                      title: Text(subjectOfTask, textAlign: TextAlign.center),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      content: Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Divider(thickness: 1.3),
                              const SizedBox(height: 8.0),
                              // End of adapted code

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.task, color: Color.fromRGBO(116, 164, 199, 1)), // Feedback icon
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child:
                                    Text(
                                      'Task: $task',
                                      style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20
                                          ),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              const SizedBox(height: 20),

                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.access_time, color: Color.fromRGBO(116, 164, 199, 1)),
                                    SizedBox(width: 6),
                                    Text(
                                      taskDate,
                                      style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(thickness: 1.3),
                              const SizedBox(height: 10),

                          ],
                          ),
                        ),
                      ),
                          actions: [
                          TextButton(
                            child:
                            Text(
                            'Close',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromRGBO(116, 164, 199, 1),
                              ),
                            ),

                            onPressed: () {
                            Navigator.pop(context);
                            },
                          ),
                        ],
                    ),
                  );
                }
            );
          },
        ),
        ),
      ],
    );
  }
}