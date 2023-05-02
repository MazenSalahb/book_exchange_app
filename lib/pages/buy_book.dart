import 'package:flutter/material.dart';
import 'package:mot_test/components/api_links.dart';
import 'package:mot_test/components/crud.dart';
import 'package:mot_test/constant.dart';

import '../main.dart';
import '../models/books_model.dart';

class BuyBook extends StatelessWidget with Crud {
  BooksModel book;
  BuyBook({super.key, required this.book});

  MyBooks() async {
    var resonse =
        await postRequest(viewLink, {"id": sharedPref.getString("id")});
    return resonse;
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
      body: Column(
        children: [
          Flexible(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    book.bookImage,
                    fit: BoxFit.contain,
                    height: 220,
                  ),
                  Text(
                    book.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "description: ${book.description}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Quality: ${book.quality}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Price: ${book.price}EG",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 2,
            color: kPrimaryColor,
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              const Text(
                "Trade With Your Books",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: MyBooks(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    //Check if have data
                    if (snapshot.data['status'] == "failed") {
                      return const Center(
                        child: Text(
                          "No Books...",
                          style: TextStyle(fontSize: 40),
                        ),
                      );
                    }
                    //If Data Exists
                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const PageScrollPhysics(),
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xffA7A7A7)
                                        .withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 20,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: MediaQuery.of(context).size.width * .95,
                              height: 300,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      "$imageLink${snapshot.data['data'][index]['book_image']}",
                                      width: 120,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        Text(
                                          snapshot.data['data'][index]['title'],
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(height: 80),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: kPrimaryColor,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Text(
                                              "Trade For ${int.parse(snapshot.data['data'][index]['price']) > int.parse(book.price) ? '${int.parse(snapshot.data['data'][index]['price']) - int.parse(book.price)}' : '+${int.parse(book.price) - int.parse(snapshot.data['data'][index]['price'])}'}EG"),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ));
                        },
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Text("loading ..."));
                  }
                  return const Center(child: Text("loading ..."));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
