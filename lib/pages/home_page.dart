import 'package:flutter/material.dart';
import 'package:mot_test/main.dart';
import 'package:mot_test/models/books_model.dart';
import 'package:mot_test/services/view_all_book_service.dart';
import '../constant.dart';
import '../widgets/custom_book_card.dart';
import 'buy_book.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                child: RefreshIndicator(
                  color: kPrimaryColor,
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    children: [
                      FutureBuilder<List<BooksModel>>(
                        future: ViewAllBooksServices().getAllBooks(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                                if (books[index].userId !=
                                    sharedPref.getString('id')) {
                                  return CustomBookCard(
                                    book: books[index],
                                    text: "Trade",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BuyBook(book: books[index]),
                                          ));
                                    },
                                  );
                                }
                                return const Text("");
                              },
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child: Text("loading ..."));
                          }
                          return const Center(child: Text("loading ..."));
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
