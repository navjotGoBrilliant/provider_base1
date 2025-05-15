import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_base1/common/routes/routes.dart';
import 'package:provider_base1/features/authentication/screens/otp_screen.dart';
import 'package:provider_base1/features/authentication/screens/phone_number_screen.dart';
import 'package:provider_base1/features/dashboard/screens/base_screen.dart';
import 'package:provider_base1/features/dashboard/screens/home_screen.dart';
import 'package:provider_base1/features/dashboard/screens/request_screen.dart';
import 'package:provider_base1/features/dashboard/screens/settings_screen.dart';
import 'package:provider_base1/features/splash/splash_screen.dart';

import '../../features/responsiveUI/screens/responsive_screen.dart';
import '../../features/shopping/screens/base.dart';
import '../../features/shopping/screens/cart/cart_screen.dart';
import '../../features/shopping/screens/product/product_screen.dart';
import '../../features/shopping/screens/shop/shop_screen.dart';
import '../animations/circular_reveal_transition.dart';


class RouteGenerator {
  /// GoRouter configuration
  static final router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: SplashScreen(),
            transitionDuration: const Duration(milliseconds: 10),
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return CircularRevealTransition(animation: animation, child: child);

             // return FadeTransition(opacity: CurveTween(curve: Curves.easeInOut).animate(animation), child: child);
            },
          );
        },
      ),

      GoRoute(
        path: Routes.phoneNumberScreen,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: PhoneNumberScreen(),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return CircularRevealTransition(animation: animation, child: child);
            //  return FadeTransition(opacity: CurveTween(curve: Curves.easeOutCirc).animate(animation), child: child);
            },
          );
        },
      ),

      GoRoute(
        path: Routes.otpScreen,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: OTPScreen(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return FadeTransition(opacity: CurveTween(curve: Curves.easeInOut).animate(animation), child: child);
            },
          );
        },
      ),

      GoRoute(
        path: Routes.base,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: BaseScreen(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return FadeTransition(opacity: CurveTween(curve: Curves.easeInOut).animate(animation), child: child);
            },
          );
        },
      ),

      GoRoute(
        path: Routes.settings,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: SettingsScreen(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return FadeTransition(opacity: CurveTween(curve: Curves.easeInOut).animate(animation), child: child);
            },
          );
        },
      ),

      GoRoute(
        path: Routes.home,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: HomeScreen(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return FadeTransition(opacity: CurveTween(curve: Curves.easeInOut).animate(animation), child: child);
            },
          );
        },
      ),
      GoRoute(
        path: Routes.request,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: RequestScreen(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return FadeTransition(opacity: CurveTween(curve: Curves.easeInOut).animate(animation), child: child);
            },
          );
        },
      ),

      GoRoute(
        path: Routes.productView,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: ProductScreen(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return FadeTransition(opacity: CurveTween(curve: Curves.easeInOut).animate(animation), child: child);
            },
          );
        },
      ),

      GoRoute(
        path: Routes.responsiveScreen,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: ResponsiveScreen(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return FadeTransition(opacity: CurveTween(curve: Curves.easeInOut).animate(animation), child: child);
            },
          );
        },
      ),

    ],
  );
}
