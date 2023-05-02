import 'package:flutter/material.dart';
import 'package:mot_test/components/api_links.dart';
import 'package:mot_test/components/crud.dart';
import 'package:mot_test/main.dart';

import '../constant.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with Crud {
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String? validateEmail(String? value) {
    // Define a regex pattern for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null || value.isEmpty) {
      _isLoading = false;
      // Return an error message if the email field is empty
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      _isLoading = false;
      // Return an error message if the email field does not match the regex pattern
      return 'Please enter a valid email address';
    }

    // Return null if the email field is valid
    _isLoading = false;
    return null;
  }

  updateUser() async {
    if (formState.currentState!.validate()) {
      var response = await postRequest(
        editUserLink,
        {
          "username": username.text,
          "email": email.text,
          "password": password.text,
          "id": sharedPref.getString('id'),
        },
      );
      if (response['status'] == "success") {
        sharedPref.setString("username", username.text);
        sharedPref.setString("email", email.text);
        sharedPref.setString("password", password.text);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        _isLoading = false;
        print("Failed Edit");
      }
    }
  }

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username.text = sharedPref.getString('username')!;
    email.text = sharedPref.getString('email')!;
    password.text = sharedPref.getString('password')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "MOT",
            style: TextStyle(
                color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 35),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formState,
          child: ListView(
            children: [
              const SizedBox(height: 40),
              TextFormField(
                controller: username,
                validator: (value) {
                  if (value!.isEmpty) {
                    _isLoading = false;
                    return "Cannot Be Embty!!";
                  }
                  if (value.length < 3) {
                    _isLoading = false;
                    return "The username should be at least 3 characters long";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 25)),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: email,
                validator: validateEmail,
                decoration: InputDecoration(
                    hintText: "email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 25)),
              ),
              const SizedBox(height: 25),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    _isLoading = false;
                    return "Cannot Be Embty!!";
                  }
                  if (value.length < 6) {
                    _isLoading = false;
                    return "The password should be at least 6 characters long";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 25)),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await updateUser();
                      },
                style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: kPrimaryColor,
                    disabledForegroundColor: Colors.white,
                    backgroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Update Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
