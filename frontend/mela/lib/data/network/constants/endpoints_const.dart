class EndpointsConst {
  EndpointsConst._();

  // base url
  //static const String baseUrl = "http://jsonplaceholder.typicode.com";
  static const String baseUrl = "https://api.dev.mela.guru";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = "/posts";
  static const String login = "/api/login";
  static const String signup = "/api/register";
  static const String logout = "/api/logout";
  static const String refreshAccessToken = "/api/refresh-token";
  static const String getTopics = "/api/topics";
  static const String getLectures = "/api/lectures";
  static const String getLecturesAreLearning = "/api/lectures/recent";
  static const String getLevels = "/api/levels";
  static const String getDividedLectures = "/api/lectures/:lectureId/sections";
  static const String getExercises = "/api/lectures/:lectureId/exercises";
  static const String getLecturesSearch = "/api/lectures/search";
  static const String getStats = "/api/statistics";
  static const String getUser = "/api/profile";
}
