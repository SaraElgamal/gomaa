

import 'package:flutter/cupertino.dart';
 aniamtedNavigation({
  required Widget screen,
}) {
  return PageRouteBuilder(
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 750),
      pageBuilder: (context, animation, secondaryAnimation)
      => screen);
}
class SliderRight extends PageRouteBuilder
{
  final page;

  SliderRight({this.page}) : super(
      pageBuilder: (context , animation , animationTwo ) => page
      ,transitionsBuilder: (context , animation , animationTwo, child ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset(0.0, 0.0);
    final tween = Tween(begin: begin, end: end);
    final offsetAnimation = animation.drive(tween);
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    );
    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  }
  );

}
class SliderLeft extends PageRouteBuilder
{
  final page;
  SliderLeft({this.page}) : super(
      pageBuilder: (context , animation , animationTwo ) => page
      ,transitionsBuilder: (context , animation , animationTwo, child ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset(0.0, 0.0);
    final tween = Tween(begin: begin, end: end);
    final offsetAnimation = animation.drive(tween);
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    );
    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  }
  );

}

// class BottomBar extends PageRouteBuilder
// {
//   final page;
//   SliderRight({this.page}) : super(
//       pageBuilder: (context , animation , animationTwo ) => page
//       ,transitionsBuilder: (context , animation , animationTwo, child ) {
//     const begin = Offset(1.0, 0.0);
//     const end = Offset(0.0, 0.0);
//     final tween = Tween(begin: begin, end: end);
//     final offsetAnimation = animation.drive(tween);
//     final curvedAnimation = CurvedAnimation(
//       parent: animation,
//       curve: Curves.easeIn,
//     );
//     return ScaleTransition(
//       scale: curvedAnimation,
//       child: child,
//     );
//   }
//   );
//
// }