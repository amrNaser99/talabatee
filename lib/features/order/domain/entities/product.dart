import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String desc;
  final String imgUrl;
  final double price;
  final double? offerPrice;
  final int catId;
  final int quantity;
  // final DateTime createDate;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.offerPrice,
    required this.catId,
    required this.desc,
    required this.quantity,
    required this.imgUrl,
    // required this.createDate,
  });

  @override
  List<Object> get props => [
        id,
        name,
        desc,
        imgUrl,
        price,
        catId,
        quantity,
        // createDate,
      ];
}
