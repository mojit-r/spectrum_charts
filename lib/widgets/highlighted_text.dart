import 'package:flutter/material.dart';

/// Renders [text] with the first case-insensitive match of [query]
/// highlighted using the theme's highlight color.
class HighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle? style;

  const HighlightedText({
    super.key,
    required this.text,
    required this.query,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = (style ?? DefaultTextStyle.of(context).style)
    .copyWith(color: style?.color ?? Theme.of(context).colorScheme.onSurface);

    if (query.isEmpty) {
      return Text(text, style: baseStyle);
    }

    final matchIndex = text.toLowerCase().indexOf(query.toLowerCase());
    if (matchIndex == -1) {
      return Text(text, style: baseStyle);
    }

    final matchEnd = matchIndex + query.length;

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: text.substring(0, matchIndex), style: baseStyle),
          TextSpan(
            text: text.substring(matchIndex, matchEnd),
            style: baseStyle.copyWith(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          TextSpan(text: text.substring(matchEnd), style: baseStyle),
        ],
      ),
    );
  }
}
