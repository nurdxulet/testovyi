import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';

class TimePeriodWidget extends StatelessWidget {
  final String period;
  final Function()? onTap;
  final bool isSelected;

  const TimePeriodWidget({
    super.key,
    required this.period,
    this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17,
      width: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isSelected ? AppColors.kGreen : AppColors.kWhite,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5),
            child: Text(
              period,
              style: isSelected ? AppTextStyles.s10w600White : AppTextStyles.s10w600,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
