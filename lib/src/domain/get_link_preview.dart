import '../../link_preview_builder.dart';

class GetLinkPreview {
  static Future<Preview?> call(String? url,
      {Duration? cache, bool? showMultimedia, bool? useMultithread}) async {
    if (url!.startsWith("http")) {
      Preview? result;
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
      return result;
    } else {
      throw Exception('Links dont start with http or https from : $url');
    }
  }
}
