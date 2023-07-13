// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const NOT_FOUND_IMAGE =
    'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png';

Widget refreshClassicHeader(BuildContext context) {
  return const ClassicHeader(
    completeText: 'Successfully updated',
    releaseText: 'Update',
    idleText: 'Pull down to refresh',
    failedText: 'Unknown error',
    refreshingText: 'Update...',
  );
}

Widget refreshClassicFooter(BuildContext context) {
  return const ClassicFooter(
    idleText: '',
    failedText: 'Unknown error',
    loadingText: 'Update...',
    canLoadingText: 'Pull up to refresh',
    idleIcon: null,
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

bool hasCommonElement(List<int> array1, List<int> array2) {
  // Iterate through array1
  for (final int element in array1) {
    // Check if the element is present in array2
    if (array2.contains(element)) {
      return true; // Found a common element, return true
    }
  }

  return false; // No common element found
}
