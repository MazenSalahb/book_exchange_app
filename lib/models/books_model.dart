import 'package:mot_test/components/api_links.dart';

class BooksModel {
  final String id;
  final String title;
  final String description;
  final String quality;
  final String price;
  final String bookImage;
  final String userId;
  final String createdAt;

  BooksModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.quality,
      required this.price,
      required this.bookImage,
      required this.userId,
      required this.createdAt});

  factory BooksModel.fromJson(jsonData) {
    return BooksModel(
        id: jsonData['id'],
        title: jsonData['title'],
        description: jsonData['description'],
        quality: jsonData['quality'],
        price: jsonData['price'],
        bookImage: "$imageLink${jsonData['book_image']}",
        userId: jsonData['user_id'],
        createdAt: jsonData['created_at']);
  }
}
