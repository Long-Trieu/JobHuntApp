class User {
  String email;
  String password;
  String fullname;
  String dayOfBirth;
  String avatar;
  String phone;
  String address;
  String bio;
  String role;
  List<dynamic> idListNotification;
  bool status;

  User({
    this.email,
    this.password,
    this.fullname,
    this.dayOfBirth,
    this.avatar = "",
    this.phone,
    this.address,
    this.bio = "",
    this.role,
    this.idListNotification,
    this.status = true,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        password: json['password'],
        fullname: json['fullname'],
        dayOfBirth: json['dayOfBirth'],
        phone: json['phone'],
        address: json['address'],
        bio: json['bio'] ?? "",
        role: json['role'],
        idListNotification:
            List<dynamic>.from(json['idListNotification'] ?? []),
        status: json['status'] ?? true,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['fullname'] = this.fullname;
    data['dayOfBirth'] = this.dayOfBirth;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['bio'] = this.bio;
    data['role'] = this.role;
    data['idListNotification'] = this.idListNotification;
    data['status'] = this.status;
    return data;
  }
}
