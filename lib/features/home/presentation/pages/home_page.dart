import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_state.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_record_card.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_service_card_widget.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_subtitle_widget.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_title_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/app_button_w_idget.dart';
import 'package:a1_workspace/features/service/presentation/pages/service_page.dart';
import 'package:a1_workspace/shared/app_loader_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetRecordsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final icons = [
      "assets/svg/toner.svg",
      "assets/svg/himchistka.svg",
      "assets/svg/3-x-wash.svg",
      "assets/svg/polirovka.svg",
      "assets/svg/plenka.svg",
      "assets/svg/himmoika.svg"
    ];

    final titles = [
      "Тонировка",
      "Химчистка",
      "Автомойка",
      "Полировка",
      "Защитная пленка",
      "3-х Мойка"
    ];

    Future<void> _onRefresh() async {
      await Future.delayed(const Duration(seconds: 1));
      context.read<HomeBloc>().add(GetRecordsEvent());
    }

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: const HomeTitleWidget(),
      ),
      body: CustomMaterialIndicator(
        backgroundColor: AppColors.mainGrey,
        indicatorBuilder: (context, controller) =>
            LoadingAnimationWidget.inkDrop(color: AppColors.mainRed, size: 35),
        onRefresh: _onRefresh,
        child: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is GetRecordsLoading) {
                return const AppLoaderWidget();
              } else if (state is GetRecordsSuccess) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 34),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HomeSubtitleWidget(
                          title: "Записи",
                          hasButton: true,
                        ),
                        const SizedBox(height: 14),
                        Column(
                          children: [
                            HomeRecordCard(
                              name:
                                  state.records.reversed.toList()[0].firstName,
                              number: state.records.reversed.toList()[0].phone,
                              service:
                                  state.records.reversed.toList()[0].service,
                              date: state.records.reversed.toList()[0].date,
                            ),
                            const SizedBox(height: 8),
                            HomeRecordCard(
                              name:
                                  state.records.reversed.toList()[1].firstName,
                              number: state.records.reversed.toList()[1].phone,
                              service:
                                  state.records.reversed.toList()[1].service,
                              date: state.records.reversed.toList()[1].date,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 30),
                        const HomeSubtitleWidget(
                          title: "Услуги",
                          hasButton: false,
                        ),
                        const SizedBox(height: 14),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 3.5 / 2,
                          ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ServicePage(),
                                ),
                              ),
                              child: HomeServiceCardWidget(
                                icon: icons[index],
                                title: titles[index],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      const Text(
                        "No internet",
                        style: TextStyle(
                          fontFamily: "sf",
                          color: AppColors.mainWhite,
                          fontSize: 24,
                        ),
                      ),
                      const Spacer(),
                      AppButtonWidget(
                        text: "Повторить",
                        onPressed: () {
                          context.read<HomeBloc>().add(GetRecordsEvent());
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
