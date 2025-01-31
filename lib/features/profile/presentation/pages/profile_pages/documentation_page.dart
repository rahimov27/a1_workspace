import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          padding: EdgeInsets.all(16),
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Документация по приложению",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.mainWhite,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Нажмите на раздел, чтобы увидеть подробную информацию.",
          style: TextStyle(fontSize: 16, color: AppColors.mainWhite),
        ),
        SizedBox(height: 20),
        DocumentationSection(
          title: "Правила и условия обслуживания",
          content: "Описание услуг, их стоимость, гарантии и условия оказания.",
        ),
        DocumentationSection(
          title: "Часто задаваемые вопросы (FAQ)",
          content:
              "Ответы на часто задаваемые вопросы по использованию приложения и предоставляемым услугам.",
        ),
        DocumentationSection(
          title: "Часто задаваемые вопросы",
          content: "Ответы на часто задаваемые вопросы пользователей.",
        ),
        DocumentationSection(
          title: "Техническая поддержка",
          content: "Как связаться с техподдержкой в случае проблем.",
        ),
      ],
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

class _DocumentationSectionState extends State<DocumentationSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.mainGrey),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "sf-medium",
                        color: AppColors.mainWhite,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: isExpanded
                        ? SvgPicture.asset("assets/svg/arrow-up.svg")
                        : SvgPicture.asset("assets/svg/arrow-down.svg"),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.mainGrey),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                child: Text(
                  widget.content,
                  style:
                      const TextStyle(fontSize: 16, color: AppColors.mainWhite),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
