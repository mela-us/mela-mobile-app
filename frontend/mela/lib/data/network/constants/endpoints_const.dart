class EndpointsConst {
  EndpointsConst._();

  // base url
  //static const String baseUrl = "http://jsonplaceholder.typicode.com";
  static const String baseUrl =
      "http://c4147a5c-0d19-46d9-8885-54b78c14c9c6.mock.pstmn.io";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = "/posts";
  static const String login = "/api/login";
  static const String signup = "/api/register";
  static const String refreshAccessToken = "/api/refresh-token";
  static const String getTopics = "/api/topics";
  static const String getLectures = "/api/lectures";
  static const String getLecturesAreLearning = "/api/lectures/recent";
  static const String getLevels = "/api/levels";
}
