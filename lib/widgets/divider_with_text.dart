import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String dividerText;
  const DividerWithText({Key key, @required this.dividerText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Text(dividerText),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
