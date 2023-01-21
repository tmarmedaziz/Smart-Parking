import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:modern_parker/app/pages/dashboard_parking_reservations.dart';
import 'package:modern_parker/app/pages/dashbord_parking_slots.dart';
import 'package:modern_parker/app/pages/signin.dart';
import 'package:modern_parker/app/pages/signup.dart';
import 'app/pages/Booking_history.dart';
import 'app/pages/Bookingnumber.dart';
import 'app/pages/addvehicule.dart';
import 'app/pages/reservationslot.dart';



ThemeData lightTheme = ThemeData.light();
ThemeData darkTheme = ThemeData.dark();
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isDark = false;

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: _isDark ? darkTheme : lightTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '': (ctx) => Login(),
          'Sign': (ctx) => Singin(),
          'dashboard': (ctx) => Dashbord(),
          'Addvehicule': (ctx) => Addvehicule(),
          'ReserveSlot': (ctx) => ReserveSlot(),
          'BookingPage': (ctx) => BookingPage(),
          'BookinghistoryPage': (ctx) => BookinghistoryPage(),
          'dashboard2': (ctx) => Dashbord2(),
        },
        home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('Welcome Back!'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(_isDark ? Icons.wb_sunny : Icons.brightness_3),
                  onPressed: _toggleTheme,
                ),
              ],
            ),
            body: const Login(),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(Home());
}