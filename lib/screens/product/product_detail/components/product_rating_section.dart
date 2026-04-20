import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:flutter/material.dart';

class ProductRatingSection extends StatelessWidget {
  const ProductRatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    const totalReviews = 30;
    const score = 5.0;
    final distribution = <int, int>{5: 29, 4: 1, 3: 0, 2: 0, 1: 0};
    final experienceRatings = [
      _ExperienceRating(
        label: context.tr('productDetail.ratingPerformance'),
        score: 5.0,
        count: 25,
      ),
      _ExperienceRating(
        label: context.tr('productDetail.ratingBattery'),
        score: 5.0,
        count: 25,
      ),
      _ExperienceRating(
        label: context.tr('productDetail.ratingCameraQuality'),
        score: 5.0,
        count: 25,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppText(
                text: context.tr('productDetail.ratingTitle'),
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.gray900,
              ),
              const Spacer(),
              AppText(
                text: context.tr('productDetail.viewAll'),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.statusInfo,
              ),
              const SizedBox(width: 3),
              Icon(Icons.chevron_right, size: 13, color: AppColors.statusInfo),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: score.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gray900,
                            ),
                          ),
                          TextSpan(
                            text: '/5',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: AppColors.gray400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 1),
                    const _StarRow(starSize: 14),
                    const SizedBox(height: 3),
                    AppText(
                      text: context.tr(
                        'productDetail.ratingTotalReviews',
                        namedArgs: {'count': '$totalReviews'},
                      ),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray600,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 7),
              SizedBox(
                width: 105,
                height: 38,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                  ),
                  child: AppText(
                    text: context.tr('productDetail.writeReview'),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          for (int star = 5; star >= 1; star--) ...[
            _RatingDistributionRow(
              star: star,
              count: distribution[star] ?? 0,
              total: totalReviews,
            ),
            if (star > 1) const SizedBox(height: 4),
          ],
          const SizedBox(height: 11),
          AppText(
            text: context.tr('productDetail.ratingByExperience'),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.gray900,
          ),
          const SizedBox(height: 4),
          for (int i = 0; i < experienceRatings.length; i++) ...[
            _ExperienceRatingRow(data: experienceRatings[i]),
            if (i < experienceRatings.length - 1)
              Divider(height: 7, color: AppColors.gray200),
          ],
        ],
      ),
    );
  }
}

class _RatingDistributionRow extends StatelessWidget {
  const _RatingDistributionRow({
    required this.star,
    required this.count,
    required this.total,
  });

  final int star;
  final int count;
  final int total;

  @override
  Widget build(BuildContext context) {
    final ratio = total <= 0 ? 0.0 : (count / total).clamp(0.0, 1.0);
    return Row(
      children: [
        SizedBox(
          width: 20,
          child: Row(
            children: [
              AppText(
                text: '$star',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.gray700,
              ),
              const SizedBox(width: 1),
              Icon(Icons.star_rounded, color: AppColors.statusWarn, size: 10),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 6,
              backgroundColor: AppColors.gray200,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ),
        const SizedBox(width: 7),
        SizedBox(
          width: 62,
          child: AppText(
            text: context.tr(
              'productDetail.ratingCount',
              namedArgs: {'count': '$count'},
            ),
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.gray700,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}

class _ExperienceRating {
  const _ExperienceRating({
    required this.label,
    required this.score,
    required this.count,
  });

  final String label;
  final double score;
  final int count;
}

class _ExperienceRatingRow extends StatelessWidget {
  const _ExperienceRatingRow({required this.data});

  final _ExperienceRating data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: data.label,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.gray900,
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              const _StarRow(starSize: 13),
              const SizedBox(width: 6),
              AppText(
                text: '${data.score.toStringAsFixed(1)}/5',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.gray600,
              ),
              const SizedBox(width: 3),
              AppText(
                text: context.tr(
                  'productDetail.ratingCountWithParens',
                  namedArgs: {'count': '${data.count}'},
                ),
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.gray600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  const _StarRow({required this.starSize});

  final double starSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (_) => Icon(
          Icons.star_rounded,
          color: AppColors.statusWarn,
          size: starSize,
        ),
      ),
    );
  }
}
