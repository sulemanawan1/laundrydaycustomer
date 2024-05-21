import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/more/more.dart';
import 'package:laundryday/screens/offers/view/offers.dart';
import 'package:laundryday/screens/orders/orders.dart';
import 'package:laundryday/screens/services/view/services.dart';
import 'package:laundryday/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  int _selectedIndex = 0;

  List<Widget> screens = [
    const Services(),
    const Orders(),
    const Offers(),
    const More()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorManager. whiteColor,
        bottomNavigationBar: Card(elevation: 0,
           color: ColorManager.whiteColor,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_offer),
                label: 'Offers',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz_sharp),
                label: 'More',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorManager. primaryColor,
            backgroundColor: ColorManager.whiteColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedLabelStyle:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
            unselectedLabelStyle:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: const [Services(), Orders(), Offers(), More()],
        ));
  }
}
