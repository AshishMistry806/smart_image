// ignore: unnecessary_library_name
// ignore: unnecessary_library_name
library smart_image;

import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

enum LoadingAnimation { shimmer, fadeIn, blurhash }

enum AvatarShape { circle, rounded }

class SmartImage extends StatelessWidget {
  final String imageUrl;
  final String? name;

  // Accessibility
  final String? semanticLabel;
  final String? tooltip;

  // Dimensions
  final double? height;
  final double? width;
  final double borderRadius;

  // Styles
  final BoxFit fit;
  final Color? backgroundColor;
  final Color? tintColor;
  final Color? textColor;

  // NEW: initials text style (dynamic)
  final TextStyle? initialsTextStyle;

  // ✅ NEW: dynamic padding
  final EdgeInsetsGeometry? padding;

  final bool useNameAsFallback;
  final AvatarShape initialsShape;

  final LoadingAnimation loadingAnimation;
  final String? blurHash;

  final Widget? errorWidget;

  const SmartImage({
    super.key,
    this.imageUrl = "",
    this.name,
    this.semanticLabel,
    this.tooltip,
    this.height,
    this.width,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.tintColor,
    this.textColor,
    this.initialsTextStyle,
    this.padding,
    this.useNameAsFallback = false,
    this.initialsShape = AvatarShape.circle,
    this.loadingAnimation = LoadingAnimation.shimmer,
    this.blurHash,
    this.errorWidget,
  });

  bool get _isNetwork => imageUrl.startsWith("http");
  bool get _isSvg => imageUrl.toLowerCase().endsWith(".svg");
  bool get _isFile => imageUrl.startsWith("/") || imageUrl.contains(":\\");
  bool get _isAsset => !(_isNetwork || _isFile);

  double _minSide() => min(height ?? width ?? 48.0, width ?? height ?? 48.0);

  @override
  Widget build(BuildContext context) {
    Widget image = _buildFallback();

    if (imageUrl.isNotEmpty) {
      if (_isNetwork) {
        image = _networkImage();
      } else if (_isSvg) {
        image = SvgPicture.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          colorFilter: tintColor != null
              ? ColorFilter.mode(tintColor!, BlendMode.srcIn)
              : null,
        );
      } else if (_isFile) {
        image = Image.file(
          File(imageUrl),
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => _buildFallback(),
        );
      } else if (_isAsset) {
        image = Image.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          color: tintColor,
          errorBuilder: (_, __, ___) => _buildFallback(),
        );
      }
    }

    return ClipRRect(
      borderRadius: initialsShape == AvatarShape.circle
          ? BorderRadius.circular((width ?? height ?? 48) / 2)
          : BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        color: backgroundColor,
        child: Semantics(
          label: semanticLabel,
          child: Tooltip(
            message: tooltip ?? name ?? "",
            child: _applyPadding(image), // ✅ padding applied here
          ),
        ),
      ),
    );
  }

  Widget _networkImage() {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: imageUrl,
      height: height,
      width: width,
      fadeInDuration: loadingAnimation == LoadingAnimation.fadeIn
          ? const Duration(milliseconds: 300)
          : Duration.zero,
      placeholder: (_, __) {
        switch (loadingAnimation) {
          case LoadingAnimation.shimmer:
            return _shimmer();
          case LoadingAnimation.blurhash:
            return blurHash != null && blurHash!.isNotEmpty
                ? BlurHash(hash: blurHash!, imageFit: fit)
                : _shimmer();
          case LoadingAnimation.fadeIn:
            return const SizedBox();
        }
      },
      errorWidget: (_, __, ___) => _buildFallback(),
    );
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(height: height, width: width, color: Colors.white),
    );
  }

  Widget _applyPadding(Widget child) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );
  }

  Widget _buildFallback() {
    final bool showInitials =
        useNameAsFallback && (name ?? "").trim().isNotEmpty;

    if (showInitials) {
      final cleaned = name!.trim();
      final parts = cleaned.split(RegExp(r'\s+'));
      final String initials = parts.length >= 2
          ? (parts.first[0] + parts.last[0]).toUpperCase()
          : cleaned[0].toUpperCase();

      double computedSize = (_minSide()) * 0.40;
      final TextStyle baseStyle = initialsTextStyle ??
          TextStyle(
            fontSize: computedSize,
            fontWeight: FontWeight.w700,
            color: textColor ?? Colors.black,
          );

      final double finalFontSize = baseStyle.fontSize ?? computedSize;
      final TextStyle finalStyle = baseStyle.copyWith(
        fontSize: finalFontSize,
        color: baseStyle.color ?? textColor ?? Colors.black,
      );

      return _applyPadding(
        // ✅ padding applied inside fallback too
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.grey.shade300,
            shape: initialsShape == AvatarShape.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
            borderRadius: initialsShape == AvatarShape.rounded
                ? BorderRadius.circular(borderRadius)
                : null,
          ),
          child: AutoSizeText(
            initials,
            maxLines: 1,
            minFontSize: 2,
            maxFontSize: finalFontSize,
            style: finalStyle,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return _applyPadding(
      // ✅ also apply padding to errorWidget/icon
      errorWidget ??
          const Icon(Icons.broken_image_rounded, size: 40, color: Colors.grey),
    );
  }
}
