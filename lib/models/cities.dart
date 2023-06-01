class City {
  String id;
  String cityName;

  City({
    this.id,
    this.cityName,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json['_id'].toString(),
    cityName: json['cityName'].toString(),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['cityName'] = this.cityName;
    return data;
  }
}