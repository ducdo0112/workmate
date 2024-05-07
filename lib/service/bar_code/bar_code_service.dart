import 'package:barcode/barcode.dart';

class BarCodeService {
  static String buildBarcode(
      Barcode bc,
      String data, {
        String? filename,
        double? width,
        double? height,
        double? fontHeight,
      }) {
    /// Create the Barcode
    final svg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 200,
      fontHeight: fontHeight,
    );
    return svg;
  }
}