import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceiptWidget extends StatelessWidget {
  final String totalAmount;
  final String dateOfPayment;

  ReceiptWidget({this.totalAmount="", this.dateOfPayment=""});

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
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 2),
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

              title: Text(totalAmount,
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
                  dateOfPayment,
                    style: GoogleFonts.lato(
                   textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                  const SizedBox(height: 4),
                ],
              ),
          ),
        ),
      ],
    );
  }
}