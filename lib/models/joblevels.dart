class JobLevel {
  String id;
  String level;

  JobLevel({
    this.id,
    this.level,
  });

  factory JobLevel.fromJson(Map<String, dynamic> json) => JobLevel(
    id: json['_id'].toString(),
    level: json['level'].toString(),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['level'] = this.level;
    return data;
  }
}