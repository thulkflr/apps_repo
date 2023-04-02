// // class CartModel {
// //   bool? status;
// //   String? message;
// //   Dataa? data;
// //
// //   CartModel();
// //
// //   CartModel.fromJson(Map<String, dynamic> json) {
// //     status = json['status'];
// //     message = json['message'];
// //     data = json['data'] != null ? Dataa.fromJson(json['data']) : null;
// //   }
// // }
// //
// // class Dataa {
// //   int? currentPage;
// //   List<CartsData>? data = [];
// //
// //   Dataa.fromJson(Map<String, dynamic> json) {
// //     currentPage = json['current_page'];
// //     if (json['data'] != null) {
// //       data = <CartsData>[];
// //       json['data'].forEach((value) {
// //         data!.add(CartsData.fromJson(value));
// //       });
// //     }
// //   }
// // }
// //
// // class CartsData {
// //   int? id;
// //   dynamic price;
// //   dynamic oldPrice;
// //   int? discount;
// //   String? image;
// //   String? name;
// //   String? description;
// //
// //   int? quantity;
// //
// //   CartsData();
// //
// //   CartsData.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     price = json['price'];
// //     oldPrice = json['old_price'];
// //     discount = json['discount'];
// //     image = json['image'];
// //     name = json['name'];
// //     description = json['description'];
// //     quantity = json['quantity'];
// //   }
// // }
// class CartModel {
//   bool? status;
//   String? message;
//   Dataa? data;
//
//
//   CartModel();
//
//   CartModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Dataa.fromJson(json['data']) : null;
//   }
//
//
// }
//
// class Dataa {
// int? id;
//   List<CartsData>? data;
//
//
//
//   Dataa.fromJson(Map<String, dynamic> json) {
//
//     if (json['data'] != null) {
//       data = <CartsData>[];
//       json['data'].forEach((v) {
//         data!.add(CartsData.fromJson(v));
//       });
//     }
//
//
//   }
//
//
// }
//
// class CartsData {
//   int? id;
//   ProductDetailsCartModel? product;
//   CartsData();
//
//
//   CartsData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product =
//     json['product'] != null ? ProductDetailsCartModel.fromJson(json['product']) : null;
//   }
//
// }
//
// class ProductDetailsCartModel {
//   int? id;
//   dynamic price;
//   dynamic oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;
//
//
//   ProductDetailsCartModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//   }
//
//
// }

class GetDataCartModel {
  bool status = true;
  String? message;
  Data? data;

  GetDataCartModel();

  GetDataCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?   Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<CartItems>? cartItems;
  int? subTotal;
  int? total;

  Data({this.cartItems, this.subTotal, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems?.add(CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItems {
  int? id;
  int? quantity;
  Product? product;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
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
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
