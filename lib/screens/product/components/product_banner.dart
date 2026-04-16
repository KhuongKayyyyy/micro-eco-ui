import 'package:flutter/material.dart';

class ProductBanner extends StatefulWidget {
  const ProductBanner({
    super.key,
    required this.imageUrls,
    this.height = 70,
    this.borderRadius = 12,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 2),
    this.onTap,
  });

  final List<String> imageUrls;
  final double height;
  final double borderRadius;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final ValueChanged<int>? onTap;

  @override
  State<ProductBanner> createState() => _ProductBannerState();
}

class _ProductBannerState extends State<ProductBanner> {
  late final PageController _pageController;
  int _currentPage = 0;
  bool _autoPlayRunning = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlayIfNeeded();
  }

  @override
  void didUpdateWidget(covariant ProductBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.autoPlay != widget.autoPlay ||
        oldWidget.imageUrls.length != widget.imageUrls.length ||
        oldWidget.autoPlayInterval != widget.autoPlayInterval) {
      _autoPlayRunning = false;
      _startAutoPlayIfNeeded();
    }
  }

  Future<void> _startAutoPlayIfNeeded() async {
    if (!widget.autoPlay || widget.imageUrls.length <= 1 || _autoPlayRunning) {
      return;
    }

    _autoPlayRunning = true;
    while (mounted && widget.autoPlay && widget.imageUrls.length > 1) {
      await Future<void>.delayed(widget.autoPlayInterval);
      if (!mounted || !_autoPlayRunning) break;

      final next = (_currentPage + 1) % widget.imageUrls.length;
      await _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _autoPlayRunning = false;
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      );
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: SizedBox(
            height: widget.height,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.imageUrls.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                final url = widget.imageUrls[index];
                return InkWell(
                  onTap: () => widget.onTap?.call(index),
                  child: Image.network(
                    url,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFF5F5F5),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: const Color(0xFFF5F5F5),
                        alignment: Alignment.center,
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
        if (widget.imageUrls.length > 1) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (index) {
              final isActive = _currentPage == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: isActive ? 20 : 10,
                height: 4,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFE3003A)
                      : const Color(0xFFD3D8DF),
                  borderRadius: BorderRadius.circular(999),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}
