import 'package:flutter/material.dart';

import '../constant.dart';

class WelomePage extends StatelessWidget {
  const WelomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            height: 550,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                "images/bg.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(),
          const Text(
            "you can swap your\n old books for new reads",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, height: 1.4),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "register");
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 140),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text(
              "Register",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
