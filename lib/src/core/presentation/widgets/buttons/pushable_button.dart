// import 'package:flutter/material.dart';

// /// abstract class to reduce animation controller boilerplate
// /// See: https://codewithandrea.com/videos/reduce-animation-controller-boilerplate-flutter-hooks/
// abstract class AnimationControllerState<T extends StatefulWidget> extends State<T> with SingleTickerProviderStateMixin {
//   AnimationControllerState();
//   late final AnimationController animationController;

//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }
// }

// /// A widget to show a "3D" pushable button
// class PushableButton extends StatefulWidget {
//   const PushableButton({
//     super.key,
//     this.child,
//     required this.hslColor,
//     required this.height,
//     this.elevation = 8.0,
//     this.shadow,
//     this.onPressed,
//     this.bottomHslColor,
//     this.width,
//   }) : assert(height > 0);

//   /// child widget (normally a Text or Icon)
//   final Widget? child;

//   /// Color of the top layer
//   /// The color of the bottom layer is derived by decreasing the luminosity by 0.15
//   final HSLColor hslColor;
//   final HSLColor? bottomHslColor;

//   /// height of the top layer
//   final double height;
//   final double? width;

//   /// elevation or "gap" between the top and bottom layer
//   final double elevation;

//   /// An optional shadow to make the button look better
//   /// This is added to the bottom layer only
//   final BoxShadow? shadow;

//   /// button pressed callback
//   final VoidCallback? onPressed;

//   @override
//   _PushableButtonState createState() => _PushableButtonState();
// }

// class _PushableButtonState extends AnimationControllerState<PushableButton> {
//   bool _isDragInProgress = false;
//   Offset _gestureLocation = Offset.zero;

//   void _handleTapDown(TapDownDetails details) {
//     _gestureLocation = details.localPosition;
//     animationController.forward();
//   }

//   void _handleTapUp(TapUpDetails details) {
//     animationController.reverse();
//     widget.onPressed?.call();
//   }

//   void _handleTapCancel() {
//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (!_isDragInProgress && mounted) {
//         animationController.reverse();
//       }
//     });
//   }

//   void _handleDragStart(DragStartDetails details) {
//     _gestureLocation = details.localPosition;
//     _isDragInProgress = true;
//     animationController.forward();
//   }

//   void _handleDragEnd(Size buttonSize) {
//     //print('drag end (in progress: $_isDragInProgress)');
//     if (_isDragInProgress) {
//       _isDragInProgress = false;
//       animationController.reverse();
//     }
//     if (_gestureLocation.dx >= 0 &&
//         _gestureLocation.dy < buttonSize.width &&
//         _gestureLocation.dy >= 0 &&
//         _gestureLocation.dy < buttonSize.height) {
//       widget.onPressed?.call();
//     }
//   }

//   void _handleDragCancel() {
//     if (_isDragInProgress) {
//       _isDragInProgress = false;
//       animationController.reverse();
//     }
//   }

//   void _handleDragUpdate(DragUpdateDetails details) {
//     _gestureLocation = details.localPosition;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final totalHeight = widget.height + widget.elevation;
//     return SizedBox(
//       height: totalHeight,
//       width: widget.width,
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final buttonSize = Size(constraints.maxWidth, constraints.maxHeight);
//           return GestureDetector(
//             onTapDown: _handleTapDown,
//             onTapUp: _handleTapUp,
//             onTapCancel: _handleTapCancel,
//             onHorizontalDragStart: _handleDragStart,
//             onHorizontalDragEnd: (_) => _handleDragEnd(buttonSize),
//             onHorizontalDragCancel: _handleDragCancel,
//             onHorizontalDragUpdate: _handleDragUpdate,
//             onVerticalDragStart: _handleDragStart,
//             onVerticalDragEnd: (_) => _handleDragEnd(buttonSize),
//             onVerticalDragCancel: _handleDragCancel,
//             onVerticalDragUpdate: _handleDragUpdate,
//             child: AnimatedBuilder(
//               animation: animationController,
//               builder: (context, child) {
//                 final top = animationController.value * widget.elevation;
//                 final hslColor = widget.hslColor;
//                 final bottomHslColor = widget.bottomHslColor ?? hslColor.withLightness(hslColor.lightness - 0.15);
//                 return Stack(
//                   children: [
//                     // Draw bottom layer first
//                     Positioned(
//                       left: 0,
//                       right: 0,
//                       bottom: 0,
//                       child: Container(
//                         height: totalHeight - top,
//                         decoration: BoxDecoration(
//                           color: bottomHslColor.toColor(),
//                           boxShadow: widget.shadow != null ? [widget.shadow!] : [],
//                           borderRadius: BorderRadius.circular(widget.height / 2),
//                         ),
//                       ),
//                     ),
//                     // Then top (pushable) layer
//                     Positioned(
//                       left: 0,
//                       right: 0,
//                       top: top,
//                       child: Container(
//                         height: widget.height,
//                         decoration: ShapeDecoration(
//                           color: hslColor.toColor(),
//                           shape: const StadiumBorder(),
//                         ),
//                         child: Center(child: widget.child),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
