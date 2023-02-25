class CategoriesModel {
  bool status=true;

  CategoriesDataModel? data;

  CategoriesModel();

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data =CategoriesDataModel.fromJson( json['data'])  ;
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

class CategoriesDataModel {
  int? currentPage;
  List<DataModel>? data=[];



  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];


    json['data']!.forEach((v) {
        data!.add(DataModel.fromJson(v));
      });

      }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;



  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id!;
    data['name'] = name!;
    data['image'] = image!;
    return data;
  }
}
