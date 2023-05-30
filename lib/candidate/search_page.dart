import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _selectedMajor;
  String _selectedSalary;
  String _selectedJobType;
  String _selectedJobLevel;
  String _selectedExperience;
  String _selectedCity;

  final _majorList = [
    "Computer Science",
    "Engineering",
    "Mathematics",
    "Business",
  ];

  final _salaryList = [
    "Less than \$50k",
    "\$50k - \$100k",
    "\$100k - \$150k",
    "\$150k - \$200k",
    "More than \$200k",
  ];

  final _jobTypeList = [
    "Full-time",
    "Part-time",
    "Contract",
    "Internship",
  ];

  final _jobLevelList = [
    "Entry-Level",
    "Mid-Level",
    "Senior-Level",
    "Executive-Level",
  ];

  final _experienceList = [
    "0-2 years",
    "2-5 years",
    "5-10 years",
    "More than 10 years",
  ];

  final _cityList = [
    "New York",
    "San Francisco",
    "Seattle",
    "Chicago",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search job title or keywords",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Major"),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text("Select Major"),
                        value: _selectedMajor,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedMajor = newValue;
                          });
                        },
                        items: _majorList.map((major) {
                          return DropdownMenuItem<String>(
                            value: major,
                            child: Text(major),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Salary"),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text("Select Salary Range"),
                        value: _selectedSalary,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedSalary = newValue;
                          });
                        },
                        items: _salaryList.map((salaryRange) {
                          return DropdownMenuItem<String>(
                            value: salaryRange,
                            child: Text(salaryRange),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Job Type"),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text("Select Job Type"),
                        value: _selectedJobType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedJobType = newValue;
                          });
                        },
                        items: _jobTypeList.map((jobType) {
                          return DropdownMenuItem<String>(
                            value: jobType,
                            child: Text(jobType),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Job Level"),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text("Select Job Level"),
                        value: _selectedJobLevel,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedJobLevel = newValue;
                          });
                        },
                        items: _jobLevelList.map((jobLevel) {
                          return DropdownMenuItem<String>(
                            value: jobLevel,
                            child: Text(jobLevel),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Experience"),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text("Select Experience"),
                        value: _selectedExperience,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedExperience = newValue;
                          });
                        },
                        items: _experienceList.map((experience) {
                          return DropdownMenuItem<String>(
                            value: experience,
                            child: Text(experience),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("City"),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text("Select City"),
                        value: _selectedCity,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCity = newValue;
                          });
                        },
                        items: _cityList.map((city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
// Perform search operation here
              },
              child: Text("Search"),
            ),
          ],
        ),
      ),
    );
  }
}
