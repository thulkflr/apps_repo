class ChangeFavoritsModel{
  bool status=true ;
  String message='';
  ChangeFavoritsModel();
  ChangeFavoritsModel.fromJson(Map<String,dynamic>json)
  {
    status =json['status'];
    message =json['message'];
  }

}