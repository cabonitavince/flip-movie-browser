import 'package:flutter/material.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFF1ce783),
      child: Row(
        children: [
          const Icon(Icons.wifi_off),
          const SizedBox(
            width: 8.0,
          ),
          Text('No Internet Connection',
              style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
