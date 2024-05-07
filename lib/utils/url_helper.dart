import 'package:workmate/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<void> launchInBrowser({required String urlString}) async {
    try {
      launchUrl(Uri.parse(urlString), mode: LaunchMode.externalApplication);
    } catch (e) {
      logger.e('Can not launch url: $urlString');
    }
  }
}
