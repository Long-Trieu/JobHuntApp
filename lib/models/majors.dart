class Major {
  String id;
  String majorName;

  Major({
    this.id,
    this.majorName,
  });

  factory Major.fromJson(Map<String, dynamic> json) => Major(
    id: json['_id'].toString(),
    majorName: json['majorName'].toString(),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['majorName'] = this.majorName;
    return data;
  }
}