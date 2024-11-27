import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tuitiongiggle/animation/AnimationWidget.dart';
import 'package:tuitiongiggle/viewscreens/students/main_student_page.dart';
import 'package:tuitiongiggle/viewscreens/teachers/main_teacher_page.dart';
import '../provider/student.dart';
import '../provider/teacher.dart';


class LoginScreen extends StatefulWidget{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// State class for login
// Code adapted from Arora, 2024
class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  // End of adapted code

  // Button for choosing student role
  int roleSelectRadio = 1;

  // Updates the selected radio button state
  void selectRoleRadio(int value) {
    setState(() {
      roleSelectRadio = value;
    });
  }
  // Code adapted from Yassein, 2020
  // Alert the users if they enter the wrong credentials
  void _displayAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  // Navigate to login page
                  Navigator.of(ctx).pushReplacement(
                      MaterialPageRoute(builder: (_) => LoginScreen())
                  );
                },
              )
            ],
          );
        }
    );
  }

  // Show loading progress when logging in
  void _showLoadingIndicator() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SizedBox(
                height: 90,
                width: 90,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                  ),
                )
            ),
          );
        });
  }



  // Handles the login process
  Future<void> _performLogin() async {
    if (_loginFormKey.currentState!.validate()) {
      _showLoadingIndicator();

      // Student radio button
      if (roleSelectRadio == 1) {
        await Provider.of<Student>(context, listen: false).loginStudentAndGetInfo(
            usernameController.text, passwordController.text).then((success) {
          print('Login state: $success');
          if (success) {
            // Navigate users to the main student page
            Navigator.of(context).pushReplacementNamed(MainStudentPage.routeName);
          } else {
            _displayAlert('Oh no!',
                'The username or password you entered is incorrect. Please try again.');
          }
        });

        // Teacher radio button
      } else if (roleSelectRadio == 2) {
        await Provider.of<Teacher>(context, listen: false).teacherLoginAndGetInfo(
            usernameController.text,
            passwordController.text).then((success) {
          if (success) {
            // Navigate users to the main teacher page
            Navigator.of(context).pushReplacementNamed(MainTeacherPage.routeName);
          } else {
            _displayAlert('Oh no!',
                'The username or password you entered is incorrect. Please try again.');
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Color.fromRGBO(247, 206, 61, 1),
                Color.fromRGBO(173, 187, 238, 1),
              ]
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: WidgetFadeAnimation(
                            1,
                            Text(
                              "Login",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                                fontSize: 50,
                              ),
                            )
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/star.png',
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(65),
                          topRight: Radius.circular(65)
                      )
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(30),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 60,
                            ),
                            WidgetFadeAnimation(
                                1.6,
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(116, 164, 199, 1),
                                            blurRadius: 20,
                                            offset: Offset(0, 8)
                                        )
                                      ]
                                  ),
                                  child: Form(
                                    key: _loginFormKey,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey.shade200
                                                  )
                                              )
                                          ),
                                          child: TextFormField(
                                            controller: usernameController,
                                            decoration: InputDecoration(
                                                hintText: "Username",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none
                                            ),
                                            keyboardType: TextInputType.text,
                                            obscureText: false,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your username';

                                              } else if (value.length < 7) {
                                                return 'Username must be at least 5 characters';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),

                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey.shade200
                                                  )
                                              )
                                          ),
                                          child: TextFormField(
                                            controller: passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none
                                            ),
                                            keyboardType: TextInputType.visiblePassword,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your password';
                                              } else if (value.length < 8) {
                                                return 'Password must be at least 8 characters';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Radio(
                                              activeColor: Colors.amber[300],
                                              groupValue: roleSelectRadio,
                                              value: 1,
                                              onChanged: (value) {
                                                print(value);
                                                selectRoleRadio(value!);
                                              },
                                            ),
                                            Text('Student',
                                                style: GoogleFonts.asar(
                                                  textStyle: TextStyle(
                                                      color: Color.fromRGBO(116, 164, 199, 1),
                                                      fontWeight: FontWeight
                                                          .bold
                                                  ),
                                                  fontSize: 20,
                                                )
                                            ),

                                            Radio(
                                              activeColor: Colors.amber[300],
                                              groupValue: roleSelectRadio,
                                              value: 2,
                                              onChanged: (value) {
                                                print(value);
                                                selectRoleRadio(value!);
                                              },
                                            ),
                                            Text('Teacher',
                                                style: GoogleFonts.asar(
                                                  textStyle: TextStyle(
                                                      color: Color.fromRGBO(116, 164, 199, 1),
                                                      fontWeight: FontWeight
                                                          .bold
                                                  ),
                                                  fontSize: 20,
                                                )
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ),

                            SizedBox(
                              height: 40,
                            ),
                            WidgetFadeAnimation(
                                1.6,
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color.fromRGBO(116, 164, 199, 1)
                                  ),
                                  child: Center(
                                    child: TextButton(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        onPressed: () {
                                          _performLogin();
                                        }
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(
                              height: 30,
                              // End of adapted code
                            ),
                          ],
                        ),
                      ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}