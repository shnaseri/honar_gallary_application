import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class AutoDirection extends StatefulWidget {
  final String text;
  final Widget child;

  const AutoDirection({
    Key? key,
    required this.text,
    required this.child,
  }) : super(key: key);

  @override
  _AutoDirectionState createState() => _AutoDirectionState();
}

class _AutoDirectionState extends State<AutoDirection> {
  late String text;
  late Widget childWidget;

  @override
  Widget build(BuildContext context) {
    text = widget.text;
    childWidget = widget.child;
    return Directionality(
        textDirection: isRTL(text) ? TextDirection.rtl : TextDirection.ltr,
        child: childWidget);
  }

  @override
  void didUpdateWidget(AutoDirection oldWidget) {
    if (isRTL(oldWidget.text) != isRTL(widget.text)) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => {});
    }
    super.didUpdateWidget(oldWidget);
  }

  bool isRTL(String text) {
    return intl.Bidi.detectRtlDirectionality(text);
  }
}
