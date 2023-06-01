class JobType {
  String id;
  String jobTypeName;

  JobType({
    this.id,
    this.jobTypeName,
  });

  factory JobType.fromJson(Map<String, dynamic> json) => JobType(
    id: json['_id'].toString(),
    jobTypeName: json['jobTypeName'].toString(),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['jobTypeName'] = this.jobTypeName;
    return data;
  }
}