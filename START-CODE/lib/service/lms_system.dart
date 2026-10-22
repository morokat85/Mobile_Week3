import '../model/student.dart';
import '../model/course.dart';
import '../model/course_result.dart';

class LmsSystem {
  final List<Student> students = [];
  final List<Course> courses = [];
  final List<CourseResult> results = [];

  void addStudent({required String studentId, required String studentName}) {
    // ! Student shall not exist already
    Student? student = _findStudentOrNull(studentId);
    if (student != null) {
      throw Exception('Student $student already exists');
    }

    students.add(Student(id: studentId, name: studentName));
  }

  void removeStudent({required String studentId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }
    // 1- Remove student from the students list
    students.removeWhere((student) => student.id == studentId);
  }

  Student? _findStudentOrNull(String studentId) {
    for (Student s in students) {
      if (s.id == studentId) {
        return s;
      }
    }
    return null; // not found
  }

  // Course
  void addCourse({required String courseId, required String courseName}) {
    Course? course = _findCourseorNull(courseId);
    if (course != null) {
      throw Exception('Course $courseId already exists');
    }

    courses.add(Course(id: courseId, name: courseName));
  }

  void removeCourse({required String courseId}) {
    Course? course = _findCourseorNull(courseId);
    if (course == null) {
      throw Exception('Course $courseId not found');
    }
    courses.removeWhere((course) => course.id == courseId);
  }

  Course? _findCourseorNull(String courseId) {
    for (Course c in courses) {
      if (c.id == courseId) {
        return c;
      }
    }
    return null;
  }

  void enrollStudent({required String studentId, required String courseId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }

    Course? course = _findCourseorNull(courseId);
    if (course == null) {
      throw Exception('Course $courseId not found');
    }

    if (course.studentIds.contains(studentId)) {
      throw Exception('Student $studentId already enrollled in $courseId');
    }
    course.studentIds.add(studentId);
  }

  void discardStudentFromCourse(
      {required String studentId, required String courseId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }

    Course? course = _findCourseorNull(courseId);
    if (course == null) {
      throw Exception('Course $courseId not found');
    }
    if (!course.studentIds.contains(studentId)) {
      throw Exception('Student $studentId not enrollled in $courseId');
    }
    course.studentIds.remove(studentId);
  }

  void addResult(
      {required String resultId,
      required String studentId,
      required String courseId,
      required double score}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }

    Course? course = _findCourseorNull(courseId);
    if (course == null) {
      throw Exception('Course $courseId not exists');
    }

    if (!course.studentIds.contains(studentId)) {
      throw Exception('Student $studentId not enrollled in $courseId');
    }
    course.studentIds.remove(studentId);

    if (score < 0 || score > 100) {
      throw Exception('Score must be between 0 and 100');
    }
    bool haveResult = results.any(
      (r) => r.studentId == studentId && r.courseId == courseId,
    );
    if (haveResult) {
      throw Exception('Student $studentId already have result $courseId');
    }
    results.add(
      CourseResult(
        id: resultId,
        studentId: studentId,
        courseId: courseId,
        score: score,
      ),
    );
  }

  void removeResult({required String resultId}) {
    CourseResult? result = _findResultorNull(resultId);
    if (result == null) {
      throw Exception('Result $resultId not found');
    }
    results.removeWhere((r) => r.id == resultId);
  }
}
