class HomeModel {
  bool status=true ;

  HomeModelData? data;

  HomeModel({required this.status,   this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data =
        (json['data'] != null ? HomeModelData.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class BannersModel {
  int? id;
  String? image;

  // Category? category;
  // ProductsModel? product;

  BannersModel({this.id, this.image});

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    // category =
    //     json['category'] != null ? Category.fromJson(json['category']) : null;
    // product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id!;
    data['image'] = image!;
    // data['category'] = category?.toJson();
    // data['product'] = product;
    return data;
  }
}

// class Category {
//   int? id;
//   String? image;
//   String? name;
//
//   Category({this.id, this.image, this.name});
//
//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id!;
//     data['image'] = image!;
//     data['name'] = name!;
//     return data;
//   }
// }

class ProductsModel {
  int id=0;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;
  String? name;

  bool inFavorites=true;
  bool inCart=true;

  ProductsModel(
      {required this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      required this.inFavorites,
      required this.inCart});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];

    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price!;
    data['old_price'] = oldPrice!;
    data['discount'] = discount!;
    data['image'] = image!;
    data['name'] = name!;

    data['in_favorites'] = inFavorites;
    data['in_cart'] = inCart;
    return data;
  }
}
