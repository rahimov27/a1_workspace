import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage({super.key});

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
          "Документация",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "sf",
            color: AppColors.mainWhite,
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
                color: AppColors.mainGrey,
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "sf-medium",
                        color: AppColors.mainWhite,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: SvgPicture.asset("assets/svg/arrow-down.svg"),
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
                  color: AppColors.mainGrey,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                  child: Text(
                    widget.content,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(185, 255, 255, 255)),
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
