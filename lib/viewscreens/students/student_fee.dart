import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/AnimationWidget.dart';
import '../../gethelper/getHelper.dart';
import '../../widget-components/student/fee_widget.dart';


class StudentFee extends StatefulWidget{
  final String studentID;

  StudentFee({required this.studentID});

  @override
  _StudentFeeState createState() => _StudentFeeState();
}

// Handles the receipt data fetching
class _StudentFeeState extends State<StudentFee>{
  late Future<List> fee;
  double total = 0; // total amount

  // Fetch fee data
  Future<List> _fetchFeeData() async {
    try {
      var response = await GetHelper.fetchData(widget.studentID, 'get_student_feePayment', 'studentID');
      return response;
    } catch (e) {
      throw Exception('There is an error fetching fee data: $e');
    }
  }

  @override
  void initState() {
    // Get the future fee data
    fee = _fetchFeeData();
    super.initState();

    // Print the response from php website
    fee.then((response) {
      print("Raw Response: $response");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(116, 164, 199, 1),
        ),
        // Code adapted from Yassein, 2020
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40),
                  WidgetFadeAnimation(
                    1.4,
                    Row(
                      children: [
                        IconButton(
                          // Back arrow button
                          icon: Icon(Icons.arrow_back,
                              color: Colors.white,
                              size: 30
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 80),
                        Text(
                          "Receipt",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
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
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(90),
                          topRight: Radius.circular(90))
                  ),
                  padding: const EdgeInsets.all(18),

                  // Use list view to show data
                  // Code adapted from SilasPaes, 2019
                  child: FutureBuilder(
                    future: fee,
                    builder: (context, snapshots) {
                    // Loads the data
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      // End of adapted code
                    }
                    // Handles the null values there is no receipt data or is empty
                    if (!snapshots.hasData || snapshots.data == null || (snapshots.data as List).isEmpty) {
                      return Center(
                          child: Text('There is no fee payment that has been added currently',
                              style: GoogleFonts.poppins(
                                  fontSize: 30
                              ))
                      );
                    }

                    // Extract the class list from the data
                    // Adds the amount for fees
                    total = 0;
                    var feeList = snapshots.data as List;
                    feeList.forEach((fee) {
                      total += double.parse(fee['amount']);
                    });

                    // Prints the total
                    print(total);


                    return ListView.builder(
                      // Items in the list
                      itemCount: (snapshots.data as List).length,
                      itemBuilder: (context, index) {
                        // Use widget to display each receipt
                      return ReceiptWidget(
                        totalAmount: feeList[index]['amount'],
                        dateOfPayment: feeList[index]['date_of_payment'],
                      );
                      },
                    );
                    },
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Text(
                'If the displayed amount is incorrect, please contact the tuition center immediately.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
                  // Bottom bar to show total
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
                                borderRadius: BorderRadius.circular(18)
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
                              height: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                  '\$$total',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 36,
                                        color: Colors.green[700],
                                  )
                                ),
                                ],
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
                            fontSize: 18,
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
            // End of adapted code
          ],
        ),
      ),
    );
  }
}