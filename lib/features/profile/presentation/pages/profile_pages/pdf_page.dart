import 'dart:io';

import 'package:a1_workspace/shared/core/utils/swagger_adress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PdfPage extends StatefulWidget {
  final int month;
  final int year;

  const PdfPage({super.key, required this.month, required this.year});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  String? _pdfPath;
  bool _isLoading = true; // Флаг загрузки

  @override
  void initState() {
    super.initState();
    _downloadAndSavePdf();
  }

  Future<void> _downloadAndSavePdf() async {
    try {
      Dio dio = Dio();
      final url =
          'http://0.0.0.0:8000/api/report/?month=2&year=2025'; // Обновленный URL

      // Отправка GET-запроса для получения PDF
      Response<ResponseBody> response = await dio.get(
        url,
        options: Options(
          headers: {"Authorization": "1234567890abcdef"},
          responseType: ResponseType.stream,
        ),
      );

      if (response.statusCode == 200) {
        // Сохранение PDF-файла во временную папку
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/report.pdf';
        final file = File(filePath);

        List<int> byteData = [];
        await for (var chunk in response.data!.stream) {
          byteData.addAll(chunk);
        }

        await file.writeAsBytes(byteData);

        setState(() {
          _pdfPath = filePath;
          _isLoading = false; // Загружено, флаг на false
        });
      } else {
        print('Ошибка загрузки: ${response.statusCode}');
        setState(() {
          _isLoading = false; // Загружено, флаг на false
        });
      }
    } catch (e) {
      print('Ошибка: $e');
      setState(() {
        _isLoading = false; // Загружено, флаг на false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("PDF отчет за ${widget.month}/${widget.year}")),
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator() // Показываем индикатор загрузки
              : _pdfPath != null
                  ? PDFView(
                      filePath: _pdfPath,
                    )
                  : Text('Ошибка загрузки PDF'), // Если ошибка загрузки
        ),
      ),
    );
  }
}
