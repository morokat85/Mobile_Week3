import 'package:test/test.dart';

import '../lib/service/lms_system.dart';

void main() {
  test('creates a student', () {
    final lms = LmsSystem();

    // Create a student
    lms.addStudent(studentId: 'S1', studentName: "ronan");

    expect(lms.students.first.name, 'ronan');

    // Remove the student
    lms.removeStudent(studentId: 'S1');
    expect(lms.students.length, 0);
  });

  test('creates a course', () {
    final lms = LmsSystem();

    // Create a course
    lms.addCourse(courseId: 'C1', courseName: "OOP");

    expect(lms.courses.first.name, 'OOP');

    // Remove the course
    lms.removeCourse(courseId: 'C1');
    expect(lms.courses.length, 0);
  });

  test('rejects duplicate a course', () {
    final lms = LmsSystem();

    lms.addCourse(courseId: 'C1', courseName: 'OOP');

    expect(() => lms.addCourse(courseId: 'C1', courseName: 'OOP'),
        throwsException);
  });

  test('rejects duplicate a course', () {
    final lms = LmsSystem();
    expect(() => lms.removeCourse(courseId: 'C99'), throwsException);
  });

  test('enroll student', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S2', studentName: 'ronan');
    lms.addCourse(courseId: 'C1', courseName: 'OOP');
    lms.enrollStudent(studentId: 'S2', courseId: 'C1');

    expect(lms.courses.first.studentIds, contains('S2'));
  });

  test('rejects missing student', () {
    final lms = LmsSystem();

    lms.addCourse(courseId: 'C1', courseName: 'OOP');

    expect(() => lms.enrollStudent(studentId: 'S2', courseId: 'C1'),
        throwsException);
  });

  test('rejects missing student', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S1', studentName: 'ronan');

    expect(() => lms.enrollStudent(studentId: 'S2', courseId: 'C1'),
        throwsException);
  });

  test('rejects duplicate', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S2', studentName: 'ronan');
    lms.addCourse(courseId: 'C1', courseName: 'OOP');
    lms.enrollStudent(studentId: 'S2', courseId: 'C1');

    expect(() => lms.enrollStudent(studentId: 'S2', courseId: 'C1'),
        throwsException);
  });

  test('discard student from course', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S2', studentName: 'ronan');
    lms.addCourse(courseId: 'C1', courseName: 'OOP');
    lms.enrollStudent(studentId: 'S2', courseId: 'C1');
    lms.discardStudentFromCourse(studentId: 'S2', courseId: 'C1');

    expect(lms.courses.first.studentIds, isNot(contains('S2')));
  });

  test('student not enroll', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S2', studentName: 'ronan');
    lms.addCourse(courseId: 'C1', courseName: 'OOP');

    expect(() => lms.enrollStudent(studentId: 'S2', courseId: 'C1'),
        throwsException);
  });

  test('student and course exits', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S2', studentName: 'ronan');
    lms.addCourse(courseId: 'C1', courseName: 'OOP');
    lms.enrollStudent(studentId: 'S2', courseId: 'C1');
    lms.discardStudentFromCourse(studentId: 'S2', courseId: 'C1');

    expect(lms.students.length, 1);
    expect(lms.courses.length, 1);
  });

  test('valid result', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S2', studentName: 'ronan');
    lms.addCourse(courseId: 'C1', courseName: 'OOP');
    lms.enrollStudent(studentId: 'S2', courseId: 'C1');

    lms.addResult(resultId: 'R1', studentId: 'S2', courseId: 'C1', score: 4);

    expect(lms.students.length, 1);
  });

  test('invalid score', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S2', studentName: 'ronan');
    lms.addCourse(courseId: 'C1', courseName: 'OOP');
    lms.enrollStudent(studentId: 'S2', courseId: 'C1');

    expect(() => lms.addResult( resultId: 'R1', studentId: 'S2', courseId: 'C1', score: 9), throwsException);

  });
}
