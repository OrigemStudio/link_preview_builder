import 'package:flutter/material.dart';

import '../../link_preview_builder.dart';

class LinkPreviewBuilder extends StatelessWidget {
  const LinkPreviewBuilder({
    Key? key,
    this.url,
    this.preview,
    this.cache,
    this.builder,
    this.titleStyle,
    this.bodyStyle,
    this.showMultimedia,
    this.useMultithread,
    this.onEmpty,
    this.onError,
    this.onLoading,
  }) : super(key: key);

  // Web address, HTTP and HTTPS support
  final String? url;

  // Web address, HTTP and HTTPS support
  final Preview? preview;

  /// Cache result time, default cache 1 hour
  final Duration? cache;

  /// Customized your success state
  final Widget Function(Preview? preview)? builder;

  /// Customized your empty state
  final Widget? onEmpty;

  /// Customized your error state
  final Widget Function(String?)? onError;

  /// Customized your loading state
  final Widget? onLoading;

  /// Title style
  final TextStyle? titleStyle;

  /// Content style
  final TextStyle? bodyStyle;

  /// Show image or video
  final bool? showMultimedia;

  /// Whether to use multi-threaded analysis of web pages
  final bool? useMultithread;

  @override
  Widget build(BuildContext context) {
    final _controller = LinkPreviewController();
    _controller.onInit(preview: preview, url: url);
    return ValueListenableBuilder<status>(
        valueListenable: _controller.state,
        builder: (_, state, child) {
          switch (state) {
            case status.init:
              return onEmpty ?? const BuildEmpty();
            case status.success:
              return builder != null
                  ? builder!(_controller.data.value!)
                  : BuildSuccess(preview: _controller.data.value!);
            case status.error:
              return onError != null
                  ? onError!(_controller.error.value ?? 'Error fetching data!')
                  : BuildError(
                      error: _controller.error.value ?? 'Error fetching data!');
            case status.loading:
              return onEmpty ?? const BuildLoading();
          }
        });
  }
}
