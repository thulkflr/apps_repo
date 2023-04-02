class SettingModel {
  bool status=true;

  Data? data;



  SettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
 
    data = json['data'] != null ?   Data.fromJson(json['data']) : null;
  }


}

class Data {
  String? about;
  String? terms;



  Data.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    terms = json['terms'];
  }

}
