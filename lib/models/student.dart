class Student {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String className;
  final String department;
  final String gender;
  final String dateRegistered;
  final bool present;

  Student({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.className,
    required this.department,
    required this.gender,
    required this.dateRegistered,
    this.present = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'className': className,
      'department': department,
      'gender': gender,
      'dateRegistered': dateRegistered,
      'present': present ? 1 : 0,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      className: map['className'],
      department: map['department'],
      gender: map['gender'],
      dateRegistered: map['dateRegistered'],
      present: map['present'] == 1,
    );
  }

  Student copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? className,
    String? department,
    String? gender,
    String? dateRegistered,
    bool? present,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      className: className ?? this.className,
      department: department ?? this.department,
      gender: gender ?? this.gender,
      dateRegistered: dateRegistered ?? this.dateRegistered,
      present: present ?? this.present,
    );
  }
}