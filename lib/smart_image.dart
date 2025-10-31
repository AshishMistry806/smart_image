// ignore: unnecessary_library_name
library smart_image;

import 'dart:io';
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

  final String? semanticLabel;
  final String? tooltip;

  final double? height;
  final double? width;
  final double borderRadius;

  final BoxFit fit;
  final Color? backgroundColor;
  final Color? tintColor;
  final Color? textColor;

  final bool useNameAsFallback;
  final AvatarShape initialsShape;

  final LoadingAnimation loadingAnimation;
  final String? blurHash;

  final bool? isOnlineBadge;

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
    this.useNameAsFallback = false,
    this.initialsShape = AvatarShape.circle,
    this.loadingAnimation = LoadingAnimation.shimmer,
    this.blurHash,
    this.isOnlineBadge,
    this.errorWidget,
  });

  bool get _isNetwork => imageUrl.startsWith("http");
  bool get _isSvg => imageUrl.toLowerCase().endsWith(".svg");
  bool get _isFile => imageUrl.startsWith("/") || imageUrl.contains(":\\");
  bool get _isAsset => !(_isNetwork || _isFile);

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

    image = ClipRRect(
      borderRadius: initialsShape == AvatarShape.circle
          ? BorderRadius.circular(width != null ? width! / 2 : borderRadius)
          : BorderRadius.circular(borderRadius),
      child: image,
    );

    Widget finalWidget = Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      child: Semantics(
        label: semanticLabel,
        child: Tooltip(message: tooltip ?? name, child: image),
      ),
    );

    if (isOnlineBadge != null) {
      finalWidget = Stack(
        children: [
          finalWidget,
          Positioned(bottom: 4, right: 4, child: _statusBadge()),
        ],
      );
    }

    return finalWidget;
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

  Widget _statusBadge() => Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(
      color: isOnlineBadge == true ? Colors.green : Colors.grey,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2),
    ),
  );

  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(height: height, width: width, color: Colors.white),
    );
  }

  Widget _buildFallback() {
    if (useNameAsFallback && (name ?? "").trim().isNotEmpty) {
      return Container(
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
          name!.trim()[0].toUpperCase(),
          style: TextStyle(
            fontSize: 36,
            color: textColor ?? Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return errorWidget ??
        const Icon(Icons.broken_image_rounded, size: 40, color: Colors.grey);
  }
}
