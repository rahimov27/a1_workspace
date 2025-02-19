import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_state.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_record_card.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_service_card_widget.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_subtitle_widget.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_title_widget.dart';
import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/features/service/presentation/pages/service_page.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:a1_workspace/shared/utils/widgets/app_loader_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

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
                // Check if the records list is not empty
                if (state.records.isEmpty) {
                  return Center(
                    child: Text(
                      "Нет доступных записей.",
                      style: TextStyle(fontSize: 18, color: AppColors.mainGrey),
                    ),
                  );
                }

                var records =
                    state.records.reversed.toList(); // Reversed once here.
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
                        // Dynamically generate HomeRecordCards based on records.
                        Column(
                          children: List.generate(
                            records.length > 2
                                ? 2
                                : records
                                    .length, // Генерируем максимум 2 элемента
                            (index) => HomeRecordCard(
                              name: records[index].firstName,
                              number: records[index].phone,
                              service: records[index].service,
                              date: records[index].date,
                            ),
                          ),
                        ),
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
                return AppErrorWidget(
                  onPressed: () =>
                      context.read<HomeBloc>().add(GetRecordsEvent()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class AppErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const AppErrorWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment:
                Alignment.center, // Центрирует все элементы относительно центра
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: AppColors.mainRed.withOpacity(0.25),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.mainRed.withOpacity(0.40),
              ),
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.mainRed,
              ),
              Positioned(
                top: 58,
                left: 58,
                child: SvgPicture.asset("assets/svg/close.svg"),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Text(
                "Ошибка",
                style: TextStyle(
                  fontFamily: "sf-medium",
                  color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: 200,
                child: Text(
                  textAlign: TextAlign.center,
                  "Проверьте соединение с интернетом!",
                  style: TextStyle(
                    height: 1,
                    fontFamily: "sf-medium",
                    color: Color(0xff919191),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          AppButtonWidget(
            text: "Повторить",
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
