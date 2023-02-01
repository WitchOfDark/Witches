import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_blurhash/flutter_blurhash.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../decoration.dart';
import '../primitive.dart';

T getOne<T>(List<T> l) {
  return l[Random().nextInt(l.length)];
}

List<String> blurHashes = [
  'LOHTN|}wItIq~B^PnTNKo{tPs;s;',
  'L8DIL;5M00xITjx04m-r02WV~WNX',
  'LbDm,SMwITxv~VM|Ips-?cRjRPoz',
  'L17AxV\$%100#}W4pKO9b.7t7-V9]',
  'LO6Iw9tVp0RNOxS,a\$ngVqtTV?XA',
  'L7Db:6T24T}U00-r.A9Y}U{v;eF|',
];

class CustomCacheImage extends StatelessWidget {
  const CustomCacheImage(
      {Key? key, required this.imageUrl, this.blurHash, this.radius = 0, this.deco})
      : super(key: key);

  final String imageUrl;
  final String? blurHash;
  final double radius;
  final Deco? deco;

  @override
  Widget build(BuildContext context) {
    return box(
      deco: deco,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Container(
            color: Colors.white,
            child: Center(
              child: kDebugMode
                  ? Text(error.toString())
                  : const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
            ),
          ),
          progressIndicatorBuilder: (context, url, DownloadProgress progress) {
            return Container(
              color: Colors.black,
              child: Stack(
                children: [
                  BlurHash(hash: (blurHash != null) ? blurHash! : getOne(blurHashes)),
                  Center(
                    child: CircularProgressIndicator(
                      value: progress.progress ?? 1,
                    ),
                  ),
                ],
              ),
            ).animate(
              onPlay: (controller) {
                controller.repeat();
              },
            ).shimmer(
              delay: 1500.ms,
              duration: 1500.ms,
              curve: Curves.decelerate,
              angle: 1,
            );
          },
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                // colorFilter: const ColorFilter.mode(
                //   Colors.red,
                //   BlendMode.colorBurn,
                // ),
              ),
            ),
          ).animate().scale(
                duration: 300.ms,
                begin: const Offset(1.25, 1.25),
                end: const Offset(1, 1),
              ),
        ),
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({Key? key, required this.isLoading, required this.child}) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? child.animate(
            onPlay: (controller) {
              controller.repeat();
            },
          ).shimmer(
            delay: 1500.ms,
            duration: 1500.ms,
            curve: Curves.decelerate,
            angle: 1,
          )
        : child;
  }
}
