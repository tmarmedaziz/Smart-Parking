import 'package:flutter/material.dart';
import 'dart:math';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late String bookingNumber;

  @override
  void initState() {
    super.initState();
    bookingNumber = _generateBookingNumber();
  }

  String _generateBookingNumber() {
    var rng = new Random();
    return 'Booking Number: ${rng.nextInt(10000)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          Container(
            margin: EdgeInsets.only(top: 200),
            child: Text(
              'Here is your booking number',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.redAccent,
                      width: 4,
                    )),
                child: Text(
                  bookingNumber,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Image.asset(
              'images/booking-suc.png',
              width: 400,
              height: 400,
            ),
          ),
        ],
      ),
    );
  }
}