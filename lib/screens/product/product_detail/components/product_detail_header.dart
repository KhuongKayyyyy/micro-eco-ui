import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/product/product_detail_model.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProductDetailHeader extends StatefulWidget {
  const ProductDetailHeader({
    super.key,
    required this.detail,
    this.selectedColorImage,
  });

  final ProductDetailModel detail;
  final String? selectedColorImage;

  @override
  State<ProductDetailHeader> createState() => _ProductDetailHeaderState();
}

class _ProductDetailHeaderState extends State<ProductDetailHeader> {
  static const int _videoSelection = -1;

  int _selectedItem = 0;
  String? _activeImage;
  String? _selectedYoutubeVideoId;
  YoutubePlayerController? _youtubeController;

  List<String> get _images => widget.detail.images;

  bool get _isVideoSelected => _selectedItem == _videoSelection;

  int get _safeImageIndex {
    if (_images.isEmpty) return 0;
    final idx = _selectedItem < 0 ? 0 : _selectedItem;
    if (idx >= _images.length) return 0;
    return idx;
  }

  @override
  void initState() {
    super.initState();
    _activeImage = _defaultImageFromColorOrGallery();
    if (_images.isEmpty) {
      _selectedItem = _videoSelection;
    }
  }

  @override
  void didUpdateWidget(covariant ProductDetailHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.detail.id != widget.detail.id) {
      _selectedItem = 0;
      _activeImage = _defaultImageFromColorOrGallery();
      _selectedYoutubeVideoId = null;
      _youtubeController?.dispose();
      _youtubeController = null;
      return;
    }

    if (oldWidget.selectedColorImage != widget.selectedColorImage) {
      final newColorImage = widget.selectedColorImage?.trim() ?? '';
      if (newColorImage.isNotEmpty) {
        _activeImage = newColorImage;
        final matchedIndex = _images.indexOf(newColorImage);
        if (matchedIndex >= 0) {
          _selectedItem = matchedIndex;
        }
      } else if (_activeImage == null || _activeImage!.trim().isEmpty) {
        _activeImage = _defaultImageFromColorOrGallery();
      }
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  void _nextImage() {
    if (_images.isEmpty) return;
    setState(() {
      final current = _safeImageIndex;
      final next = (current + 1) % _images.length;
      _selectedItem = next;
      _activeImage = _images[next];
    });
  }

  void _prevImage() {
    if (_images.isEmpty) return;
    setState(() {
      final current = _safeImageIndex;
      final prev = (current - 1 + _images.length) % _images.length;
      _selectedItem = prev;
      _activeImage = _images[prev];
    });
  }

  void _showVideoInsideFrame(BuildContext context) {
    final raw = widget.detail.videoUrl?.trim() ?? '';
    if (raw.isEmpty) {
      Get.snackbar(
        context.tr('productDetail.noticeTitle'),
        context.tr('productDetail.noVideo'),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final videoId = _youtubeVideoId(raw);
    if (videoId == null || videoId.isEmpty) {
      Get.snackbar(
        context.tr('productDetail.noticeTitle'),
        context.tr('productDetail.invalidYoutubeLink'),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _youtubeController?.dispose();
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
      ),
    );
    setState(() {
      _selectedYoutubeVideoId = videoId;
      _selectedItem = _videoSelection;
    });
  }

  String? _youtubeVideoId(String rawUrl) {
    final uri = Uri.tryParse(rawUrl);
    if (uri == null) return null;

    String? id;
    if (uri.host.contains('youtu.be')) {
      id = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    } else if (uri.host.contains('youtube.com')) {
      id = uri.queryParameters['v'];
      if ((id == null || id.isEmpty) && uri.pathSegments.isNotEmpty) {
        final first = uri.pathSegments.first;
        if (first == 'shorts' && uri.pathSegments.length > 1) {
          id = uri.pathSegments[1];
        } else if (first == 'embed' && uri.pathSegments.length > 1) {
          id = uri.pathSegments[1];
        }
      }
    }

    if (id == null || id.trim().isEmpty) return null;
    return id.trim();
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = _images.isNotEmpty;
    final currentImage = _activeImage?.trim() ?? '';
    final reviewCount = _mockReviewCount(widget.detail.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 189,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: AppColors.gray200),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: _isVideoSelected && _selectedYoutubeVideoId != null
                      ? YoutubePlayer(
                          key: ValueKey(_selectedYoutubeVideoId),
                          controller: _youtubeController!,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: AppColors.primary,
                        )
                      : hasImage
                      ? Image.network(
                          currentImage,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => Icon(
                            Icons.image_not_supported_outlined,
                            size: 27,
                            color: AppColors.gray500,
                          ),
                        )
                      : Icon(
                          Icons.image_not_supported_outlined,
                          size: 27,
                          color: AppColors.gray500,
                        ),
                ),
              ),
              Positioned(
                left: 7,
                child: _ArrowButton(
                  icon: Icons.chevron_left,
                  onTap: _prevImage,
                ),
              ),
              Positioned(
                right: 7,
                child: _ArrowButton(
                  icon: Icons.chevron_right,
                  onTap: _nextImage,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        SizedBox(
          height: 43,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _OptionTile(
                icon: Icons.ondemand_video_outlined,
                text: context.tr('productDetail.video'),
                selected: _isVideoSelected,
                onTap: () => _showVideoInsideFrame(context),
              ),
              const SizedBox(width: 6),
              _OptionTile(
                icon: Icons.star_border_rounded,
                text: context.tr('productDetail.features'),
                selected: !_isVideoSelected,
                onTap: () => setState(() {
                  _selectedItem = _safeImageIndex;
                  if (hasImage) {
                    _activeImage = _images[_safeImageIndex];
                  }
                }),
              ),
              const SizedBox(width: 6),
              for (int i = 0; i < _images.length && i < 8; i++) ...[
                _ThumbTile(
                  image: _images[i],
                  selected: !_isVideoSelected && i == _safeImageIndex,
                  onTap: () => setState(() {
                    _selectedItem = i;
                    _activeImage = _images[i];
                  }),
                ),
                const SizedBox(width: 6),
              ],
            ],
          ),
        ),
        const SizedBox(height: 7),
        AppText(
          text: widget.detail.name,
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: AppColors.gray900,
          maxLines: 2,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.star_rounded, color: Color(0xFFF4B400), size: 17),
            const SizedBox(width: 4),
            AppText(
              text: '5.0',
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppColors.gray900,
            ),
            const SizedBox(width: 6),
            AppText(
              text: context.tr(
                'productDetail.reviewCount',
                namedArgs: {'count': '$reviewCount'},
              ),
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.gray600,
            ),
          ],
        ),
        const SizedBox(height: 6),
        const _HeaderActionRow(),
      ],
    );
  }

  int _mockReviewCount(String seed) {
    final value = seed.trim().isEmpty
        ? DateTime.now().millisecond
        : seed.codeUnits.fold<int>(0, (a, b) => a + b);
    return (value % 80) + 20;
  }

  String? _defaultImageFromColorOrGallery() {
    final colorImage = widget.selectedColorImage?.trim() ?? '';
    if (colorImage.isNotEmpty) return colorImage;
    if (_images.isNotEmpty) return _images.first;
    return null;
  }
}

class _HeaderActionRow extends StatelessWidget {
  const _HeaderActionRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _HeaderActionItem(
          icon: Icons.favorite_border_rounded,
          text: context.tr('productDetail.favorite'),
        ),
        const _HeaderActionDivider(),
        _HeaderActionItem(
          icon: Icons.chat_bubble_outline_rounded,
          text: context.tr('productDetail.qna'),
        ),
        const _HeaderActionDivider(),
        _HeaderActionItem(
          icon: Icons.tune_rounded,
          text: context.tr('productDetail.specs'),
        ),
      ],
    );
  }
}

class _HeaderActionItem extends StatelessWidget {
  const _HeaderActionItem({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 17, color: AppColors.statusInfo),
          const SizedBox(width: 3),
          AppText(
            text: text,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.statusInfo,
          ),
        ],
      ),
    );
  }
}

class _HeaderActionDivider extends StatelessWidget {
  const _HeaderActionDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 20, color: AppColors.gray300);
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.94),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.gray200),
        ),
        child: Icon(icon, size: 14, color: AppColors.gray900),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.text,
    required this.selected,
    this.onTap,
  });

  final IconData icon;
  final String text;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.statusInfo : AppColors.gray200,
            width: selected ? 2 : 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.gray900),
            const SizedBox(height: 1),
            AppText(
              text: text,
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: AppColors.gray900,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThumbTile extends StatelessWidget {
  const _ThumbTile({required this.image, required this.selected, this.onTap});

  final String image;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.statusInfo : AppColors.gray200,
            width: selected ? 2 : 1.2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.gray500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
