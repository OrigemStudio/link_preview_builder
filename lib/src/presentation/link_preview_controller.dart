import 'package:flutter/cupertino.dart';
import 'package:link_preview_builder/link_preview_builder.dart';

enum status { init, success, loading, error }

class LinkPreviewController {
  final GetLinkPreview _getLinkPreview;

  final data = ValueNotifier<InfoBase?>(null);
  final link = ValueNotifier<String?>(null);
  final state = ValueNotifier<status>(status.init);
  final error = ValueNotifier<String?>(null);

  LinkPreviewController(this._getLinkPreview);
  Future<void> onInit({InfoBase? info, String? url}) async {
    state.value = status.loading;
    if (info == null && url == null) {
      error.value = 'Enter a url or date !';
      state.value = status.error;
    } else if (info == null) {
      final _url = url!.trim();
      final result = await _getLinkPreview.call(_url);
      if (result == null) {
        state.value = status.error;
      } else {
        data.value = result;
        state.value = status.success;
      }
    } else {
      data.value = info;
      state.value = status.success;
    }
  }
}
