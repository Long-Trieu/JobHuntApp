class Experience {
  String id;
  String exp;

  Experience({
    this.id,
    this.exp,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json['_id'].toString(),
    exp: json['exp'].toString(),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['exp'] = this.exp;
    return data;
  }
}