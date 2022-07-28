///
//  Generated code. Do not modify.
//  source: aioesphomeapi/api_options.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class APISourceType extends $pb.ProtobufEnum {
  static const APISourceType SOURCE_BOTH = APISourceType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SOURCE_BOTH');
  static const APISourceType SOURCE_SERVER = APISourceType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SOURCE_SERVER');
  static const APISourceType SOURCE_CLIENT = APISourceType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SOURCE_CLIENT');

  static const $core.List<APISourceType> values = <APISourceType> [
    SOURCE_BOTH,
    SOURCE_SERVER,
    SOURCE_CLIENT,
  ];

  static final $core.Map<$core.int, APISourceType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static APISourceType? valueOf($core.int value) => _byValue[value];

  const APISourceType._($core.int v, $core.String n) : super(v, n);
}

