import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/gateway/firebase_storage_api.dart';
import 'package:jom_malaysia/core/services/gateway/firestore_api.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/core/services/permission/permission_utils.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/comments_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/listing_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/provider/theme_provider.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  InheritedProvider(
    create: (_) => HttpService(),
  ),
  InheritedProvider(
    create: (_) => FirestoreService(),
  ),
  InheritedProvider(
    create: (_) => PermissionService(),
  ),
  InheritedProvider(
    create: (_) => FirebaseStorageService(),
  ),
  ChangeNotifierProvider<UserCurrentLocationProvider>(
    create: (_) => UserCurrentLocationProvider(),
  ),
  ChangeNotifierProvider<LanguageProvider>(
    create: (_) => LanguageProvider(),
  ),
  ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider(),
  ),
  ChangeNotifierProvider<LocationProvider>(
    create: (_) => LocationProvider(),
  ),
];

List<SingleChildWidget> dependentServices = [
  ChangeNotifierProxyProvider<LocationProvider, ListingProvider>(
    update: (ctx, location, listingProvider) => listingProvider
      ..fetchAndInitPlaces(city: location.selected?.cityName, refresh: true),
    create: (BuildContext context) {
      return ListingProvider(
        httpService: Provider.of<HttpService>(context, listen: false),
      );
    },
  ),
  ChangeNotifierProvider<CommentsProvider>(
    create: (context) => CommentsProvider(
      firebaseService: Provider.of<FirestoreService>(context, listen: false),
    ),
  ),
];

List<SingleChildWidget> uiConsumableProviders = [];
