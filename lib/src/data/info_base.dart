abstract class InfoBase {
  late DateTime timeout;
}

/// Web Information
class WebInfo extends InfoBase {
  final String? title;
  final String? icon;
  final String? description;
  final String? image;
  final String? redirectUrl;

  WebInfo({
    this.title,
    this.icon,
    this.description,
    this.image,
    this.redirectUrl,
  });
}

/// Image Information
class WebImageInfo extends InfoBase {
  final String? image;

  WebImageInfo({this.image});
}

/// Video Information
class WebVideoInfo extends WebImageInfo {
  WebVideoInfo({String? image}) : super(image: image);
}
