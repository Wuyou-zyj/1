class BaseModel<T>{

  T? data;
  int? code;
  String? message;

  BaseModel.fromJson(dynamic json){
    data=json['data'];
    code=json['code'];
    message=json['message'];
  }
}