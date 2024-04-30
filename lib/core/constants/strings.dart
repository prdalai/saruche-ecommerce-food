import 'package:flutter/material.dart';

sealed class AppStrings {
  static const String fontFamily = 'Form';
  static const String loading = "LOADING";
  static const String wait = "Wait...";
  static const String noConnection = "Sorry! Due to internet connection\nfailed, so the application is not working. Please check the\ninternet connection.";

  // static const List<String> tabStrings = ['Breakfast', 'Lunch', 'Dinner', 'Drinks', 'Snacks','Desert'];
  static const List<String> moreScreenStrings = [
    'My Subscriptions',
    'My Profile',
    'Favorites',
    'Offers',
    'Settings',
    'Invite a Friend',
    'About Nibbles',
    'Terms & Conditions',
    'Privacy Policies',
    'Contact Us',
  ];

  static const List<String> tags = [
    'Sugar Free',
    'Veggie',
    'Easy Cook',
    'Fast Cook',
    'Cheap',
    'Cold',
    'Muscle Builder',
    'Power Giver',
    'Delicious'
  ];

  static const String gitUrl = "https://twitter.com/yummsaruche";
  static const String linkedUrl = "https://instagram.com/yummsaruche";
  static const String nibblesUrl = "https://facebook.com/yummsaruche";


  static const List<String> socialUrls = [
    gitUrl,
    linkedUrl,
    nibblesUrl,
  ];

  static const String location = "Thane, MH, India";
  static const String phone = "+91 8655552963";

  static const List<String> contactInfo = [
    location,
    phone,
  ];
}

//final GlobalKey globalKey = GlobalKey();
