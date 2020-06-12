
import 'package:flutter/foundation.dart';
import 'package:vihfi_control/src/settings.dart';
import 'package:vihfi_control/src/util/parse_json.dart';
import 'package:flutter/services.dart';

class LoadMacDatabaseAsset {
  static Future<void> load() async {
    if(Settings.macVendors!=null){
   Settings.macVendors = await compute(parseJsonMacVendorsFromAssets,await rootBundle.load('assets/macaddress.io-db.json'));
    }
  }
}
