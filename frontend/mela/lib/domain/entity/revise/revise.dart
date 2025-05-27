class UserReviewsResponse {
  final String message;
  final List<Review> reviews;

  UserReviewsResponse({
    required this.message,
    required this.reviews,
  });

  factory UserReviewsResponse.fromJson(Map<String, dynamic> json) {
    return UserReviewsResponse(
      message: json['message'],
      reviews:
          (json['reviews'] as List).map((e) => Review.fromJson(e)).toList(),
    );
  }
}

class Review {
  final String reviewId;
  final String userId;
  final DateTime createdAt;
  final List<Exercise> exerciseList;
  final List<Section> sectionList;

  Review({
    required this.reviewId,
    required this.userId,
    required this.createdAt,
    required this.exerciseList,
    required this.sectionList,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewId: json['reviewId'],
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      exerciseList: (json['exerciseList'] as List)
          .map((e) => Exercise.fromJson(e))
          .toList(),
      sectionList: (json['sectionList'] as List)
          .map((e) => Section.fromJson(e))
          .toList(),
    );
  }
}

class Exercise {
  final String exerciseId;
  final int ordinalNumber;
  final bool isDone;
  final String lectureTitle;
  final String topicTitle;
  final String levelTitle;

  Exercise({
    required this.exerciseId,
    required this.ordinalNumber,
    required this.isDone,
    required this.lectureTitle,
    required this.topicTitle,
    required this.levelTitle,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exerciseId: json['exerciseId'],
      ordinalNumber: json['ordinalNumber'],
      isDone: json['isDone'],
      lectureTitle: json['lectureTitle'],
      topicTitle: json['topicTitle'],
      levelTitle: json['levelTitle'],
    );
  }
}

class Section {
  final String lectureId;
  final int ordinalNumber;
  final bool isDone;
  final String lectureTitle;
  final String topicTitle;
  final String levelTitle;
  final String sectionUrl;

  Section({
    required this.lectureId,
    required this.ordinalNumber,
    required this.isDone,
    required this.lectureTitle,
    required this.topicTitle,
    required this.levelTitle,
    required this.sectionUrl,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      lectureId: json['lectureId'],
      ordinalNumber: json['ordinalNumber'],
      isDone: json['isDone'],
      lectureTitle: json['lectureTitle'],
      topicTitle: json['topicTitle'],
      levelTitle: json['levelTitle'],
      sectionUrl: json['sectionUrl'],
    );
  }
}
