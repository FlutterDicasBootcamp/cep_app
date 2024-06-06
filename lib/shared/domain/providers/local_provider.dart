import 'package:cep_app/shared/data/local/local_service/local_service.dart';
import 'package:cep_app/shared/data/local/local_service/shared_preferences_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localprovider = Provider<LocalService>(
  (ref) => SharedPreferencesService(),
);
