part of 'resources.dart';

mixin AppTheme {
  static ThemeData get light => ThemeData(
        // primarySwatch: MaterialColor(0xffB1F9A3, primaryColorMap),
        // fontFamily: AppFonts.gilroy,
        // fontFamily: FontFamily.quickSand,
        // appBarTheme: const AppBarTheme(
        //   elevation: 0,
        //   systemOverlayStyle: SystemUiOverlayStyle.dark,
        //   backgroundColor: AppColors.kWhite,
        // ),
        scaffoldBackgroundColor: AppColors.kWhite,
        primaryColor: AppColors.kPrimary,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.kWhite),
        // useMaterial3: true,
        // colorSchemeSeed: AppColors.kPrimary,
        bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
      );
}

mixin AppDecorations {
  static const List<Color> gradientColors = [
    Color(0xff4296F8),
    Color(0xff0055DD),
  ];

  static const List<BoxShadow> accountTabDropShadow = [
    BoxShadow(
      blurRadius: 4,
      offset: Offset(0, 4),
      color: Color.fromRGBO(0, 0, 0, 0.25),
    ),
  ];
}
