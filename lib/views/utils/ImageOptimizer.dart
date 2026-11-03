import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageOptimizer {
  /// Laskee laitteen pikselisuhteella (devicePixelRatio) suojatun fyysisen pikselikoon.
  static int getCacheWidth(BuildContext context, double logicalWidth) {
    final double pixelRatio = MediaQuery.maybeOf(context)?.devicePixelRatio ?? 1.0;
    return (logicalWidth * pixelRatio).round();
  }

  // ==========================================
  // 1. PAIKALLISET ASSET-KUVAT
  // ==========================================

  /// Esilataa asset-kuvan muistiin optimoidussa koossa.
  static Future<void> precacheAsset(
      BuildContext context,
      String assetPath, {
        required double logicalWidth,
      }) {
    final int cacheWidth = getCacheWidth(context, logicalWidth);

    return precacheImage(
      ResizeImage.resizeIfNeeded(
        cacheWidth,
        null,
        AssetImage(assetPath),
      ),
      context,
    );
  }

  /// Palauttaa optimoidun Image.asset-widgetin.
  static Widget assetWidget(
      BuildContext context,
      String assetPath, {
        required double width,
        double? height,
        BoxFit fit = BoxFit.contain,
      }) {
    final int cacheWidth = getCacheWidth(context, width);

    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: cacheWidth,
    );
  }

  // ==========================================
  // 2. VERKKOKUVAT (CachedNetworkImage)
  // ==========================================

  /// Esilataa verkkokuvan muistiin optimoidussa koossa.
  /// Käytä tätä didChangeDependencies-metodissa.
  static Future<void> precacheNetwork(
      BuildContext context,
      String imageUrl, {
        required double logicalWidth,
      }) {
    final int cacheWidth = getCacheWidth(context, logicalWidth);

    return precacheImage(
      ResizeImage.resizeIfNeeded(
        cacheWidth,
        null,
        CachedNetworkImageProvider(
          imageUrl,
          // Pakotetaan provider purkamaan kuva välimuistiin oikeassa koossa:
          maxWidth: cacheWidth,
        ),
      ),
      context,
    );
  }

  /// Palauttaa optimoidun CachedNetworkImage-widgetin.
  static Widget networkWidget(
      BuildContext context,
      String imageUrl, {
        required double width,
        double? height,
        BoxFit fit = BoxFit.cover,
        Widget Function(BuildContext, String)? placeholder,
        Widget Function(BuildContext, String, dynamic)? errorWidget,
      }) {
    final int cacheWidth = getCacheWidth(context, width);

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      // Tämän parametrin ansiosta widget osuu täydellisesti esiladattuun kokoon:
      memCacheWidth: cacheWidth,
      maxWidthDiskCache: cacheWidth,
      placeholder: placeholder ?? (context, url) => Container(color: Colors.grey[200]),
      errorWidget: errorWidget ?? (context, url, error) => const Icon(Icons.error),
    );
  }
}
