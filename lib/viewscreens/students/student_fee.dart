import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/FadeAnimation.dart';
import '../../gethelper/getHelper.dart';
import '../../widget-components/student/fee_widget.dart';


class StudentFee extends StatefulWidget{
  final String studentID;

  StudentFee({required this.studentID});

  @override
  _StudentFeeState createState() => _StudentFeeState();
}

class _StudentFeeState extends State<StudentFee>{
  var fee;
  double total = 0;

  @override
  void initState() {
    fee = GetHelper.getData(widget.studentID, 'get_student_feePayment', 'studentID');
    total = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(116, 164, 199, 1),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40),
                  FadeAnimation(
                    1.3,
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back,
                              color: Colors.white,
                              size: 30
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 50),
                        Text(
                          "Fee Payment",
                          style: GoogleFonts.antic(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(100))
                  ),
                  padding: EdgeInsets.all(20),

                  child: FutureBuilder(future: fee, builder: (context, snapshots) {
                    // Loads the data
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // Display the message if there is no data
                    if (!snapshots.hasData || snapshots.data == null || (snapshots.data as List).isEmpty) {
                      return Center(
                          child: Text('There is no fee payment that has been added currently',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                              ))
                      );
                    }

                    // Use snapshots.data as list
                    // Adds the amount for fees
                    total = 0;
                    var feeList = snapshots.data as List;
                    feeList.forEach((fee) {
                      total += double.parse(fee['amount']);
                    });

                    // Prints the total
                    print(total);


                    return ListView.builder(
                      itemCount: (snapshots.data as List).length,
                      itemBuilder: (context, index) {

                      return FeeWidget(
                        amount: feeList[index]['amount'],
                        dateOfPayment: feeList[index]['date_of_payment'],
                      );
                    },
                    );
                  },
                  )
              ),
            ),
                  BottomAppBar(
                      shape: CircularNotchedRectangle(),
                      color: Colors.white,
                      elevation: 18,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                        Row(
                        children: [
                        Icon(
                          Icons.attach_money,
                          color: Colors.green,
                          size: 40,
                        ),
                          SizedBox(width: 5),

                          Text(
                          'Total Amount:',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        ],
                      ),

                        InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                                ),
                              title: Center(
                                  child:
                                  Text('Total Amount',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36,
                                    ),
                                  )
                              ),
                              content: Container(
                              height: 100,
                                child: Center(
                                  child: Text(
                                  '\$$total',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 36,
                                        color: Colors.green[700],
                                  )
                                )
                              ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Close',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromRGBO(116, 164, 199, 1),
                                  ),
                                ),
                            onPressed: () {
                                  Navigator.pop(context);
                                },
                            )
                              ]
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text('Show Total',
                          style: GoogleFonts.antic(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color.fromRGBO(116, 164, 199, 1),
                          ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 16,
                                color: Color.fromRGBO(116, 164, 199, 1)
                            ),
                          ],
                        )
                        ),
                    ],
                      )
    ),
                  ),
          ],
        ),
      ),
    );
  }
}