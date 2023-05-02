import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mot_test/pages/home_page.dart';
import 'package:mot_test/pages/profile_page.dart';
import 'package:mot_test/pages/user_books.dart';

import '../constant.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;

  List pages = [const HomePage(), const MyBooks(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: currentPage != 2
          ? AppBar(
              toolbarHeight: 50,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "MOT",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.black, size: 35),
            )
          : null,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: GNav(
            onTabChange: (value) {
              setState(() {
                currentPage = value;
              });
            },
            gap: 8,
            activeColor: kPrimaryColor,
            color: const Color(0xffB8AFBD),
            tabBackgroundColor: kPrimaryColor.withOpacity(0.2),
            padding: const EdgeInsets.all(10),
            tabs: const [
              GButton(icon: CupertinoIcons.house, text: "Home"),
              GButton(icon: CupertinoIcons.book, text: "books"),
              GButton(icon: CupertinoIcons.person, text: "Account"),
            ]),
      ),
      body: pages[currentPage],
    );
  }
}
