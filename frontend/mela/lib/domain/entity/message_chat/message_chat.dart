import 'dart:io';

class MessageChat {
  final String? message;//Can null for display in UI
  bool isAI;
  List<File>? images;
  MessageChat({this.message, required this.isAI, this.images});
}
