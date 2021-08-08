import 'package:flutter/cupertino.dart';
import 'package:link_preview_builder/link_preview_builder.dart';

enum status { init, success, loading, error }

class LinkPreviewController {
  final data = ValueNotifier<Preview?>(null);
  final link = ValueNotifier<String?>(null);
  final state = ValueNotifier<status>(status.init);
  final error = ValueNotifier<String?>(null);

  LinkPreviewController();
  Future<void> onInit({Preview? preview, String? url}) async {
    state.value = status.loading;
    if (preview == null && url == null) {
      error.value = 'Enter a url or date !';
      state.value = status.error;
    } else if (preview == null) {
      final _url = url!.trim();
      try {
        final result = await GetLinkPreview.call(_url);
        if (result == null) {
          state.value = status.error;
          error.value = 'Empty response';
        } else {
          data.value = result;
          state.value = status.success;
        }
      } on Exception catch (e) {
        state.value = status.error;
        error.value = e.toString();
      }
    } else {
      data.value = preview;
      state.value = status.success;
    }
  }
}
