import 'package:injectable/injectable.dart';
import 'package:todo_app/app/data/datasource/remote/config/api_config.dart';

@Injectable(as: ApiConfig)
class CatsApiConfig extends ApiConfig {
  @override
  String get baseUrl => "https://catfact.ninja/";

  @override
  Map<String, String> get headers => {};
}
