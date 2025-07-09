// screens/home_page.dart
import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/db_helper.dart';
import '../utils/validators.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Student> students = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    setState(() {
      isLoading = true;
    });

    try {
      final loadedStudents = await DBHelper.getAllStudents();
      setState(() {
        students = loadedStudents;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorSnackBar('Error loading students: $e');
    }
  }

  Future<void> _toggleAttendance(Student student) async {
    try {
      await DBHelper.toggleAttendance(student.id!, !student.present);
      await _loadStudents();
      _showSuccessSnackBar('Attendance updated successfully');
    } catch (e) {
      _showErrorSnackBar('Error updating attendance: $e');
    }
  }

  Future<void> _deleteStudent(int id) async {
    try {
      await DBHelper.deleteStudent(id);
      await _loadStudents();
      _showSuccessSnackBar('Student deleted successfully');
    } catch (e) {
      _showErrorSnackBar('Error deleting student: $e');
    }
  }

  void _showAddEditDialog({Student? student}) {
    showDialog(
      context: context,
      builder: (context) => AddEditStudentDialog(
        student: student,
        onSave: () => _loadStudents(),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Manager'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : students.isEmpty
          ? _buildEmptyState()
          : _buildStudentsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(),
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No students yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap the + button to add your first student',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentsList() {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: student.present ? Colors.green : Colors.red,
              child: Icon(
                student.present ? Icons.check : Icons.close,
                color: Colors.white,
              ),
            ),
            title: Text(
              student.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${student.className} - ${student.department}'),
                Text('${student.email} • ${student.phone}'),
                Text('Registered: ${student.dateRegistered}'),
              ],
            ),
            trailing: PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case 'attendance':
                    _toggleAttendance(student);
                    break;
                  case 'edit':
                    _showAddEditDialog(student: student);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(student);
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'attendance',
                  child: Text(student.present ? 'Mark Absent' : 'Mark Present'),
                ),
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(Student student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Student'),
        content: Text('Are you sure you want to delete ${student.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteStudent(student.id!);
            },
            child: Text('Delete'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}

class AddEditStudentDialog extends StatefulWidget {
  final Student? student;
  final VoidCallback onSave;

  const AddEditStudentDialog({
    Key? key,
    this.student,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddEditStudentDialogState createState() => _AddEditStudentDialogState();
}

class _AddEditStudentDialogState extends State<AddEditStudentDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _classNameController;
  late TextEditingController _departmentController;
  String _selectedGender = 'Male';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student?.name ?? '');
    _emailController = TextEditingController(text: widget.student?.email ?? '');
    _phoneController = TextEditingController(text: widget.student?.phone ?? '');
    _classNameController = TextEditingController(text: widget.student?.className ?? '');
    _departmentController = TextEditingController(text: widget.student?.department ?? '');
    _selectedGender = widget.student?.gender ?? 'Male';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _classNameController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  Future<void> _saveStudent() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final student = Student(
        id: widget.student?.id,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        className: _classNameController.text.trim(),
        department: _departmentController.text.trim(),
        gender: _selectedGender,
        dateRegistered: widget.student?.dateRegistered ??
            DateTime.now().toString().split(' ')[0],
        present: widget.student?.present ?? false,
      );

      if (widget.student == null) {
        await DBHelper.insertStudent(student);
      } else {
        await DBHelper.updateStudent(student);
      }

      widget.onSave();
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.student == null
              ? 'Student added successfully'
              : 'Student updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving student: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.student == null ? 'Add Student' : 'Edit Student'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateName,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validatePhone,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _classNameController,
                decoration: InputDecoration(
                  labelText: 'Class Name',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateClassName,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _departmentController,
                decoration: InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateDepartment,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
                validator: Validators.validateGender,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveStudent,
          child: _isLoading
              ? SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : Text(widget.student == null ? 'Add' : 'Update'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
