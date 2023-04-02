

class HomeModel {
  bool? status;

  HomeModelData? data;

  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = (json['data'] != null ? HomeModelData.fromJson(json['data']) : null);
  }
}

class HomeModelData {
  List<BannersModel>? banners;
  List<ProductsModel>? products;

  HomeModelData({this.banners, this.products});

  HomeModelData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <BannersModel>[];
      json['banners'].forEach((v) {
        banners!.add(BannersModel.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <ProductsModel>[];
      json['products'].forEach((v) {
        products!.add(ProductsModel.fromJson(v));
      });
    }
  }
}

class BannersModel {
  int? id;
  String? image;


  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];

  }
}

class ProductsModel {
  ProductsModel();
  CartData? data;
  int? id ;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;
  String? name;
  ProductCartsModel? product;
  String? description;

  bool? inFavorites;

  bool? inCart;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;

    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    product =
    json['product'] != null ? ProductCartsModel.fromJson(json['product']) : null;
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
class ProductCartsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  Data? data;

  ProductCartsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? currentPage;
  List<CartData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;

  String? path;
  int? perPage;

  int? to;
  int? total;



  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data!.add(CartData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];

    path = json['path'];
    perPage = json['per_page'];

    to = json['to'];
    total = json['total'];
  }


}

class CartData {
  int? id;
  ProductCartsModel? product;
  CartData();


  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? ProductCartsModel.fromJson(json['product']) : null;
  }

}