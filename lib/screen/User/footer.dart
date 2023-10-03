import 'package:cardmonix/dto/response/UserDetails.dart';
import 'package:cardmonix/screen/User/profile/profile.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  UserData userData;
  Footer({required this.userData});

  @override
  FooterState createState() => FooterState();
}

class FooterState extends State<Footer> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 2) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Profile(userData: widget.userData)));
      } else if (index == 0) {
        Navigator.pushNamed(context, '/dashboard');
      }
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
