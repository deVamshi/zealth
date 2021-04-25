import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:zealth/utils/constants.dart';
import 'package:zealth/utils/helpers.dart';
import 'package:zealth/views/home/home_screen.dart';
import 'package:zealth/views/medication/medication_screen.dart';
import 'package:zealth/views/reports/reports_screen.dart';
import 'package:zealth/views/symptoms/symptoms_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zealth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Poppins"),
      home: SkeletonScreen(),
    );
  }
}

class SkeletonScreen extends StatefulWidget {
  @override
  _SkeletonScreenState createState() => _SkeletonScreenState();
}

class _SkeletonScreenState extends State<SkeletonScreen> {
  final List<String> screenTitles = [
    "Home",
    "Symptoms",
    "Medication",
    "Reports"
  ];
  int currentIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    SymptomsScreen(),
    MedicationScreen(),
    ReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.GREYBG,
        drawer: Drawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.PRIMARYTITLE),
          elevation: 0.0,
          backgroundColor: AppColors.GREYBG,
          centerTitle: true,
          title: Text(
            screenTitles[currentIndex],
            style: AppTexts.h4,
          ),
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.PINK,
          unselectedItemColor: AppColors.PRIMARYBODY,
          showUnselectedLabels: true,
          elevation: 1,
          items: [
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(LineAwesomeIcons.thermometer), label: "Symptoms"),
            BottomNavigationBarItem(
                icon: Icon(LineAwesomeIcons.medkit), label: "Medication"),
            BottomNavigationBarItem(
                icon: Icon(LineAwesomeIcons.medical_notes), label: "Reports"),
          ],
        ),
      ),
    );
  }
}
