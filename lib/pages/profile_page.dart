import 'package:flutter/material.dart';
import 'package:mot_test/constant.dart';

import '../main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 350,
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  'images/profilepic.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                sharedPref.getString('username').toString(),
                style: const TextStyle(color: Colors.white, fontSize: 25),
              )
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('editprofile');
                  },
                  title: const Text("Setting"),
                  leading: const Icon(
                    Icons.settings,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: const Color(0xffE2E2E2).withOpacity(0.8),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text("Help Center"),
                  leading: const Icon(Icons.help_outline),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: const Color(0xffE2E2E2).withOpacity(0.8),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text("About"),
                  leading: const Icon(Icons.error_outline),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: const Color(0xffE2E2E2).withOpacity(0.8),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text("Logout"),
                  leading: const Icon(Icons.exit_to_app_outlined),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: const Color(0xffE2E2E2).withOpacity(0.8),
                  ),
                  onTap: () {
                    sharedPref.clear();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("login", (route) => false);
                  },
                ),
                const Divider(),
              ],
            ))
      ],
    );
  }
}
