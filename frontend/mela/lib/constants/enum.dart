enum AnswerStatus {
  correct,
  incorrect,
  noAnswer,
}

enum QuitOverlayResponse {
  wait,
  quit,
  stay,
}

enum ResponseStatus { OK, SIMILAR, UNAUTHORIZED, ERROR, BAD_REQUEST, UNKNOWN }

enum UpdateField { name, image, birthday }

enum MessageType {
  initial('Initial'),
  explain('Explain Problem'),
  review('Review'),
  solution('Solution'),
  normal('Normal'); //For user and for AI normal

  final String displayName;
  const MessageType(this.displayName);
}

enum LevelConversation {
  UNIDENTIFIED,
  PROBLEM_IDENTIFIED,
  SUBMISSION_REVIEWED,
  SOLUTION_PROVIDED,
  COMPLETED,
}
