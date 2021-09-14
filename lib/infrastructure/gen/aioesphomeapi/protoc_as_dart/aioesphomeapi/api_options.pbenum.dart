///
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class APISourceType extends $pb.ProtobufEnum {
  static const APISourceType SOURCE_BOTH = APISourceType._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'SOURCE_BOTH');
  static const APISourceType SOURCE_SERVER = APISourceType._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'SOURCE_SERVER');
  static const APISourceType SOURCE_CLIENT = APISourceType._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'SOURCE_CLIENT');

  static const $core.List<APISourceType> values = <APISourceType>[
    SOURCE_BOTH,
    SOURCE_SERVER,
    SOURCE_CLIENT,
  ];

  static final $core.Map<$core.int, APISourceType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static APISourceType? valueOf($core.int value) => _byValue[value];

  const APISourceType._($core.int v, $core.String n) : super(v, n);
}
