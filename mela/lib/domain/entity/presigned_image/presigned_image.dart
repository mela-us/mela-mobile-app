class PresignedImage {
  final String preSignedUrl;
  final String imageUrl;
  PresignedImage({
    required this.preSignedUrl,
    required this.imageUrl,
  });
  factory PresignedImage.fromJson(Map<String, dynamic> json) {
    return PresignedImage(
      preSignedUrl: json['preSignedUrl'] as String,
      imageUrl: json['fileUrl'] as String,
    );
  }
}