class ResponseData<T> {
  bool? status;
  String? message;
  dynamic data;

  ResponseData({this.status, this.message, this.data});

  ResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = json['data'];
    } else {
      data = '';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ResponseData{status: $status, message: $message, data: $data}';
  }
}
