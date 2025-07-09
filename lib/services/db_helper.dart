import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer' as developer;
import '../models/student.dart';

class DBHelper {
  static Database? _database;
  static const String tableName = 'students';
  static const String _logTag = 'DBHelper';

  static Future<Database> get database async {
    developer.log('Accessing database instance', name: _logTag);
    if (_database != null) {
      developer.log('Returning existing database instance', name: _logTag);
      return _database!;
    }
    developer.log('Creating new database instance', name: _logTag);
    _database = await _initDB();
    developer.log('Database instance created successfully', name: _logTag);
    return _database!;
  }

  static Future<Database> _initDB() async {
    try {
      String path = join(await getDatabasesPath(), 'class_manager.db');
      developer.log('Initializing database at path: $path', name: _logTag);

      final db = await openDatabase(path, version: 1, onCreate: _createDB);

      developer.log('Database initialized successfully', name: _logTag);
      return db;
    } catch (e) {
      developer.log(
        'Error initializing database: $e',
        name: _logTag,
        level: 1000,
      );
      rethrow;
    }
  }

  static Future<void> _createDB(Database db, int version) async {
    try {
      developer.log(
        'Creating database tables (version: $version)',
        name: _logTag,
      );

      await db.execute('''
        CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          phone TEXT NOT NULL,
          className TEXT NOT NULL,
          department TEXT NOT NULL,
          gender TEXT NOT NULL,
          dateRegistered TEXT NOT NULL,
          present INTEGER NOT NULL DEFAULT 0
        )
      ''');

      developer.log('Table "$tableName" created successfully', name: _logTag);
    } catch (e) {
      developer.log(
        'Error creating database tables: $e',
        name: _logTag,
        level: 1000,
      );
      rethrow;
    }
  }

  static Future<int> insertStudent(Student student) async {
    try {
      developer.log(
        'Inserting student: ${student.name} (${student.email})',
        name: _logTag,
      );

      final db = await database;
      final result = await db.insert(tableName, student.toMap());

      developer.log(
        'Student inserted successfully with ID: $result',
        name: _logTag,
      );
      return result;
    } catch (e) {
      developer.log('Error inserting student: $e', name: _logTag, level: 1000);
      rethrow;
    }
  }

  static Future<List<Student>> getAllStudents() async {
    try {
      developer.log('Fetching all students', name: _logTag);

      final db = await database;
      final maps = await db.query(tableName);
      final students = List.generate(
        maps.length,
        (i) => Student.fromMap(maps[i]),
      );

      developer.log(
        'Retrieved ${students.length} students from database',
        name: _logTag,
      );
      return students;
    } catch (e) {
      developer.log(
        'Error fetching all students: $e',
        name: _logTag,
        level: 1000,
      );
      rethrow;
    }
  }

  static Future<Student?> getStudent(int id) async {
    try {
      developer.log('Fetching student with ID: $id', name: _logTag);

      final db = await database;
      final maps = await db.query(tableName, where: 'id = ?', whereArgs: [id]);

      if (maps.isNotEmpty) {
        final student = Student.fromMap(maps.first);
        developer.log(
          'Student found: ${student.name} (ID: $id)',
          name: _logTag,
        );
        return student;
      }

      developer.log('No student found with ID: $id', name: _logTag);
      return null;
    } catch (e) {
      developer.log(
        'Error fetching student with ID $id: $e',
        name: _logTag,
        level: 1000,
      );
      rethrow;
    }
  }

  static Future<int> updateStudent(Student student) async {
    try {
      developer.log(
        'Updating student: ${student.name} (ID: ${student.id})',
        name: _logTag,
      );

      final db = await database;
      final result = await db.update(
        tableName,
        student.toMap(),
        where: 'id = ?',
        whereArgs: [student.id],
      );

      if (result > 0) {
        developer.log(
          'Student updated successfully (ID: ${student.id})',
          name: _logTag,
        );
      } else {
        developer.log(
          'No student found to update with ID: ${student.id}',
          name: _logTag,
        );
      }

      return result;
    } catch (e) {
      developer.log('Error updating student: $e', name: _logTag, level: 1000);
      rethrow;
    }
  }

  static Future<int> deleteStudent(int id) async {
    try {
      developer.log('Deleting student with ID: $id', name: _logTag);

      final db = await database;
      final result = await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result > 0) {
        developer.log('Student deleted successfully (ID: $id)', name: _logTag);
      } else {
        developer.log('No student found to delete with ID: $id', name: _logTag);
      }

      return result;
    } catch (e) {
      developer.log(
        'Error deleting student with ID $id: $e',
        name: _logTag,
        level: 1000,
      );
      rethrow;
    }
  }

  static Future<int> toggleAttendance(int id, bool present) async {
    try {
      developer.log(
        'Toggling attendance for student ID: $id to ${present ? "present" : "absent"}',
        name: _logTag,
      );

      final db = await database;
      final result = await db.update(
        tableName,
        {'present': present ? 1 : 0},
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result > 0) {
        developer.log(
          'Attendance updated successfully for student ID: $id',
          name: _logTag,
        );
      } else {
        developer.log(
          'No student found to update attendance for ID: $id',
          name: _logTag,
        );
      }

      return result;
    } catch (e) {
      developer.log(
        'Error updating attendance for student ID $id: $e',
        name: _logTag,
        level: 1000,
      );
      rethrow;
    }
  }

  // Additional utility methods for logging and debugging
  static Future<int> getStudentCount() async {
    try {
      developer.log('Getting total student count', name: _logTag);

      final db = await database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $tableName',
      );
      final count = result.first['count'] as int;

      developer.log('Total students in database: $count', name: _logTag);
      return count;
    } catch (e) {
      developer.log(
        'Error getting student count: $e',
        name: _logTag,
        level: 1000,
      );
      rethrow;
    }
  }

  static Future<void> closeDatabase() async {
    try {
      developer.log('Closing database connection', name: _logTag);

      if (_database != null) {
        await _database!.close();
        _database = null;
        developer.log('Database connection closed successfully', name: _logTag);
      } else {
        developer.log('No database connection to close', name: _logTag);
      }
    } catch (e) {
      developer.log('Error closing database: $e', name: _logTag, level: 1000);
      rethrow;
    }
  }

  static Future<void> logDatabaseInfo() async {
    try {
      final db = await database;
      final path = db.path;
      final version = await db.getVersion();
      final count = await getStudentCount();

      developer.log('''
Database Information:
- Path: $path
- Version: $version
- Total Students: $count
''', name: _logTag);
    } catch (e) {
      developer.log(
        'Error logging database info: $e',
        name: _logTag,
        level: 1000,
      );
    }
  }
}
