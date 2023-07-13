import 'package:flutter/material.dart';
import 'package:testovyi/src/core/resources/resources.dart';

class ImageUtil {
  ImageUtil._();

  static Widget loadingBuilder(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.kPrimary,
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }
}
