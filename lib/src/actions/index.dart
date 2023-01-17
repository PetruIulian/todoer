library actions;

import 'package:todoer/src/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'index.freezed.dart';
part 'create_user.dart';
part 'login.dart';
part 'logout.dart';

typedef ActionResponse = void Function(dynamic action);