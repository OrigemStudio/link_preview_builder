import 'package:flutter/material.dart';

import '../../link_preview_builder.dart';

/// Link Preview Widget
class LinkPreviewBuilder extends StatefulWidget {
  const LinkPreviewBuilder({
    Key? key,
    this.url,
    this.info,
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
  final InfoBase? info;

  /// Cache result time, default cache 1 hour
  final Duration? cache;

  /// Customized your success state
  final Widget Function(InfoBase? info)? builder;

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
  _LinkPreviewBuilderState createState() => _LinkPreviewBuilderState();
}

class _LinkPreviewBuilderState extends State<LinkPreviewBuilder> {
  late GetLinkPreview _getLinkPreview;
  late LinkPreviewController _controller;

  @override
  void initState() {
    _getLinkPreview = GetLinkPreview();
    _controller = LinkPreviewController(_getLinkPreview);
    _controller.onInit(info: widget.info, url: widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<status>(
        valueListenable: _controller.state,
        builder: (_, state, child) {
          print(state);
          switch (state) {
            case status.init:
              return widget.onEmpty ?? const BuildEmpty();
            case status.success:
              return widget.builder != null
                  ? widget.builder!(_controller.data.value!)
                  : BuildSuccess(info: _controller.data.value!);
            case status.error:
              return widget.onError != null
                  ? widget.onError!(_controller.error.value!)
                  : BuildError(error: _controller.error.value!);
            case status.loading:
              return widget.onEmpty ?? const BuildLoading();
          }
        });
  }
}
