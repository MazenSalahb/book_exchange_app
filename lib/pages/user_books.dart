// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:mot_test/components/crud.dart';
import 'package:mot_test/models/books_model.dart';
import 'package:mot_test/pages/edit_book.dart';
import '../components/api_links.dart';
import '../constant.dart';
import '../main.dart';
import '../services/view_user_books_service.dart';
import '../widgets/custom_book_card.dart';
import '../widgets/primary_btn.dart';

class MyBooks extends StatefulWidget {
  const MyBooks({super.key});

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> with Crud {
  viewBooks() async {
    var resonse =
        await postRequest(viewLink, {"id": sharedPref.getString("id")});
    return resonse;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: () async {
          setState(() {});
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            PrimaryBtn(
              bgColor: kPrimaryColor,
              btnText: 'Add Book',
              onPress: () {
                Navigator.of(context).pushNamed('addbook');
              },
            ),
            const SizedBox(height: 30),
            const Text(
              "My Books",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<BooksModel>>(
              future: ViewUserBookService().getAllBooks(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<BooksModel> books = snapshot.data!;
                  //Check if have data
                  if (books.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Books...",
                        style: TextStyle(fontSize: 40),
                      ),
                    );
                  }
                  //If Data Exists
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: books.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CustomBookCard(
                        book: books[index],
                        text: "Edit",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditBook(book: books[index]),
                              ));
                        },
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("loading ..."));
                }
                return const Center(child: Text("No Books ..."));
              },
            )
          ],
        ),
      ),
    );
  }
}
