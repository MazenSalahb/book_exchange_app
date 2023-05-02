import 'package:flutter/material.dart';
import 'package:mot_test/constant.dart';
import 'package:mot_test/pages/add_book.dart';
import 'package:mot_test/pages/edit_profile.dart';
import 'package:mot_test/pages/main_page.dart';
import 'package:mot_test/pages/register_page.dart';
import 'package:mot_test/pages/welcome_page.dart';
import 'package:mot_test/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const BookBarteing());
}

class BookBarteing extends StatelessWidget {
  const BookBarteing({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: kPrimaryColor),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: sharedPref.getString("id") == null ? "/" : "home",
      routes: {
        '/': (context) => const WelomePage(),
        'home': (context) => const MainPage(),
        'login': (context) => const LoginPage(),
        'register': (context) => const RegisterPage(),
        'editprofile': (context) => const EditProfile(),
        'addbook': (context) => const AddBook(),
      },
    );
  }
}