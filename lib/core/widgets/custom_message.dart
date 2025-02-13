import 'package:flutter/material.dart';
import 'package:movie_browser/core/enum/message_type_enum.dart';

class CustomMessage extends StatelessWidget {
  final MessageTypeEnum type;
  final String message;
  final Color? iconColor;

  const CustomMessage(
      {super.key,
      required this.message,
      this.iconColor,
      this.type = MessageTypeEnum.info});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildIcon(),
          const SizedBox(height: 10),
          Text(
            message,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildIcon() {
    switch (type) {
      case MessageTypeEnum.info:
        return Icon(
          Icons.info,
          color: iconColor ?? Colors.grey,
        );
      case MessageTypeEnum.error:
        return Icon(
          Icons.error,
          color: iconColor ?? Colors.red,
        );
      case MessageTypeEnum.warning:
        return Icon(
          Icons.warning,
          color: iconColor ?? Colors.orange,
        );
      case MessageTypeEnum.success:
        return Icon(
          Icons.check_circle,
          color: iconColor ?? Colors.green,
        );
    }
  }
}
