import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:e_commerce/models/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/cart_model.dart';
import 'app.dart';

void main() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "basic_notification",
        channelDescription: "Test notification channels",

    )
  ],
  channelGroups: [
    NotificationChannelGroup(channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic_group")
  ]
  );
  bool isAllowedToSendNotifications = await AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotifications) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartModel>(
          create: (context) {
            CartModel cartModel = CartModel();
            cartModel.fetchCartItems(); // Fetch cart items when the app starts
            return cartModel;
          },
        ),
        ChangeNotifierProvider<WishlistModel>(
          create: (context) {
            WishlistModel wishlistModel = WishlistModel();
            wishlistModel
                .fetchWishlistItems(); // Fetch wishlist items when the app starts
            return wishlistModel;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}
