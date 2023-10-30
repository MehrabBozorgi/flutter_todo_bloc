class TodoModel {
  TodoModel({
    this.data,
    this.status,
  });
  List<Data>? data;
  String? status;
  TodoModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    status = json['status'];
  }




}

class Data {
  Data({
    this.id,
    this.title,
    this.description,
    this.isdone,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isdone = json['isdone'];
  }

  String? id;
  String? title;
  String? description;
  String? isdone;


}
