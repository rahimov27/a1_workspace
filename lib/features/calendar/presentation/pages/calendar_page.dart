import 'package:a1_workspace/features/calendar/data/models/meeting.dart';
import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:a1_workspace/features/calendar/presentation/widgets/calendar_title_widget.dart';
import 'package:a1_workspace/features/calendar/presentation/widgets/meeting_data_source.dart';
import 'package:a1_workspace/shared/utils/widgets/app_error_widget.dart';
import 'package:a1_workspace/shared/utils/widgets/app_loader_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    context.read<CalendarBloc>().add(GetRecordsCalendarEvent());
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: () {
                context.read<CalendarBloc>().add(GetRecordsCalendarEvent());
              },
              child: isDarkMode
                  ? SvgPicture.asset(
                      "assets/svg/refresh.svg",
                      width: 20,
                      height: 20,
                    )
                  : SvgPicture.asset(
                      "assets/svg/refresh-dark.svg",
                      width: 20,
                      height: 20,
                    ),
            ),
          ),
        ],
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: CalendarTitleWidget(isDarkMode: isDarkMode),
      ),
      body: SafeArea(
        child: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            if (state is GetRecordsCalendarLoading) {
              return const AppLoaderWidget();
            } else if (state is CalendarInitial) {
              return const AppLoaderWidget();
            } else if (state is GetRecordsCalendarSuccess) {
              return SfCalendar(
                minDate: DateTime(2024, 1, 1, 1),
                showDatePickerButton: false,
                headerDateFormat: "MMMM yyyy",
                todayTextStyle: TextStyle(
                    fontFamily: "sf",
                    fontSize: 20,
                    color:
                        isDarkMode ? AppColors.mainWhite : AppColors.mainGrey),
                todayHighlightColor: Colors.transparent,
                headerStyle: CalendarHeaderStyle(
                  backgroundColor:
                      isDarkMode ? Colors.transparent : Colors.transparent,
                  textStyle: TextStyle(
                      fontSize: 18,
                      color:
                          isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
                      fontFamily: "sf"),
                ),
                view: CalendarView.schedule,
                backgroundColor: isDarkMode
                    ? AppColors.scaffoldColor
                    : AppColors.scaffoldWhiteColor,
                scheduleViewSettings: ScheduleViewSettings(
                  appointmentItemHeight: 70,
                  monthHeaderSettings: MonthHeaderSettings(
                    monthTextStyle: TextStyle(
                        fontFamily: "sf",
                        fontSize: 18,
                        color: isDarkMode
                            ? AppColors.dateGrey
                            : AppColors.mainGrey),
                    textAlign: TextAlign.start,
                    height: 60,
                    backgroundColor: isDarkMode
                        ? AppColors.scaffoldColor
                        : AppColors.scaffoldWhiteColor,
                  ),
                  weekHeaderSettings: const WeekHeaderSettings(
                    startDateFormat: "",
                    height: 0,
                    endDateFormat: "",
                    weekTextStyle: TextStyle(fontFamily: "sf-medium"),
                    backgroundColor: Colors.transparent,
                  ),
                  dayHeaderSettings: DayHeaderSettings(
                    dayFormat: "MMM",
                    dateTextStyle: TextStyle(
                        color: isDarkMode
                            ? AppColors.mainWhite
                            : AppColors.mainGrey,
                        fontSize: 20,
                        fontFamily: "sf"),
                    dayTextStyle: const TextStyle(
                        color: AppColors.dateGrey,
                        fontFamily: "sf-medium",
                        fontSize: 14),
                  ),
                  appointmentTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                dataSource: MeetingDataSource(state.records),
                appointmentBuilder:
                    (BuildContext context, CalendarAppointmentDetails details) {
                  final Meeting meeting = details.appointments.first;
                  return Container(
                    decoration: BoxDecoration(
                      color: meeting.background,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meeting.eventName,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "sf",
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              "Запись в ${DateFormat.Hm().format(meeting.from)}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "sf-medium",
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return AppErrorWidget(
                onPressed: () =>
                    context.read<CalendarBloc>().add(GetRecordsCalendarEvent()),
              );
            }
          },
        ),
      ),
    );
  }
}
