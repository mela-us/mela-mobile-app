class SectionProgressParams {
  final String lectureId;
  final int ordinalNumber;
  final DateTime completedAt;

  SectionProgressParams({
    required this.lectureId,
    required this.ordinalNumber,
    required this.completedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'lectureId': lectureId,
      'ordinalNumber': ordinalNumber,
      'completedAt': completedAt.toIso8601String(),
    };
  }
}
