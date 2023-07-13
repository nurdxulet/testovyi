import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:testovyi/src/core/common/constants.dart';
import 'package:testovyi/src/core/enum/environment.dart';
import 'package:testovyi/src/core/gen/assets.gen.dart';
import 'package:testovyi/src/core/resources/resources.dart';
import 'package:testovyi/src/core/widget/custom/custom_snackbars.dart';
import 'package:testovyi/src/feature/app/router/app_router.dart';
import 'package:testovyi/src/feature/home/bloc/daily_bars_cubit.dart';
import 'package:intl/intl.dart';
import 'package:testovyi/src/feature/home/presentation/widgets/crypto_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String date = DateFormat('yyyy-MM-dd').format(DateTime(2023, 01, 09));
  TextEditingController textFieldController = TextEditingController();

  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    BlocProvider.of<DailyBarsCubit>(context).getDailyBars(date, kApiKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Криптовалюта',
                      style: AppTextStyles.s26w400,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(Assets.icons.icSearch.path),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.icons.icEdit.path),
                  const SizedBox(
                    width: 3,
                  ),
                  const Text(
                    "Тикер / Название",
                    style: AppTextStyles.s10w400Grey,
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(3),
                    onTap: () {},
                    child: SizedBox(
                      height: 12,
                      // width: 70,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Цена",
                              style: AppTextStyles.s10w400Grey,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            SvgPicture.asset(Assets.icons.icSort.path),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(3),
                    onTap: () {},
                    child: SizedBox(
                      height: 12,
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Изм. % / \$",
                            style: AppTextStyles.s10w400Grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          SvgPicture.asset(Assets.icons.icSort.path),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: AppColors.kGrey,
              height: 1,
            ),
            Expanded(
              child: BlocConsumer<DailyBarsCubit, DailyBarsState>(
                listener: (context, state) {
                  state.whenOrNull(
                    errorState: (String message) {
                      buildErrorCustomSnackBar(context, message);
                    },
                    loadedState: (dailyBars) {},
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox(),
                    loadedState: (dailyBars) {
                      return dailyBars.isEmpty
                          ? SmartRefresher(
                              header: refreshClassicHeader(context),
                              footer: refreshClassicFooter(context),
                              controller: refreshController,
                              onRefresh: () {
                                BlocProvider.of<DailyBarsCubit>(context).getDailyBars(date, kApiKey);
                                refreshController.refreshCompleted();
                              },
                              child: const Center(
                                child: Text(
                                  'Пусто',
                                  style: AppTextStyles.s26w400,
                                ),
                              ),
                            )
                          : AnimationLimiter(
                              child: SmartRefresher(
                                header: refreshClassicHeader(context),
                                footer: refreshClassicFooter(context),
                                controller: refreshController,
                                onRefresh: () {
                                  BlocProvider.of<DailyBarsCubit>(context).getDailyBars(date, kApiKey);
                                  refreshController.refreshCompleted();
                                },
                                child: ListView.builder(
                                  itemCount: dailyBars.length > 19 ? 20 : dailyBars.length,
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(milliseconds: 375),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: CryptoItemWidget(
                                            crypto: dailyBars[index],
                                            onTap: () {
                                              context.router.push(AggregatesRoute(crypto: dailyBars[index]));
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
