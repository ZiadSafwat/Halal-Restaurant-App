
import 'dart:async';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

class ParallaxConfig {
  final int level;
  final AssetImage image;

  const ParallaxConfig({
    required this.level,
    required this.image,
  });
}

class IceCreamIndicator extends StatefulWidget {
  final Widget child;
  final IndicatorController? controller;

  /// 👇 NEW: Accept custom refresh logic from outside
  final Future<void> Function() onRefresh;

  const IceCreamIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.controller,
  });

  @override
  State<IceCreamIndicator> createState() => _IceCreamIndicatorState();
}

class _IceCreamIndicatorState extends State<IceCreamIndicator>
    with SingleTickerProviderStateMixin {
  static const _assets = <ParallaxConfig>[
    ParallaxConfig(
      image: AssetImage("assets/ice_cream_indicator/cup2.png"),
      level: 0,
    ),
    ParallaxConfig(
      image: AssetImage("assets/ice_cream_indicator/spoon.png"),
      level: 1,
    ),
    ParallaxConfig(
      image: AssetImage("assets/ice_cream_indicator/ice1.png"),
      level: 3,
    ),
    ParallaxConfig(
      image: AssetImage("assets/ice_cream_indicator/ice3.png"),
      level: 4,
    ),
    ParallaxConfig(
      image: AssetImage("assets/ice_cream_indicator/ice2.png"),
      level: 2,
    ),
    ParallaxConfig(
      image: AssetImage("assets/ice_cream_indicator/cup.png"),
      level: 0,
    ),
    ParallaxConfig(
      image: AssetImage("assets/ice_cream_indicator/mint.png"),
      level: 5,
    ),
  ];

  static const _indicatorSize = 150.0;
  static const _imageSize = 140.0;

  late AnimationController _spoonController;
  static final _spoonTween = CurveTween(curve: Curves.easeInOut);

  @override
  void initState() {
    _spoonController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    WidgetsBinding.instance.addPostFrameCallback((_) => _precacheImages());
    super.initState();
  }

  void _precacheImages() {
    for (final config in _assets) {
      unawaited(precacheImage(config.image, context));
    }
  }

  Widget _buildImage(IndicatorController controller, ParallaxConfig asset) {
    return Transform.translate(
      offset: Offset(
        0,
        -(asset.level * (controller.value.clamp(1.0, 1.5) - 1.0) * 20) + 10,
      ),
      child: OverflowBox(
        maxHeight: _imageSize,
        minHeight: _imageSize,
        child: Image(
          image: asset.image,
          fit: BoxFit.contain,
          height: _imageSize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      controller: widget.controller,
      offsetToArmed: _indicatorSize,
      onRefresh: widget.onRefresh,
      autoRebuild: false,
      child: Container(color:Colors.white,child: widget.child),
      onStateChanged: (change) {
        if (change.didChange(to: IndicatorState.loading)) {
          _spoonController.repeat(reverse: true);
        } else if (change.didChange(from: IndicatorState.loading)) {
          _spoonController.stop();
        } else if (change.didChange(to: IndicatorState.idle)) {
          _spoonController.value = 0.0;
        }
      },
      builder: (
          BuildContext context,
          Widget child,
          IndicatorController controller,
          ) {
        return Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? _) {
                return SizedBox(
                  height: controller.value * _indicatorSize,
                  child: Stack(
                    children: <Widget>[
                      for (int i = 0; i < _assets.length; i++)

                      /// checking for spoon build animation and attaching the spoon controller
                        if (i == 1)
                          AnimatedBuilder(
                            animation: _spoonController,
                            child: _buildImage(controller, _assets[i]),
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: (-_spoonTween
                                    .transform(_spoonController.value)) *
                                    1.25,
                                child: child,
                              );
                            },
                          )
                        else
                          _buildImage(controller, _assets[i])
                    ],
                  ),
                );
              },
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * _indicatorSize),
                  child: Container(child: child),
                );
              },
              animation: controller,
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _spoonController.dispose();
    super.dispose();
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////

//
// class MealParallaxConfig {
//   final int level;
//   final AssetImage image;
//
//   const MealParallaxConfig({required this.level, required this.image});
// }
//
// class MealIndicator extends StatefulWidget {
//   final Widget child;
//   final IndicatorController? controller;
//
//   const MealIndicator({
//     super.key,
//     required this.child,
//     this.controller,
//   });
//
//   @override
//   State<MealIndicator> createState() => _MealIndicatorState();
// }
//
// class _MealIndicatorState extends State<MealIndicator>
//     with SingleTickerProviderStateMixin {
//   static const _indicatorSize = 150.0;
//   static const _imageSize = 140.0;
//
//   static const _mealAssets = <MealParallaxConfig>[
//     MealParallaxConfig(level: 0, image: AssetImage("assets/ice_cream_indicator/cup.png")),
//     MealParallaxConfig(level: 1, image: AssetImage("assets/ice_cream_indicator/cup.png")),
//     MealParallaxConfig(level: 2, image: AssetImage("assets/ice_cream_indicator/cup.png")),
//     MealParallaxConfig(level: 3, image: AssetImage("assets/ice_cream_indicator/cup.png")),
//     MealParallaxConfig(level: 4, image: AssetImage("assets/ice_cream_indicator/cup.png")),
//   ];
//
//   late AnimationController _forkController;
//
//   @override
//   void initState() {
//     super.initState();
//     _forkController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1));
//     WidgetsBinding.instance.addPostFrameCallback((_) => _precacheImages());
//   }
//
//   void _precacheImages() {
//     for (final config in _mealAssets) {
//       precacheImage(config.image, context);
//     }
//   }
//
//   Widget _buildLayer(IndicatorController controller, MealParallaxConfig config) {
//     return Transform.translate(
//       offset: Offset(
//         0,
//         -(config.level * (controller.value.clamp(1.0, 1.5) - 1.0) * 20),
//       ),
//       child: OverflowBox(
//         maxHeight: _imageSize,
//         minHeight: _imageSize,
//         child: Image(image: config.image, fit: BoxFit.contain, height: _imageSize),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomRefreshIndicator(
//       controller: widget.controller,
//       offsetToArmed: _indicatorSize,
//       onRefresh: () => Future.delayed(const Duration(seconds: 2)),
//       autoRebuild: false,
//       child: widget.child,
//       onStateChanged: (change) {
//         if (change.didChange(to: IndicatorState.loading)) {
//           _forkController.repeat(reverse: true);
//         } else if (change.didChange(from: IndicatorState.loading)) {
//           _forkController.stop();
//         } else if (change.didChange(to: IndicatorState.idle)) {
//           _forkController.value = 0.0;
//         }
//       },
//       builder: (context, child, controller) {
//         return Stack(
//           children: [
//             AnimatedBuilder(
//               animation: controller,
//               builder: (context, _) {
//                 return SizedBox(
//                   height: controller.value * _indicatorSize,
//                   child: Stack(
//                     children: [
//                       for (int i = 0; i < _mealAssets.length; i++)
//                         if (_mealAssets[i].image.assetName.contains("fork"))
//                           AnimatedBuilder(
//                             animation: _forkController,
//                             child: _buildLayer(controller, _mealAssets[i]),
//                             builder: (context, child) {
//                               return Transform.rotate(
//                                 angle: _forkController.value * 0.5,
//                                 child: child,
//                               );
//                             },
//                           )
//                         else
//                           _buildLayer(controller, _mealAssets[i])
//                     ],
//                   ),
//                 );
//               },
//             ),
//             AnimatedBuilder(
//               animation: controller,
//               builder: (context, _) {
//                 return Transform.translate(
//                   offset: Offset(0.0, controller.value * _indicatorSize),
//                   child: child,
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _forkController.dispose();
//     super.dispose();
//   }
// }
