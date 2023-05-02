import 'package:flutter/material.dart';
import 'package:mot_test/components/api_links.dart';
import 'package:mot_test/components/crud.dart';

import '../constant.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Crud {
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool hidePassword = true;
  bool _isLoading = false;

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

  login() async {
    if (formState.currentState!.validate()) {
      var response = await postRequest(
          loginLink, {"email": email.text, "password": password.text});
      if (response['status'] == "success") {
        sharedPref.setString("id", response['data']['id'].toString());
        sharedPref.setString("username", response['data']['username']);
        sharedPref.setString("email", response['data']['email']);
        sharedPref.setString("password", response['data']['password']);
        _isLoading = false;
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        _isLoading = false;
        setState(() {});
        print("Login Failed");
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
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: const Text(
          "Sign In",
          style: TextStyle(
              color: kPrimaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: formState,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              alignment: const Alignment(1.6, 0),
              height: 380,
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
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        _isLoading = false;
                        return "Cannot Be Embty!!";
                      }
                      return null;
                    },
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
                        return "Cannot Be Embty!!";
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
                              await login();
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
                              'Login',
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
                const Text("doesn't havew an account? "),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'register');
                    },
                    style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                    child: const Text(
                      "Register",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
