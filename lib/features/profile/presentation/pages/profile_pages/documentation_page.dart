import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:provider/provider.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage({super.key});

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
          "Документация",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "sf",
            color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
          ),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: DocumentationContent(),
        ),
      ),
    );
  }
}

class DocumentationContent extends StatelessWidget {
  const DocumentationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 24),
          DocumentationSection(
            title: "Правила и условия обслуживания",
            content:
                "Описание услуг, их стоимость, гарантии и условия оказания.",
          ),
          DocumentationSection(
            title: "Часто задаваемые вопросы (FAQ)",
            content:
                "Ответы на часто задаваемые вопросы по использованию приложения и предоставляемым услугам.",
          ),
          DocumentationSection(
            title: "Политика конфиденциальности",
            content: "Как мы храним и обрабатываем персональные данные.",
          ),
          DocumentationSection(
            title: "Техническая поддержка",
            content: "Как связаться с техподдержкой в случае проблем.",
          ),
        ],
      ),
    );
  }
}

class DocumentationSection extends StatefulWidget {
  final String title;
  final String content;

  const DocumentationSection(
      {super.key, required this.title, required this.content});

  @override
  // ignore: library_private_types_in_public_api
  _DocumentationSectionState createState() => _DocumentationSectionState();
}

class _DocumentationSectionState extends State<DocumentationSection>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      if (isExpanded) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleExpand,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: isDarkMode ? AppColors.mainGrey : AppColors.mainWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    child: Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "sf-medium",
                        color: isDarkMode
                            ? AppColors.mainWhite
                            : AppColors.mainGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: isDarkMode
                          ? SvgPicture.asset("assets/svg/arrow-down.svg")
                          : SvgPicture.asset(
                              "assets/svg/arrow-down.svg",
                              // ignore: deprecated_member_use
                              color: AppColors.mainGrey,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ClipRect(
          child: SizeTransition(
            sizeFactor: _expandAnimation,
            axisAlignment: -1.0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: isDarkMode ? AppColors.mainGrey : AppColors.mainWhite,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                  child: Text(
                    widget.content,
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
