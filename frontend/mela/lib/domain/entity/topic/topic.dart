class Topic {
  String topicId;
  String topicName;
  String imageTopicPath;
  String? descriptionTopic;
  Topic({required this.topicId, required this.topicName,required this.imageTopicPath,this.descriptionTopic});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      topicId: json['topicId'],
      topicName: json['name'],
      imageTopicPath: json['imageUrl'],
      descriptionTopic: json['description']??"",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'topicId': topicId,
      'name': topicName,
      'imageUrl': imageTopicPath,
      'description': descriptionTopic,
    };
  }
}