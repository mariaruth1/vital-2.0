import 'package:flutter/material.dart';
import 'package:vital/vital_calendar.dart';

void main() {
  runApp(const Vital());
}

class Vital extends StatelessWidget {
  const Vital({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vital',
        home: MainPage(),
      );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  // To keep track of the selected index
  final PageController _pageController = PageController();

  // List of screens to navigate between
  final List<Widget> _screens = [
    VitalCalendar(),
    Center(child: Text("Cycle")),
    Center(child: Text("Analytics")),
  ];

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: const Icon(Icons.star),
        title: const Text(
          "V I T A L",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        foregroundColor: Colors.grey[900],
        backgroundColor: Colors.indigo[200],
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;  // Update the selected index when swiping
          });
        },
        children: _screens,  // Display the list of screens
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo[50],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey[900],
        unselectedItemColor: Colors.grey[500],
        onTap: _onNavBarTapped,  // Handle tap on nav bar items
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.trip_origin), label: 'Cycle'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Analytics'),
        ],
      ),
    );
  }
}
