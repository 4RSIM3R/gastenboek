import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  static Future<void> openMap(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {}
  }
}
