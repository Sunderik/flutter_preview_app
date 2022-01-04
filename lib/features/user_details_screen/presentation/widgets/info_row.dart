import 'package:flutter/material.dart';
///
class InfoRow extends StatelessWidget {
  ///
  final String name;
  ///
  final Widget widget;
  ///
  final Function()? onTap;

  const InfoRow({Key? key, required this.name, required this.widget, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: const Color.fromRGBO(255, 255, 255, 0.4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name + ':',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: widget,
            ),
          ],
        ),
      ),
    );
  }
}