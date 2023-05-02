import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mot_test/components/api_links.dart';
import 'package:mot_test/components/crud.dart';
import '../constant.dart';
import '../models/books_model.dart';
import '../widgets/primary_btn.dart';
import 'package:quickalert/quickalert.dart';

class EditBook extends StatefulWidget {
  BooksModel book;
  EditBook({super.key, required this.book});

  @override
  State<EditBook> createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> with Crud {
  File? myfile;
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController disc = TextEditingController();
  TextEditingController quality = TextEditingController();
  TextEditingController price = TextEditingController();

  bool _isLoading = false;

  editBook() async {
    if (formState.currentState!.validate()) {
      var response = await postRequest(
        editLink,
        {
          "title": title.text,
          "desc": disc.text,
          "quality": quality.text,
          "id": widget.book.id.toString(),
          "price": price.text.toString(),
        },
      );
      if (response['status'] == "success") {
        _isLoading = false;
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        _isLoading = false;
        print("Failed Edit");
      }
    }
  }

  deleteBook() async {
    var responses = await postRequest(deleteLink, {
      "id": widget.book.id.toString(),
      "imageName": widget.book.bookImage.substring(28)
    });

    if (responses['status'] == "success") {
      _isLoading = false;
      Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
    } else {
      _isLoading = false;
    }
  }

  @override
  void initState() {
    title.text = widget.book.title;
    disc.text = widget.book.description;
    quality.text = widget.book.quality;
    price.text = widget.book.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              const SizedBox(height: 150),
              TextFormField(
                controller: title,
                validator: (value) {
                  if (value!.isEmpty) {
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
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 25)),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: quality,
                validator: (value) {
                  if (value!.isEmpty) {
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
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 25)),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: price,
                validator: (value) {
                  if (value!.isEmpty) {
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
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 25)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: PrimaryBtn(
                  bgColor: kPrimaryColor,
                  btnText: 'Delete Book',
                  onPress: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      text: 'You are about to delete the book!!',
                      confirmBtnColor: kPrimaryColor,
                      confirmBtnText: "Delete",
                      onConfirmBtnTap: () async {
                        await deleteBook();
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await editBook();
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
                          'Update',
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
