import 'package:flutter/material.dart';

class AddJobPage extends StatefulWidget {
  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _salaryController = TextEditingController();
  final _numberOfCandidatesController = TextEditingController();
  final _workTypeController = TextEditingController();
  final _careerLevelController = TextEditingController();
  final _genderController = TextEditingController();
  final _experienceController = TextEditingController();
  final _locationController = TextEditingController();
  final _jobDescriptionController = TextEditingController();
  final _candidateRequirementsController = TextEditingController();
  final _benefitsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _salaryController.dispose();
    _numberOfCandidatesController.dispose();
    _workTypeController.dispose();
    _careerLevelController.dispose();
    _genderController.dispose();
    _experienceController.dispose();
    _locationController.dispose();
    _jobDescriptionController.dispose();
    _candidateRequirementsController.dispose();
    _benefitsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm công việc'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tên công việc',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Nhập tên công việc',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên công việc';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                Text(
                  'Thông tin chung',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _salaryController,
                        decoration: InputDecoration(
                          labelText: 'Mức lương',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mức lương';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        controller: _numberOfCandidatesController,
                        decoration: InputDecoration(
                          labelText: 'Số lượng cần tuyển',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập số lượng cần tuyển';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _workTypeController,
                  decoration: InputDecoration(
                    labelText: 'Hình thức làm việc',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _careerLevelController,
                  decoration: InputDecoration(
                    labelText: 'Cấp bậc',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _genderController,
                  decoration: InputDecoration(
                    labelText: 'Giới tính',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _experienceController,
                  decoration: InputDecoration(
                    labelText: 'Kinh nghiệm làm việc',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Địa điểm làm việc',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 32.0),
                Text(
                  'Mô tả công việc',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _jobDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Nhập mô tả công việc',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mô tả công việc';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                Text(
                  'Yêu cầu ứng viên',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _candidateRequirementsController,
                  decoration: InputDecoration(
                    labelText: 'Nhập yêu cầu ứng viên',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập yêu cầu ứng viên';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                Text(
                  'Quyền lợi được hưởng',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _benefitsController,
                  decoration: InputDecoration(
                    labelText: 'Nhập quyền lợi được hưởng',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập quyền lợi được hưởng';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // Thực hiện thêm công việc
                    }
                  },
                  child: Text('Đăng tin tuyển dụng'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
