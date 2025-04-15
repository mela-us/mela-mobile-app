class EndpointsConst {
  EndpointsConst._();

  //Endpoints:------------------------------------------------------------------
  static const String getQuestions = "/api/exercises/"; // +:exerciseId
  static const String saveResult = "/api/exercises/save";
  // base url
  //static const String baseUrl = "http://jsonplaceholder.typicode.com";
  static const String baseUrl = "https://api.mela.guru";
  // static const String baseUrl = "https://api.dev.mela.guru";

  // receiveTimeout
  static const int receiveTimeout = 30000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = "/posts";
  static const String login = "/api/login";
  static const String signup = "/api/register";
  static const String logout = "/api/logout";
  static const String refreshAccessToken = "/api/refresh-token";
  static const String getTopicLectureInLevel = "/api/lectures";
  static const String getTopics = "/api/topics";
  static const String getLectures = "/api/lectures";
  static const String getLecturesAreLearning = "/api/lectures/recent";
  static const String getLevels = "/api/levels";
  static const String getDividedLectures = "/api/lectures/:lectureId/sections";
  static const String getExercises = "/api/lectures/:lectureId/exercises";
  static const String getLecturesSearch = "/api/lectures/search";
  static const String forgotPasswordSendEmail = "/api/forgot-password";
  static const String forgotPasswordVerifyOTP =
      "/api/forgot-password/validate-otp";
  static const String forgotPasswordCreateNewPassword =
      "/api/forgot-password/reset-password";
  static const String getStats = "/api/statistics";
  static const String getUser = "/api/users/profile";
  static const String updateUser = "/api/users/profile";
  static const String getImageUpdatePresign =
      "/api/users/profile/upload-image-url";
  static const String deleteAccount = "/api/users/account";
  static const String getPresignUrl =
      "/api/chatbot/conversations/files/upload-url";
  static const String createNewConversation = "/api/chatbot/conversations";
  static const String sendMessageChat =
      "/api/chatbot/conversations/:conversationId/messages";
  static const String sendMessageReviewSubmission =
      "/api/chatbot/conversations/:conversationId/messages/review-submission";
  static const String sendMessageGetSolution =
      "/api/chatbot/conversations/:conversationId/messages/solution";

  static String generateGuide(String questionId) =>
      "/api/$questionId/hint/guide";
  static String generateTerm(String questionId) =>
      "/api/$questionId/hint/terms";

  // static String generateTerm(String questionId) =>
  //   "/api/ai-hint/$questionId";

  static const String updateSectionProgress = "/api/lecture-histories";
  static const String updateExerciseProgress = "/api/exercise-histories";

  static const String getChatHistory = "/api/chatbot/conversations";
}
