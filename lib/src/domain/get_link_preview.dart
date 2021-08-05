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
      if (result == null) {
        final response = await WebAnalyzer.getInfo(
          url,
          cache: cache ?? const Duration(hours: 24),
          multimedia: showMultimedia ?? true,
          useMultithread: useMultithread ?? false,
        );
        return response.fold((l) {
          throw Exception(l);
        }, (r) => r);
      }
    } else {
      throw Exception('Links dont start with http or https from : $url');
    }
  }
}
