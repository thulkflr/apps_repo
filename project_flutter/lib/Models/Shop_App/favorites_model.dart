class FavoritesModel {
  bool? status;
  String? message;
  Data? data;


  FavoritesModel();

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }


}

class Data {

  List<FavoritesData>? data;



  Data.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data = <FavoritesData>[];
      json['data'].forEach((v) {
        data!.add(FavoritesData.fromJson(v));
      });
    }


  }


}

class FavoritesData {
  int? id;
  ProductDetailsModel? product;
  FavoritesData();


  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? ProductDetailsModel.fromJson(json['product']) : null;
  }

}

class ProductDetailsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;


  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}