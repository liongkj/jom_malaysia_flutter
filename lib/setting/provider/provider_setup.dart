import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/authentication/firebase_auth_service.dart';
import 'package:jom_malaysia/core/services/gateway/firestore_api.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/core/services/image/cloudinary/cloudinary_image_service.dart';
import 'package:jom_malaysia/core/services/search/algolia_search.dart';
import 'package:jom_malaysia/screens/login/providers/timer_provider.dart';
import 'package:jom_malaysia/screens/tabs/explore/providers/featured_place_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/ads_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/comments_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/listing_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/search_result_provider.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
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
    create: (_) => AlgoliaSearch(),
  ),
  InheritedProvider(
    create: (_) => FirestoreService(),
  ),
  InheritedProvider(
    create: (_) => FirebaseAuthService(),
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
  ChangeNotifierProvider<TimerProvider>(
    create: (_) => TimerProvider(),
  ),
  ChangeNotifierProvider<LocationProvider>(
    create: (_) => LocationProvider(),
  ),
  StreamProvider<FirebaseUser>(
      create: (_) => FirebaseAuth.instance.onAuthStateChanged),
];

List<SingleChildWidget> dependentServices = [
  ChangeNotifierProxyProvider<FirebaseUser, AuthProvider>(
    create: (context) => AuthProvider(
      service: Provider.of<FirebaseAuthService>(context, listen: false),
    ),
    update: (context, value, previous) => previous..setUser(value),
  ),
  InheritedProvider(
    create: (context) => AdsService(
      httpService: Provider.of<HttpService>(context, listen: false),
    ),
  ),
  InheritedProvider(
      create: (context) => CloudinaryImageService(
            httpService: Provider.of<HttpService>(context, listen: false),
          )),
  ChangeNotifierProxyProvider<LocationProvider, ListingProvider>(
    update: (ctx, location, listingProvider) {
      debugPrint("updating");
      return listingProvider
        ..fetchAndInitPlaces(city: location.selected?.cityName, refresh: true);
    },
    create: (BuildContext context) {
      debugPrint("creating provider");
      return ListingProvider(
        httpService: Provider.of<HttpService>(context, listen: false),
      );
    },
  ),
  ChangeNotifierProvider<FeaturedPlaceProvider>(
    create: (BuildContext context) => FeaturedPlaceProvider(
      httpService: Provider.of<HttpService>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<CommentsProvider>(
    create: (context) => CommentsProvider(
      firebaseService: Provider.of<FirestoreService>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => SearchResultProvider(
      service: Provider.of<AlgoliaSearch>(context, listen: false),
    ),
  ),
];

List<SingleChildWidget> uiConsumableProviders = [];
