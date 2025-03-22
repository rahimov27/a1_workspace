import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_state.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_record_card.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_service_card_widget.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_subtitle_widget.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_title_widget.dart';
import 'package:a1_workspace/features/service/presentation/pages/avtomoika_page.dart';
import 'package:a1_workspace/features/service/presentation/pages/care_plenka.dart';
import 'package:a1_workspace/features/service/presentation/pages/himchistka_page.dart';
import 'package:a1_workspace/features/service/presentation/pages/polirovka_page.dart';
import 'package:a1_workspace/features/service/presentation/pages/three_moika_page.dart';
import 'package:a1_workspace/features/service/presentation/pages/toner_page.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:a1_workspace/shared/utils/widgets/app_error_widget.dart';
import 'package:a1_workspace/shared/utils/widgets/app_loader_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    // Refresh function for the update application when the user is scrolling
    Future<void> onRefresh() async {
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      context.read<HomeBloc>().add(GetRecordsEvent());
    }

    // Provider for change theme
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

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
        onRefresh: onRefresh,
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
                      "Нет доступных записей",
                      style: TextStyle(
                          fontFamily: "sf-medium",
                          fontSize: 18,
                          color: isDarkMode
                              ? AppColors.mainWhite
                              : AppColors.mainGrey),
                    ),
                  );
                }
                var records = state.records.reversed.toList();
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
                          children: List.generate(
                            records.length > 2 ? 2 : records.length,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TonerPage()),
                                ),
                                child: SizedBox(
                                  height: 120,
                                  child: HomeServiceCardWidget(
                                    icon: "assets/svg/toner.svg",
                                    title: "Тонировка",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 13),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HimchistkaPage()),
                                ),
                                child: SizedBox(
                                  height: 120,
                                  child: HomeServiceCardWidget(
                                    icon: "assets/svg/himchistka.svg",
                                    title: "Химчистка",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PolirovkaPage()),
                                ),
                                child: SizedBox(
                                  height: 120,
                                  child: HomeServiceCardWidget(
                                    icon: "assets/svg/polirovka.svg",
                                    title: "Полировка",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 13),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ThreeMoikaPage()),
                                ),
                                child: SizedBox(
                                  height: 120,
                                  child: HomeServiceCardWidget(
                                    icon: "assets/svg/3-x-wash.svg",
                                    title: "3х фазная мойка",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AvtomoikaPage()),
                                ),
                                child: SizedBox(
                                  height: 120,
                                  child: HomeServiceCardWidget(
                                    icon: "assets/svg/himmoika.svg",
                                    title: "Автомойка",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 13),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CarePlenka()),
                                ),
                                child: SizedBox(
                                  height: 120,
                                  child: HomeServiceCardWidget(
                                    icon: "assets/svg/plenka.svg",
                                    title: "Защитная пленка",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
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
