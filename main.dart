import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'home_page.dart';
import 'workout_plan_page.dart';
import 'diet_plan_page.dart';
import 'profile_page.dart';
import 'bmi_calculation_page.dart'; // Import the BMI calculation page

void main() {
  runApp(WorkoutPlanApp());
}

class WorkoutPlanApp extends StatelessWidget {
  const WorkoutPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 222, 36, 12), // Teal
        scaffoldBackgroundColor: const Color(0xFFF0F0F0), // Light Gray
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 222, 36, 12), // Teal
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color.fromARGB(255, 222, 36, 12), // Dark Blue
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(color: Color(0xFF333333), fontFamily: 'Montserrat'), // Dark Gray
          bodySmall: TextStyle(color: Color(0xFF666666), fontFamily: 'Montserrat'), // Medium Gray
        ),
      ),
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WorkoutPlanHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo1.png',
              height: 150,
            ),
            const SizedBox(height: 30),
            const SpinKitFadingCircle(
              color: Color.fromARGB(255, 222, 36, 12), // Teal
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutPlanHomePage extends StatefulWidget {
  const WorkoutPlanHomePage({super.key});

  @override
  _WorkoutPlanHomePageState createState() => _WorkoutPlanHomePageState();
}

class _WorkoutPlanHomePageState extends State<WorkoutPlanHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomePage(),
    WorkoutPlanPage(),
    DietPlanPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xFFF0F0F0), // Light Gray
        color: const Color.fromARGB(255, 222, 36, 12), // Teal
        buttonBackgroundColor: const Color.fromARGB(255, 222, 36, 12), // Teal
        height: 60,
        index: _currentIndex,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Color.fromARGB(255, 255, 255, 255)), // Dark Gray
          Icon(Icons.fitness_center, size: 30, color: Color.fromARGB(255, 255, 255, 255)), // Dark Gray
          Icon(Icons.restaurant_menu, size: 30, color: Color.fromARGB(255, 255, 255, 255)), // Dark Gray
          Icon(Icons.person, size: 30, color: Color.fromARGB(255, 255, 255, 255)), // Dark Gray
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  BMICalculationPage()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 222, 36, 12), // Teal
        child: const Icon(Icons.calculate, color: Color(0xFFF0F0F0)), // Light Gray
      ),
     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
