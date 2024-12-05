class User{
  String? id;
  String? name;
  String? email;
  String? dob;
  String? password;
  
  User({
    this.id, this.name, this.email, this.dob, this.password
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["userId"],
    name: json["fullname"],
    email: json["username"],
    dob: json["birthday"],
    password: null,
  );
// Map<String, dynamic> toMap() {
//   throw UnimplementedError('toMap() must be implemented in a subclass');
// }
}