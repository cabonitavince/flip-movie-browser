import 'package:flutter/material.dart';
import 'package:movie_browser/utils/constants.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppConstants.primaryColor,
      child: Row(
        children: [
          const Icon(
            Icons.wifi_off,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text('No Internet Connection',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
