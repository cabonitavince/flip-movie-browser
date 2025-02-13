import 'package:flutter/material.dart';
import 'package:movie_browser/utils/constants.dart';

class CustomLoader extends StatelessWidget {
  final String message;
  final Color loaderColor;

  const CustomLoader(
      {super.key, this.message = 'Please wait..', this.loaderColor = AppConstants
          .primaryColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: loaderColor,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: Theme
                .of(context)
                .textTheme
                .titleSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
