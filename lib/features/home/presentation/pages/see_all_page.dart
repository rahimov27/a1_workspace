import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_state.dart';
import 'package:a1_workspace/features/home/presentation/pages/home_page.dart';
import 'package:a1_workspace/features/home/presentation/widgets/home_record_card.dart';
import 'package:a1_workspace/shared/app_loader_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SeeAllPage extends StatefulWidget {
  const SeeAllPage({super.key});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    context.read<HomeBloc>().add(GetRecordsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 44,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset("assets/svg/arrow-left.svg"),
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          "Записи",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "sf",
            color: AppColors.mainWhite,
          ),
        ),
      ),
      body: CustomMaterialIndicator(
        backgroundColor: AppColors.mainGrey,
        indicatorBuilder: (context, controller) =>
            LoadingAnimationWidget.inkDrop(color: AppColors.mainRed, size: 35),
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
                    return const Center(
                      child: AppLoaderWidget(),
                    );
                  } else if (state is GetRecordsSuccess) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.records.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: HomeRecordCard(
                                name: state.records.reversed
                                    .toList()[index]
                                    .firstName,
                                number: state.records.reversed
                                    .toList()[index]
                                    .phone,
                                service: state.records.reversed
                                    .toList()[index]
                                    .service,
                                date: state.records.reversed
                                    .toList()[index]
                                    .date),
                          );
                        },
                      ),
                    );
                  } else if (state is GetRecordsError) {
                    return const AppErrorWidget();
                  }
                  return const AppErrorWidget();
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
