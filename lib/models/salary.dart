class Salary {
  String id;
  String rangeSalary;

  Salary({
    this.id,
    this.rangeSalary,
  });

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
    id: json['_id'].toString(),
    rangeSalary: json['rangeSalary'].toString(),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['rangeSalary'] = this.rangeSalary;
    return data;
  }
}