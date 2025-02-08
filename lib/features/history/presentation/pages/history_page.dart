import 'package:a1_workspace/features/history/presentation/widgets/history_card_widget.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_state.dart';
import 'package:a1_workspace/features/login/presentation/widgets/app_button_w_idget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<HomeBloc>()
        .add(GetRecordsEvent()); // Отправляем событие для загрузки записей
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          "История",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "sf",
            color: AppColors.mainWhite,
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is GetRecordsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetRecordsSuccess) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 14, right: 14, top: 24),
                child: ListView.builder(
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    final record = state.records[index];
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
    );
  }
}
