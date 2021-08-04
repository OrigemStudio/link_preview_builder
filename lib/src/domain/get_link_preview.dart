import '../../link_preview_builder.dart';

class GetLinkPreview {
  static final GetLinkPreview _instance = GetLinkPreview._internal();

  factory GetLinkPreview() {
    return _instance;
  }
  GetLinkPreview._internal();

  Future<InfoBase?> call(String? url,
      {Duration? cache, bool? showMultimedia, bool? useMultithread}) async {
    if (url!.startsWith("http")) {
      InfoBase? result;
      result = WebAnalyzer.getInfoFromCache(url);
      result ??= result = await WebAnalyzer.getInfo(
        url,
        cache: cache ?? const Duration(hours: 24),
        multimedia: showMultimedia ?? true,
        useMultithread: useMultithread ?? false,
      );
      return result;
    } else {
      print("Links don't start with http or https from : $url");
      return null;
    }
  }
}
