import 'package:flutter/material.dart';
import 'package:testovyi/src/core/resources/resources.dart';
import 'package:testovyi/src/feature/home/model/crypto_dto.dart';

class CryptoItemWidget extends StatelessWidget {
  final CryptoData crypto;
  final Function()? onTap;
  const CryptoItemWidget({
    super.key,
    required this.crypto,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.kGrey,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  crypto.name?.replaceAll(
                          RegExp(
                            'X:',
                            dotAll: true,
                          ),
                          '') ??
                      '',
                  // 'BTC / USDT',
                  style: AppTextStyles.s14w600,
                ),
                const Spacer(),
                Text(
                  crypto.close.toString(),
                  // '3242423232',
                  style: AppTextStyles.s14w600,
                ),
                SizedBox(
                  height: 62,
                  width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      percent(crypto.close, crypto.open),
                      const SizedBox(
                        width: 3,
                      ),
                      price(crypto.close, crypto.open),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  percent(double a, double b) {
    double result = 0;
    result = ((b - a) * 100) / a;

    if (result > 0) {
      return Text(
        '+${result.toStringAsFixed(2)}%',
        style: AppTextStyles.s14w600.copyWith(color: AppColors.kGreen),
        textAlign: TextAlign.end,
      );
    } else {
      return Text(
        '${result.toStringAsFixed(2)}%',
        style: AppTextStyles.s14w600.copyWith(color: AppColors.kRed),
      );
    }
  }

  price(double a, double b) {
    double result = 0;
    result = (b - a);
    if (result > 0) {
      return Text(
        '+${result.toStringAsFixed(2)}',
        style: AppTextStyles.s10w400Grey,
        textAlign: TextAlign.end,
      );
    } else {
      return Text(
        result.toStringAsFixed(2),
        style: AppTextStyles.s10w400Grey,
        textAlign: TextAlign.end,
      );
    }
  }
}
