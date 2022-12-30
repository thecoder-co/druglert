import 'dart:convert';

import 'dart:developer';

JsonDecoder decoder = const JsonDecoder();
JsonEncoder encoder = const JsonEncoder.withIndent('  ');

void prettyPrintJson(Object input) {
  var object = decoder.convert(input.toString());
  var prettyString = encoder.convert(object);
  log(prettyString);
}
