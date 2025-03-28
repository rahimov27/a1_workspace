import 'package:a1_workspace/features/history/presentation/pages/edit_page.dart';
import 'package:a1_workspace/features/history/presentation/widgets/app_row_modal_widget.dart';
import 'package:a1_workspace/features/history/presentation/widgets/history_card_widget.dart';
import 'package:a1_workspace/features/history/presentation/widgets/history_title_w_idget.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_state.dart';
import 'package:a1_workspace/features/home/presentation/pages/home_page.dart';
import 'package:a1_workspace/shared/utils/widgets/app_error_widget.dart';
import 'package:a1_workspace/shared/utils/widgets/app_loader_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
        title: HistoryTitleWIdget(isDarkMode: isDarkMode),
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
                      final record = state.records.reversed.toList()[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22)),
                                elevation: 2,
                                contentPadding: const EdgeInsets.only(
                                    top: 16, bottom: 16, left: 8, right: 8),
                                backgroundColor: isDarkMode
                                    ? AppColors.mainGrey
                                    : AppColors.mainWhite,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.95,
                                      decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? AppColors.mainGrey
                                            : AppColors.mainWhite,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AppRowModalWidget(
                                            firstText: "ИМЯ",
                                            secondText: record.firstName,
                                            isDarkMode: isDarkMode,
                                          ),
                                          AppRowModalWidget(
                                            firstText: "ФАМИЛИЯ",
                                            secondText: record.lastName,
                                            isDarkMode: isDarkMode,
                                          ),
                                          AppRowModalWidget(
                                            firstText: "УСЛУГА",
                                            secondText: record.service,
                                            isDarkMode: isDarkMode,
                                          ),
                                          AppRowModalWidget(
                                            firstText: "ЦЕНА",
                                            secondText: record.price,
                                            isDarkMode: isDarkMode,
                                          ),
                                          AppRowModalWidget(
                                            firstText: "ДАТА",
                                            secondText: _formatDate(record
                                                .date), // Форматируем дату
                                            isDarkMode: isDarkMode,
                                          ),
                                          AppRowModalWidget(
                                            onTap: () => showCupertinoModalPopup(
                                                  context: context,
                                                  builder: (context) =>
                                                      CupertinoActionSheet(
                                                    actions: [
                                                      PendingSheetActionWidget(
                                                        text: "Ожидание",
                                                        color: AppColors
                                                            .mainYellow,
                                                        index: index,
                                                        status: "Ожидание",
                                                        record: record,
                                                      ),
                                                      PendingSheetActionWidget(
                                                        text: "В работе",
                                                        color: AppColors.green,
                                                        index: index,
                                                        status: "В работе",
                                                        record: record,
                                                      ),
                                                      PendingSheetActionWidget(
                                                        text: "Завершено",
                                                        color:
                                                            AppColors.mainRed,
                                                        index: index,
                                                        status: "Завершено",
                                                        record: record,
                                                      ),
                                                      PendingSheetActionWidget(
                                                        text: "Отменено",
                                                        color:
                                                            AppColors.greyAuth,
                                                        index: index,
                                                        status: "Отменено",
                                                        record: record,
                                                      ),
                                                      PendingSheetActionWidget(
                                                        text: "Нет оплаты",
                                                        color:
                                                            AppColors.greyAuth,
                                                        index: index,
                                                        status: "Нет оплаты",
                                                        record: record,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            firstText: "СТАТУС",
                                            secondText: {
                                                  "in_progress": "В работе",
                                                  "pending": "Ожидание",
                                                  "completed": "Завершено",
                                                  "cancelled": "Отменено",
                                                  "unpaid": "Нет оплаты",
                                                }[record.status] ??
                                                record.status,
                                            isDarkMode: isDarkMode,
                                            statusColor: {
                                                  "in_progress":
                                                      AppColors.green,
                                                  "pending": Color.fromARGB(
                                                      255, 199, 230, 1),
                                                  "completed":
                                                      AppColors.mainRed,
                                                  "cancelled":
                                                      AppColors.greyAuth,
                                                  "unpaid": AppColors.mainRed,
                                                }[record.status] ??
                                                Colors
                                                    .white, // По умолчанию белый
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Slidable(
                            startActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                SlidableAction(
                                  backgroundColor: AppColors.mainYellow,
                                  foregroundColor: AppColors.mainGrey,
                                  borderRadius: BorderRadius.circular(14),
                                  icon: Icons.edit,
                                  onPressed: (context) => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditPage(
                                          firstName: record.firstName,
                                          lastName: record.lastName,
                                          service: record.service,
                                          price: record.price,
                                          status: record.status,
                                          date: record.date,
                                          phone: record.phone,
                                          id: record.id,
                                        ),
                                      ),
                                    )
                                  },
                                )
                              ],
                            ),
                            endActionPane:
                                ActionPane(motion: BehindMotion(), children: [
                              SlidableAction(
                                backgroundColor: AppColors.mainRed,
                                foregroundColor: AppColors.mainWhite,
                                icon: Icons.delete,
                                borderRadius: BorderRadius.circular(14),
                                onPressed: (context) => {
                                  context
                                      .read<HomeBloc>()
                                      .add(DeleteRecordEvent(id: record.id)),
                                  context
                                      .read<HomeBloc>()
                                      .add(GetRecordsEvent())
                                },
                              )
                            ]),
                            child: HistoryCardWidget(
                              service: record.service,
                              name: "${record.firstName} ${record.lastName}",
                              price: record.price,
                              status: record.status,
                            ),
                          ),
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

  /// Функция форматирования даты
  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd.MM-HH:mm').format(date); // Например, 23.02.2025
    } catch (e) {
      return dateString; // Если ошибка, возвращаем оригинальный формат
    }
  }
}
