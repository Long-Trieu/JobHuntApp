import 'package:flutter/material.dart';

class Job {
  final String companyLogo;
  final String jobTitle;
  final String salary;
  final String address;
  final String applyDeadline;

  Job({
    this.companyLogo,
    this.jobTitle,
    this.salary,
    this.address,
    this.applyDeadline,
  });
}

List<Job> jobs = [
  Job(
      companyLogo: "assets/logo1.png",
      jobTitle: "Flutter Developer",
      salary: "15-20 triệu",
      address: "Hà Nội",
      applyDeadline: "30/09/2022"),
  Job(
      companyLogo: "assets/logo2.png",
      jobTitle: "UX/UI Designer",
      salary: "10-15 triệu",
      address: "TP. Hồ Chí Minh",
      applyDeadline: "15/10/2022"),
  Job(
      companyLogo: "assets/logo3.png",
      jobTitle: "QA Tester",
      salary: "8-12 triệu",
      address: "Đà Nẵng",
      applyDeadline: "01/11/2022"),
];

class JobPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách công việc"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: jobs.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JobDetailPage(job: jobs[index])));
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(jobs[index].companyLogo),
                    SizedBox(height: 10.0),
                    Text(jobs[index].jobTitle, style: TextStyle(fontSize: 16.0)),
                    SizedBox(height: 5.0),
                    Text(jobs[index].salary),
                    SizedBox(height: 5.0),
                    Text(jobs[index].address),
                    SizedBox(height: 5.0),
                    Text("Hạn nộp hồ sơ: ${jobs[index].applyDeadline}"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class JobDetailPage extends StatelessWidget {
  final Job job;

  JobDetailPage({this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết công việc"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(job.companyLogo, height: 200.0),
            SizedBox(height: 10.0),
            Text(job.jobTitle, style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 5.0),
            Text(job.salary),
            SizedBox(height: 5.0),
            Text(job.address),
            SizedBox(height: 5.0),
            Text("Hạn nộp hồ sơ: ${job.applyDeadline}", style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}
