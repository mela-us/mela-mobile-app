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
    id: json["userId"],
    name: json["fullname"],
    email: json["username"],
    dob: json["birthday"],
    imageUrl: json["imageUrl"],
    level: json["level"],
  );
  // Map<String, dynamic> toMap() {
//   throw UnimplementedError('toMap() must be implemented in a subclass');
// }
}