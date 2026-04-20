import 'package:ecommerce_app/screens/product/product_list/components/article.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/article/article_model.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({
    super.key,
    required this.articles,
    this.onArticleTap,
    this.onSeeAllTap,
  });

  final List<ArticleModel> articles;
  final ValueChanged<ArticleModel>? onArticleTap;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) return const SizedBox.shrink();
    final visibleArticles = articles.take(10).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(
                text: 'Tin tức liên quan',
                fontSize: 32 / 2,
                fontWeight: FontWeight.w700,
                color: AppColors.gray900,
              ),
            ),
            TextButton(
              onPressed: onSeeAllTap,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.statusInfo,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visibleArticles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.86,
          ),
          itemBuilder: (context, index) {
            final article = visibleArticles[index];
            return Article(
              article: article,
              onTap: () => onArticleTap?.call(article),
            );
          },
        ),
      ],
    );
  }
}
