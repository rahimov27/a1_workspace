import 'dart:io';
import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:a1_workspace/shared/utils/widgets/app_loader_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  String? _pdfPath;
  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();

  Future<void> _downloadAndSavePdf() async {
    setState(() => _isLoading = true);
    try {
      Dio dio = Dio();
      final url =
          'https://a1-workspace-api.com/api/report/?month=${_selectedDate.month}&year=${_selectedDate.year}';

      Response<ResponseBody> response = await dio.get(
        url,
        options: Options(
          headers: {"Authorization": "1234567890abcdef"},
          responseType: ResponseType.stream,
        ),
      );

      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/report.pdf';
        final file = File(filePath);

        List<int> byteData = [];
        await for (var chunk in response.data!.stream) {
          byteData.addAll(chunk);
        }
        await file.writeAsBytes(byteData);

        setState(() => _pdfPath = filePath);
      } else {
        if (kDebugMode) {
          print('Ошибка загрузки: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка: $e');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  // ignore: deprecated_member_use
                  color: AppColors.mainGrey,
                ),
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Отчет",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "sf",
            color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.6, // Ограничение высоты
                child: _isLoading
                    ? Center(child: AppLoaderWidget())
                    : _pdfPath != null
                        ? PDFView(
                            filePath: _pdfPath,
                            enableSwipe: true,
                            swipeHorizontal: false,
                            autoSpacing: false,
                            pageFling: false,
                            pageSnap: false,
                            fitPolicy: FitPolicy.BOTH,
                          )
                        : Center(
                            child: Text(
                              "Выберите дату и нажмите 'Посмотреть отчет'",
                              style: TextStyle(
                                  fontFamily: "sf-medium",
                                  fontSize: 16,
                                  color: isDarkMode
                                      ? AppColors.mainWhite
                                      : AppColors.bottomNavbarGrey,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
              ),
              SizedBox(height: 16),
              Card(
                color: isDarkMode ? AppColors.mainGrey : AppColors.mainWhite,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: isDarkMode
                      ? SvgPicture.asset("assets/svg/calendar.svg")
                      : SvgPicture.asset(
                          "assets/svg/calendar.svg",
                          // ignore: deprecated_member_use
                          color: AppColors.mainGrey,
                        ),
                  title: Text(
                    "${_selectedDate.month}/${_selectedDate.year}",
                    style: TextStyle(
                        fontFamily: "sf-medium",
                        color: isDarkMode
                            ? AppColors.mainWhite
                            : AppColors.mainGrey),
                  ),
                  trailing: isDarkMode
                      ? SvgPicture.asset("assets/svg/arrow-down.svg")
                      : SvgPicture.asset(
                          "assets/svg/arrow-down.svg",
                          // ignore: deprecated_member_use
                          color: AppColors.mainGrey,
                        ),
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.monthYear,
                            onDateTimeChanged: (pickerDate) {
                              setState(() => _selectedDate = pickerDate);
                            },
                            initialDateTime: _selectedDate,
                            use24hFormat: true,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: AppButtonWidget(
                  fontsize: 16,
                  text: "Посмотреть отчет",
                  onPressed: _isLoading ? null : _downloadAndSavePdf,
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
