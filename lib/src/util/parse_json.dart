import 'dart:collection';
import 'dart:convert' show LineSplitter, utf8;

import 'package:flutter/services.dart';
import 'package:vihfi_control/src/models/mac-vendor_model.dart';

Future<HashMap<String, MacVendorModel>> parseJsonMacVendorsFromAssets(
    ByteData jsonByte) async {
  var json = _getStringFromBytes(jsonByte);
  var ls = LineSplitter();
  var lines = ls.convert(json);
  var vendors = HashMap<String, MacVendorModel>();

  for (var line in lines) {
    var macVendorModel = MacVendorModel.fromRawJson(line);
    vendors[macVendorModel.oui.replaceAll(':', '-')] = macVendorModel;
  }

  return vendors;
}

String _getStringFromBytes(ByteData data) {
  final buffer = data.buffer;
  var list = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  return utf8.decode(list);
}