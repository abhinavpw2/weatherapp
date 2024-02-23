import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart'
    as geolocator; // or whatever name you want
import 'package:grocery_app/firebase_options.dart';
import 'package:grocery_app/utils/offline_db_helper.dart';
import 'package:grocery_app/utils/shared_pref_helper.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app.dart';
import 'package:location/location.dart'as loc;
import 'package:geocoding/geocoding.dart' as geo;

Directory _appDocsDir;
String TitleNotificationSharvaya = "";

String Latitude;
String Longitude;
bool is_LocationService_Permission;
 Geolocator geolocator123 = Geolocator();
Location location = new Location();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPrefHelper.createInstance();
  await OfflineDbHelper.createInstance();

  //checkPermissionStatus();
  //getLocationLivePermission();
  getToken();

  runApp(MyApp());
}

void getToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCMToken" + " Token : " + fcmToken.toString());
}





/*
void checkPermissionStatus() async {
  bool granted = await Permission.location.isGranted;
  bool Denied = await Permission.location.isDenied;
  bool PermanentlyDenied = await Permission.location.isPermanentlyDenied;
  bool StorageGranted = await Permission.storage.isGranted;
  bool StorageDenied = await Permission.storage.isDenied;
  bool StoragePermanentlyDenied = await Permission.storage.isPermanentlyDenied;

  print("PermissionStatus" +
      "Granted : " +
      granted.toString() +
      " Denied : " +
      Denied.toString() +
      " PermanentlyDenied : " +
      PermanentlyDenied.toString());

  if (Denied == true || StorageDenied == true) {
    // openAppSettings();
    is_LocationService_Permission = false;

    if (Platform.isAndroid) {


    }

    await Permission.location.request();
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
  }

// You can can also directly ask the permission about its status.
  if (await Permission.location.isRestricted ||
      await Permission.storage.isRestricted) {
    // The OS restricts access, for example because of parental controls.
    openAppSettings();
  }
  if (PermanentlyDenied == true || StoragePermanentlyDenied == true) {
    // The user opted to never again see the permission request dialog for this
    // app. The only way to change the permission's status now is to let the
    // user manually enable it in the system settings.
    is_LocationService_Permission = false;
    openAppSettings();
  }

  if (granted == true || StorageGranted == true) {
    // The OS restricts access, for example because of parental controls.
    is_LocationService_Permission = true;
    getLiveAddressLatLong();

  }
}
*/


/*
void getLocationLivePermission() async {

  bool serviceEnabled;
  LocationPermission permission;


  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {

    checkPermissionStatus();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    //permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.

      print("A12215534"+"Location permissions are  denied, we cannot request permissions.");

      permission = await Geolocator.requestPermission();
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.

    print("A12215534"+"Location permissions are permanently denied, we cannot request permissions.");


    permission = await Geolocator.requestPermission();
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }


  if(permission == LocationPermission.whileInUse)
  {
    Position position = await Geolocator.getCurrentPosition();

    print("CurrentLatLong" + position.latitude.toString() +" , "+ position.longitude.toString());

    SharedPrefHelper.instance.setLatitude(position.latitude.toString());
    SharedPrefHelper.instance.setLongitude(position.longitude.toString());

    getLiveAddressLatLong();


  }





}
*/

/*
void getLiveAddressLatLong() async {


  loc.LocationData locationData = await  loc.Location.instance.getLocation();


  Latitude = locationData.latitude.toString();
  Longitude = locationData.longitude.toString();


  SharedPrefHelper.instance.setLatitude(Latitude);
  SharedPrefHelper.instance.setLongitude(Longitude);




}
*/
