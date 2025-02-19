import 'package:a1_workspace/features/history/presentation/widgets/history_card_widget.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_state.dart';
import 'package:a1_workspace/shared/utils/widgets/app_error_widget.dart';
import 'package:a1_workspace/shared/utils/widgets/app_loader_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetRecordsEvent());
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    // ignore: use_build_context_synchronously
    context.read<HomeBloc>().add(GetRecordsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "История",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "sf",
            color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is GetRecordsLoading) {
            return const AppLoaderWidget();
          } else if (state is GetRecordsSuccess) {
            return CustomMaterialIndicator(
              backgroundColor: AppColors.mainGrey,
              indicatorBuilder: (context, controller) =>
                  LoadingAnimationWidget.inkDrop(
                      color: AppColors.mainRed, size: 35),
              onRefresh: _onRefresh,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 24),
                  child: ListView.builder(
                    itemCount: state.records.length,
                    itemBuilder: (context, index) {
                      // Используем reversed для инвертирования порядка записей
                      final record = state.records.reversed.toList()[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: HistoryCardWidget(
                          service: record.service,
                          name: "${record.firstName} ${record.lastName}",
                          price: record.price,
                          status: record.status,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return AppErrorWidget(
              onPressed: () => context.read<HomeBloc>().add(GetRecordsEvent()),
            );
          }
        },
      ),
    );
  }
}
