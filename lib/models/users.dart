class User {
  String id;
  String email;
  String password;
  String fullname;
  String dayOfBirth;
  String avatar;
  String phone;
  String address;
  String bio;
  String role;
  String idMajor;
  String gender;
  bool status;

  User({
    this.id,
    this.email,
    this.password,
    this.fullname,
    this.dayOfBirth,
    this.avatar,
    this.phone,
    this.address,
    this.bio,
    this.role,
    this.idMajor,
    this.gender,
    this.status = true,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'].toString(),
        password: json['password'].toString(),
        fullname: json['fullname'].toString(),
        dayOfBirth: json['dayOfBirth'].toString(),
        phone: json['phone'].toString(),
        address: json['address'].toString(),
        gender: json['gender'].toString(),
        idMajor: json['idMajor'].toString(),
        role: json['role'].toString(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['fullname'] = this.fullname;
    data['dayOfBirth'] = this.dayOfBirth;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['bio'] = this.bio;
    data['role'] = this.role;
    data['gender'] = this.gender;
    data['idMajor'] = this.idMajor;
    data['status'] = this.status;
    return data;
  }
}
