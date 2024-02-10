import 'package:eshoes_clean_arch/core/error/exceptions.dart';
import 'package:eshoes_clean_arch/domain/entities/cart/cart_item.dart';
import 'package:eshoes_clean_arch/domain/entities/product/product.dart';
import 'package:eshoes_clean_arch/presentation/views/main/other/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user/user.dart';

class AppRouter {
  static const String productDetails = '/product_details';
  static const String home = '/';
  static const String signUp = '/sign-up';
  static const String signIn = '/sign-in';
  static const String userProfile = '/user-profile';
  static const String orderProfile = '/order-profile';
  static const String deliveryDetails = '/deliver-details';
  static const String orders = '/orders';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String about = '/about';
  static const String filter = '/filter';

  static const String orderCheckout = '/order-checkout';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MainView());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case deliveryDetails:
        return MaterialPageRoute(builder: (_) => const DeliveryInfoView());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrderView());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationView());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case filter:
        return MaterialPageRoute(builder: (_) => const FilterView());
      case orderCheckout:
        List<CartItem> items = routeSettings.arguments as List<CartItem>;
        return MaterialPageRoute(
            builder: (_) => OrderCheckoutView(
                  items: items,
                ));
      case userProfile:
        User user = routeSettings.arguments as User;
        return MaterialPageRoute(
          builder: (_) => UserProfileScreen(
            user: user,
          ),
        );
      case productDetails:
        routeSettings.arguments as Product;
        return MaterialPageRoute(builder: (_) => null);
      default:
        throw const RouteException('Route Not Found!');
    }
  }
}
