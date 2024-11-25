import 'package:image_picker/image_picker.dart';

class Product {
  String title;
  String detail;
  String location;
  int price;
  List<XFile> images;
  bool isLiked;

  Product({
    required this.title,
    required this.detail,
    required this.price,
    required this.images,
    required this.location,
    this.isLiked = false,
  });

  void toggleLike() {
    isLiked = !isLiked;
  }
}