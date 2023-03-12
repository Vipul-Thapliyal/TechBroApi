// class NamesModel {
//   String? name;
//   int? age;
//   String? profession;

//   NamesModel({this.name, this.age, this.profession});

//   NamesModel.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     age = json['age'];
//     profession = json['profession'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['age'] = this.age;
//     data['profession'] = this.profession;
//     return data;
//   }
// }
// 

class PostsModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostsModel({this.userId, this.id, this.title, this.body});

  PostsModel.fromJson(Map<String, dynamic> json) { // Object bana Map ka
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() { //Map ke object me PostModel key fields ki details daali
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
