import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:flutter/material.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  static const List<String> _questions = [
    'Có nên mua điện thoại trả góp không? Lợi ích và rủi ro?',
    'Nên mua iPhone hay điện thoại Android? Ưu nhược điểm của từng loại?',
    'Điện thoại nào có pin "trâu" nhất, dùng được lâu nhất',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(
                text: 'Câu hỏi thường gặp',
                fontSize: 24 / 2,
                fontWeight: FontWeight.w700,
                color: AppColors.gray900,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: AppColors.statusInfo,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              ),
              child: Row(
                children: const [
                  Text('Xem tất cả'),
                  SizedBox(width: 2),
                  Icon(Icons.chevron_right_rounded, size: 18),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (final question in _questions) ...[
          _FaqQuestionCard(question: question),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          decoration: BoxDecoration(
            color: AppColors.gray100.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.gray200),
                    ),
                    child: Icon(
                      Icons.support_agent_rounded,
                      color: AppColors.statusError,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppText(
                      text: 'Hãy đặt câu hỏi cho chúng tôi',
                      fontSize: 24 / 2,
                      fontWeight: FontWeight.w700,
                      color: AppColors.gray900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AppText(
                text:
                    'CellphoneS sẽ phản hồi trong vòng 1 giờ. Nếu Quý khách gửi câu hỏi sau 22h, chúng tôi sẽ trả lời vào sáng hôm sau. Thông tin có thể thay đổi theo thời gian, vui lòng đặt câu hỏi để nhận được cập nhật mới nhất!',
                fontSize: 31 / 2,
                fontWeight: FontWeight.w500,
                color: AppColors.gray700,
                maxLines: 5,
              ),
              const SizedBox(height: 14),
              AppButton(
                text: 'Gửi câu hỏi',
                onTap: () {},
                color: AppColors.statusError,
                borderRadius: 14,
                height: 56,
                fontSize: 18 / 1.05,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FaqQuestionCard extends StatelessWidget {
  const _FaqQuestionCard({required this.question});

  final String question;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
          decoration: BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppText(
                  text: question,
                  fontSize: 30 / 2,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray900,
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.gray700,
                size: 34,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
