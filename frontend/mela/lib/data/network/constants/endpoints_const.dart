class EndpointsConst {
  EndpointsConst._();

  //Endpoints:------------------------------------------------------------------
  static const String getQuestions = "/api/exercises/"; // +:exerciseId
  static const String saveResult = "/api/exercises/save";
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
  static const String refreshAccessToken = "/api/refresh-token";
  static const String getTopics = "/api/topics";
  static const String getLectures = "/api/lectures";
  static const String getLecturesAreLearning = "/api/lectures/recent";
  static const String getLevels = "/api/levels";
  static const String getDividedLectures = "/api/lectures/:lectureId/sections";
  static const String getExercises = "/api/lectures/:lectureId/exercises";
  static const String getLecturesSearch = "/api/lectures/search";
  static const String forgotPasswordSendEmail = "/api/forgot-password";
  static const String forgotPasswordVerifyOTP = "/api/forgot-password/validate-otp";
  static const String forgotPasswordCreateNewPassword = "/api/forgot-password/reset-password";
}
