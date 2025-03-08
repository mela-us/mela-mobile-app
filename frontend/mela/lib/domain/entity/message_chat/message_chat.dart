import 'dart:io';

class MessageChat {
  final String? message;
  bool isAI;
  List<File>? images;
  MessageChat({this.message, required this.isAI, this.images});
}
