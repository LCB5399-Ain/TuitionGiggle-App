import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tuitiongiggle/animation/FadeAnimation.dart';
import 'package:tuitiongiggle/viewscreens/students/main_student_page.dart';
import 'package:tuitiongiggle/viewscreens/teachers/main_teacher_page.dart';
import '../provider/student.dart';
import '../provider/teacher.dart';


class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

// State class for login
// Code adapted from Arora, 2024
class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  // End of adapted code

  // Button for choosing student role
  int selectedRadio = 1;

  // Updates the selected radio button state
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  // Alert the users if they enter the wrong credentials
  showAlert(String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  // Navigate to login page
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Login())
                  );
                },
              )
            ],
          );
        }
    );
  }

  // Show loading progress when logging in
  showLoadingProgress() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                alignment: Alignment.center,
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
  _login() async {
    if (_formKey.currentState!.validate()) {
      showLoadingProgress();

      // Student radio button
      if (selectedRadio == 1) {
        Provider.of<Student>(context, listen: false).loginStudentAndGetInfo(
            username.text, password.text).then((state) {
          print('Login state: $state');
          if (state) {
            // Navigate users to the main student page
            Navigator.of(context).pushReplacementNamed(MainStudentPage.routeName);
          } else {
            showAlert('Oh no!',
                'The username or password you entered is incorrect. Please try again.');
          }
        });

        // Teacher radio button
      } else if (selectedRadio == 2) {
        Provider.of<Teacher>(context, listen: false).teacherLoginAndGetInfo(
            username.text, password.text).then((state) {
          if (state) {
            // Navigate users to the main teacher page
            Navigator.of(context).pushReplacementNamed(MainTeacherPage.routeName);
          } else {
            showAlert('Oh no!',
                'The username or password you entered is incorrect. Please try again.');
          }
        });
      }
    }
  }

  // Code adapted from Yassein, 2020
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: FadeAnimation(
                            1,
                            Text(
                              "Login",
                              style: GoogleFonts.antic(
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
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)
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
                            FadeAnimation(
                                1.4,
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
                                    key: _formKey,
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
                                            controller: username,
                                            decoration: InputDecoration(
                                                hintText: "Username",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none
                                            ),
                                            keyboardType: TextInputType.text,
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
                                            controller: password,
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
                                              groupValue: selectedRadio,
                                              value: 1,
                                              onChanged: (val) {
                                                print(val);
                                                setSelectedRadio(val!);
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
                                              groupValue: selectedRadio,
                                              value: 2,
                                              onChanged: (val) {
                                                print(val);
                                                setSelectedRadio(val!);
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
                            FadeAnimation(
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
                                          _login();
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