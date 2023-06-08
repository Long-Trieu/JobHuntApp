class Job {
  String id;
  String jobName;
  String avatar;
  String fullname;
  String candidateNumber;
  String gender;
  String jobDescription;
  String jobRequires;
  String jobPerks;
  String applicationDeadline;
  String idMajor;
  String idUser;
  String idSalary;
  String idJobType;
  String idJobLevel;
  String idExp;
  String idCity;

  Job({
    this.id,
    this.jobName,
    this.avatar,
    this.fullname,
    this.candidateNumber,
    this.gender,
    this.jobDescription,
    this.jobRequires,
    this.jobPerks,
    this.applicationDeadline,
    this.idMajor,
    this.idUser,
    this.idSalary,
    this.idJobType,
    this.idJobLevel,
    this.idExp,
    this.idCity,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json['_id'].toString(),
    jobName: json['jobName'].toString(),
    avatar: json['avatar'].toString(),
    fullname: json['fullname'].toString(),
    candidateNumber: json['candidateNumber'].toString(),
    gender: json['gender'].toString(),
    jobDescription: json['jobDescription'].toString(),
    jobRequires: json['jobRequires'].toString(),
    jobPerks: json['jobPerks'].toString(),
    applicationDeadline: json['applicationDeadline'].toString(),
    idMajor: json['idMajor'].toString(),
    idUser: json['idUser'].toString(),
    idSalary: json['idSalary'].toString(),
    idJobType: json['idJobType'].toString(),
    idJobLevel: json['idJobLevel'].toString(),
    idExp: json['idExp'].toString(),
    idCity: json['idCity'].toString(),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['jobName'] = this.jobName;
    data['avatar'] = this.avatar;
    data['fullname'] = this.fullname;
    data['candidateNumber'] = this.candidateNumber;
    data['gender'] = this.gender;
    data['jobDescription'] = this.jobDescription;
    data['jobRequires'] = this.jobRequires;
    data['jobPerks'] = this.jobPerks;
    data['applicationDeadline'] = this.applicationDeadline;
    data['idMajor'] = this.idMajor;
    data['idUser'] = this.idUser;
    data['idSalary'] = this.idSalary;
    data['idJobType'] = this.idJobType;
    data['idJobLevel'] = this.idJobLevel;
    data['idExp'] = this.idExp;
    data['idCity'] = this.idCity;
    return data;
  }
}
