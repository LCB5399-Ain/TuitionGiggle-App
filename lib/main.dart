import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuitiongiggle/provider/student.dart';
import 'package:tuitiongiggle/provider/teacher.dart';
import 'package:tuitiongiggle/viewscreens/login.dart';
import 'package:tuitiongiggle/viewscreens/students/main_student_page.dart';
import 'package:tuitiongiggle/viewscreens/teachers/main_teacher_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase and handle any exceptions
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyApyDiPD7M4-Ex6BPqHVOwWo_5jaM2oa5k",
        authDomain: "tuitiongiggle.firebaseapp.com",
        projectId: "tuitiongiggle",
        storageBucket: "tuitiongiggle.appspot.com",
        messagingSenderId: "767709044697",
        appId: "1:767709044697:web:ad4307f84bf4599ad203c8",
      ),
    );
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Student(),
        ),

        ChangeNotifierProvider(
          create: (context) => Teacher(),
        ),
      ],
      child: MaterialApp(
        title: 'Tuition Giggle',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          hintColor: Colors.transparent,
        ),

        home: Login(),
        routes: {
          MainStudentPage.routeName: (ctx) => MainStudentPage(),
          MainTeacherPage.routeName: (ctx) => MainTeacherPage(),
        },
      ),
    );
  }
}