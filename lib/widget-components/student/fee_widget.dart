import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeeWidget extends StatelessWidget {
  final String amount;
  final String dateOfPayment;

  FeeWidget({this.amount="", this.dateOfPayment=""});

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
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/fee_icon.png',
                  fit: BoxFit.contain,
                  width: 60,
                  height: 45,
                  ),
                ),

              title: Text(amount,
                style: GoogleFonts.antic(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  dateOfPayment,
                   style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                SizedBox(height: 4),
                ],
              ),
          ),
        ),
      ],
    );
  }
}