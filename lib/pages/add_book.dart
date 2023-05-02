// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mot_test/components/api_links.dart';
import 'package:mot_test/components/crud.dart';
import 'package:image_picker/image_picker.dart';
import '../constant.dart';
import '../main.dart';
import '../widgets/primary_btn.dart';
import 'package:quickalert/quickalert.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> with Crud {
  File? myfile;
  bool _isLoading = false;
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController disc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quality = TextEditingController();

  addBook() async {
    if (myfile == null) {
      _isLoading = false;
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Please Choose an Image',
      );
    }
    if (formState.currentState!.validate()) {
      var response = await postRequestWithFile(
          addLink,
          {
            "title": title.text,
            "desc": disc.text,
            "quality": quality.text,
            "id": sharedPref.getString("id"),
            "price": price.text
          },
          myfile!);
      if (response['status'] == "success") {
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        _isLoading = false;
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text:
              'Sorry, something went wrong\nMake Sure Image Extention is (jpeg,jpg,png,gif)',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formState,
          child: ListView(
            children: [
              const SizedBox(height: 80),
              TextFormField(
                controller: title,
                validator: (value) {
                  if (value!.isEmpty) {
                    _isLoading = false;
                    return "Cannot Be Embty!!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Title",
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
              const SizedBox(height: 20),
              TextFormField(
                controller: disc,
                validator: (value) {
                  if (value!.isEmpty) {
                    _isLoading = false;
                    return "Cannot Be Embty!!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 25),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: quality,
                validator: (value) {
                  if (value!.isEmpty) {
                    _isLoading = false;
                    return "Cannot Be Embty!!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Quality",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 25),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: price,
                validator: (value) {
                  if (value!.isEmpty) {
                    _isLoading = false;
                    return "Cannot Be Embty!!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 25),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: PrimaryBtn(
                  bgColor: myfile == null ? kPrimaryColor : Colors.green,
                  btnText: myfile == null ? "Choose Image" : 'Image Selected',
                  onPress: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: 130,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                XFile? xfile = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (xfile != null) {
                                  myfile = File(xfile.path);
                                  Navigator.pop(context);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                child: const Text("Choose Image From Gallery"),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                XFile? xfile = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);
                                if (xfile != null) {
                                  myfile = File(xfile.path);
                                  Navigator.pop(context);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                child: const Text("Choose Image From Camera"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
                          await addBook();
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
                          'Add',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
