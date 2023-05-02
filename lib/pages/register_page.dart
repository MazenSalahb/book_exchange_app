import 'package:flutter/material.dart';
import 'package:mot_test/components/api_links.dart';
import 'package:mot_test/components/crud.dart';
import 'package:mot_test/constant.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with Crud {
  GlobalKey<FormState> formState = GlobalKey();
  bool hidePassword = true;
  bool _isLoading = false;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Icon passshowEye = const Icon(
    Icons.visibility_outlined,
    size: 25,
    color: kPrimaryColor,
  );
  Icon passHideEye = const Icon(
    Icons.visibility_off_outlined,
    size: 25,
    color: kPrimaryColor,
  );
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

  register() async {
    if (formState.currentState!.validate()) {
      var response = await postRequest(registerLink, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("login", (route) => false);
      } else {
        setState(() {
          _isLoading = false;
        });
        print("Signup Failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Register",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: formState,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              alignment: const Alignment(1.6, 0),
              height: 300,
              child: Image.asset(
                "images/pngbook.png",
                opacity: const AlwaysStoppedAnimation(0.4),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      _isLoading = false;
                      if (value!.isEmpty) {
                        return "Can not be Embty!!";
                      }
                      if (value.length < 3) {
                        _isLoading = false;
                        return "The username should be at least 3 characters long";
                      }
                      return null;
                    },
                    controller: username,
                    decoration: InputDecoration(
                        hintText: "Username",
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
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                    decoration: InputDecoration(
                        hintText: "Email",
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
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        _isLoading = false;
                        return "Can not be Embty!!";
                      }
                      if (value.length < 6) {
                        _isLoading = false;
                        return "The password should be at least 6 characters long";
                      }
                      return null;
                    },
                    obscureText: hidePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword =
                                    hidePassword == true ? false : true;
                              });
                            },
                            icon: hidePassword ? passHideEye : passshowEye),
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
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await register();
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
                              'Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
