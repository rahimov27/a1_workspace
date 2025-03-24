import 'package:flutter/cupertino.dart';

class ServiceAdaptiveTextWidget extends StatelessWidget {
  final String text;
  const ServiceAdaptiveTextWidget({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Text(
        textAlign: TextAlign.center,
        text,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
