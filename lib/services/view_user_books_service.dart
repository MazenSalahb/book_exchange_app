import 'package:mot_test/main.dart';
import 'package:mot_test/models/books_model.dart';
import '../helper/api.dart';

class ViewUserBookService {
  Future<List<BooksModel>> getAllBooks() async {
    List<BooksModel> ifnot = [];

    try {
      List<dynamic> data = await Api().post(
          url: 'http://mazensalah.tk/book/view.php',
          body: {'id': sharedPref.getString('id')});

      List<BooksModel> booksList = [];
      for (int i = 0; i < data.length; i++) {
        booksList.add(BooksModel.fromJson(data[i]));
      }
      return booksList;
    } catch (e) {
      return ifnot;
    }
  }
}
