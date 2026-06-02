class Course {
  final int id;
  final String name;
  final String dayOfWeek;
  final String time;
  final String description;
  final String location;
  final String professor;
  final bool isEnrolled;
  final int? enrollmentId;

  Course({
    required this.id,
    required this.name,
    required this.dayOfWeek,
    required this.time,
    required this.description,
    required this.location,
    required this.professor,
    required this.isEnrolled,
    this.enrollmentId,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      dayOfWeek: json['day_of_week'],
      time: json['time'],
      description: json['description'],
      location: json['location'],
      professor: json['professor'],
      isEnrolled: json['is_enrolled'],
      enrollmentId: json['enrollment_id'],
    );
  }

  static List<Course> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Course.fromJson(json)).toList();
  }
}
