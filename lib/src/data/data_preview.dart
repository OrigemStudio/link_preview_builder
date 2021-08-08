abstract class Preview {
  late DateTime timeout;
}

/// Web Information
class DataPreview extends Preview {
  final String? title;
  final String? icon;
  final String? description;
  final String? image;
  final String? redirectUrl;

  DataPreview({
    this.title,
    this.icon,
    this.description,
    this.image,
    this.redirectUrl,
  });
}

/// Image Information
class MediaPreview extends Preview {
  final String? image;

  MediaPreview({this.image});
}

/// Video Information
class VideoPreview extends MediaPreview {
  VideoPreview({String? image}) : super(image: image);
}
