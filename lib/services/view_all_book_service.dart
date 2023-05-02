import 'package:mot_test/models/books_model.dart';
import '../helper/api.dart';

class ViewAllBooksServices {
  Future<List<BooksModel>> getAllBooks() async {
    List<dynamic> data =
        await Api().get(url: 'http://mazensalah.tk/book/viewall.php');

    List<BooksModel> booksList = [];
    for (int i = 0; i < data.length; i++) {
      booksList.add(BooksModel.fromJson(data[i]));
    }
    return booksList;
  }
}
