import 'package:books_store/helpers/consts.dart';
import 'package:flutter/cupertino.dart';

class ClickableText extends StatelessWidget {
  const ClickableText({super.key, required this.text, required this.onTap});
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Text(text, style: labelSmall.copyWith(color: primaryColor)),
      ),
    );
  }
}
