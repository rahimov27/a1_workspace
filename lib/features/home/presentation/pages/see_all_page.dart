import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_state.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_record_card.dart';
import 'package:a1_workspace/features/home/presentation/widgets/see_all_page_title.dart';
import 'package:a1_workspace/shared/utils/widgets/app_error_widget.dart';
import 'package:a1_workspace/shared/utils/widgets/app_loader_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SeeAllPage extends StatefulWidget {
  const SeeAllPage({super.key});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  // Function for the refresh the screen
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    context.read<HomeBloc>().add(GetRecordsEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Theme provider for change the theme
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 44,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: isDarkMode
              ? SvgPicture.asset("assets/svg/arrow-left.svg")
              : SvgPicture.asset(
                  "assets/svg/arrow-left.svg",
                  color: AppColors.mainGrey,
                ),
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: SeeAllPageTitle(isDarkMode: isDarkMode),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is DeleteRecordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<HomeBloc>().add(GetRecordsEvent()); // Refresh records
          } else if (state is DeleteRecordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text("Ошибка при удалении записи ${state.error}")),
            );
          }
        },
        child: CustomMaterialIndicator(
          backgroundColor: AppColors.mainGrey,
          indicatorBuilder: (context, controller) =>
              LoadingAnimationWidget.inkDrop(
                  color: AppColors.mainRed, size: 35),
          onRefresh: _onRefresh,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                const SizedBox(height: 24),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is GetRecordsLoading) {
                      return const Center(child: AppLoaderWidget());
                    } else if (state is GetRecordsSuccess) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.records.length,
                          itemBuilder: (context, index) {
                            final record =
                                state.records.reversed.toList()[index];
                            return GestureDetector(
                              onLongPress: () {
                                context.read<HomeBloc>().add(
                                      DeleteRecordEvent(id: record.id),
                                    );
                              },
                              child: HomeRecordCard(
                                name: record.firstName,
                                number: record.phone,
                                service: record.service,
                                date: record.date,
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is GetRecordsError) {
                      return AppErrorWidget(
                        onPressed: () =>
                            context.read<HomeBloc>().add(GetRecordsEvent()),
                      );
                    }
                    return const Center(child: AppLoaderWidget());
                  },
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
