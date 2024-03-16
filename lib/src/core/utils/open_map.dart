import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(double latitude, double longitude) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}

/*
_launchMaps(double latitude, double longitude) async {
  String googleUrl =
      'comgooglemaps://?center=$latitude,$longitude';
  String appleUrl =
      'https://maps.apple.com/?sll=$latitude,$longitude';
  if (await canLaunch("comgooglemaps://")) {
    print('launching com googleUrl');
    await launch(googleUrl);
  } else if (await canLaunch(appleUrl)) {
    print('launching apple url');
    await launch(appleUrl);
  } else {
    throw 'Could not launch url';
  }
}*/
