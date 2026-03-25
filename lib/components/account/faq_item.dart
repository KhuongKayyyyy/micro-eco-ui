import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/model/faq_model.dart';
import 'package:flutter/material.dart';

class FaqItem extends StatefulWidget {
  final FaqModel faq;

  const FaqItem({super.key, required this.faq});

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final question = widget.faq.question;
    final answer = widget.faq.answer;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDEDED), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 16, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppText(
                      text: question,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 26,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: _isExpanded
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                    child: AppText(
                      text: answer,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8B8B8B),
                      height: 1.35,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
