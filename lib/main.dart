import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tuitiongiggle/provider/student.dart';
import 'package:tuitiongiggle/provider/teacher.dart';
import 'package:tuitiongiggle/viewscreens/login.dart';
import 'package:tuitiongiggle/viewscreens/students/main_student_page.dart';
import 'package:tuitiongiggle/viewscreens/teachers/main_teacher_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Code adapted from Yassein, 2020
    return MultiProvider(
      // Provides the instances of the Student and Teacher providers
      providers: [
        ChangeNotifierProvider(
          create: (_) => Student(),
        ),

        ChangeNotifierProvider(
          create: (_) => Teacher(),
        ),
      ],
      // End of adapted code
      child: MaterialApp(
        title: 'Tuition Giggle',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          hintColor: Colors.transparent,
        ),

        home: LoginScreen(),
        routes: {
          // Direct users to the pages
          MainStudentPage.routeName: (context) => MainStudentPage(),
          MainTeacherPage.routeName: (context) => MainTeacherPage(),
        },
      ),
    );
  }
}