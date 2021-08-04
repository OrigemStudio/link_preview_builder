import 'package:flutter/material.dart';
import 'package:link_preview_builder/link_preview_builder.dart';

class BuildSuccess extends StatelessWidget {
  final InfoBase info;
  final TextStyle? titleStyle;
  final TextStyle? bodyStyle;
  const BuildSuccess(
      {Key? key, required this.info, this.titleStyle, this.bodyStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WebInfo data = info as WebInfo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Image.network(
              data.icon ?? "",
              fit: BoxFit.contain,
              width: 30,
              height: 30,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.link, size: 30, color: titleStyle?.color),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                data.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: titleStyle,
              ),
            ),
          ],
        ),
        if (WebAnalyzer.isNotEmpty(data.description)) ...[
          const SizedBox(height: 8),
          Text(
            data.description!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: bodyStyle,
          ),
        ],
      ],
    );
  }
}
