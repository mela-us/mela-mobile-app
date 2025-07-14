class User{
  String? id;
  String? name;
  String? email;
  String? dob;
  String? imageUrl;
  String? level;
  
  User({
    this.id, this.name, this.email, this.dob, this.imageUrl, this.level
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["user"]["userId"],
    name: json["user"]["fullname"],
    email: json["user"]["username"],
    dob: json["user"]["birthday"],
    imageUrl: json["user"]["imageUrl"],
    level: json["user"]["levelTitle"],
  );
}