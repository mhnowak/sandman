import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class SMNetworkImage extends StatelessWidget {
  const SMNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
