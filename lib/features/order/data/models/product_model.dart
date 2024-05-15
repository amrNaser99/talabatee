
import 'package:talabatee/features/order/domain/entities/product.dart';

const String tableProduct = 'Products';

/// table users column names
class ProductsFields {
  static const all = [
    id,
    name,
    price,
    offerPrice,
    desc,
    quantity,
    imgUrl,
    catId,
    // createDate
  ];
  static const String id = 'ID';
  static const String name = 'Name';
  static const String price = 'Price';
  static const String offerPrice = 'OfferPrice';
  static const String desc = 'Desc';
  static const String imgUrl = 'ImgUrl';
  static const String quantity = 'Quantity';
  static const String catId = 'CatID';
  static const String createDate = 'CreateDate';
}

class ProductModel extends Product {
  const ProductModel({
    required id,
    required name,
    required price,
    required offerPrice,
    required catId,
    required desc,
    required imgUrl,
    required quantity,
    // required createDate,
  }) : super(
          id: id,
          name: name,
          price: price,
          offerPrice: offerPrice,
          catId: catId,
          desc: desc,
          imgUrl: imgUrl,
          quantity: quantity,
          // createDate: createDate,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json[ProductsFields.id],
      name: json[ProductsFields.name] ?? '',
      price: json[ProductsFields.price],
      offerPrice: json[ProductsFields.offerPrice] ,
      catId: json[ProductsFields.catId],
      desc: json[ProductsFields.desc],
      imgUrl: json[ProductsFields.imgUrl] ?? '',
      quantity: json[ProductsFields.quantity],
      // createDate: json[ProductsFields.createDate],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'offerPrice': offerPrice,
      'catId': catId,
    };
  }
}
