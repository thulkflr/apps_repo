// class ChangeCartModel{
//   bool status=true ;
//   String? message;
//   ChangeCartModel();
//   ChangeCartModel.fromJson(Map<String,dynamic>json)
//   {
//     status =json['status'];
//     message =json['message'];
//   }
//
// }
//
// // class ChangeCartModel {
// //   bool status=true;
// //   String? message;
// //   Data? data;
// //
// //
// //   ChangeCartModel.fromJson(Map<String, dynamic> json) {
// //     status = json['status'];
// //     message = json['message'];
// //     data = json['data'] != null ?  Data.fromJson(json['data']) : null;
// //   }
// //
// //
// // }
// //
// // class Data {
// //   int? id;
// //   Product? product;
// //
// //
// //   Data.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     product =
// //     json['product'] != null ?   Product.fromJson(json['product']) : null;
// //   }
// //
// //
// // }
// //
// // class Product {
// //   int? id;
// //   int? price;
// //   int? oldPrice;
// //   int? discount;
// //   String? image;
// //
// //
// //
// //   Product.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     price = json['price'];
// //     oldPrice = json['old_price'];
// //     discount = json['discount'];
// //     image = json['image'];
// //   }
// //
// // }

class ChangeCartModel {
  bool status=true;
  String? message;
  Data? data;

  ChangeCartModel( );

  ChangeCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?   Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? id;
  int? quantity;
  Product? product;



  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ?   Product.fromJson(json['product']) : null;
  }


}

class Product {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
