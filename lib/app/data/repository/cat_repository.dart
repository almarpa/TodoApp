import 'package:todo_app/app/data/entities/cat_entity.dart';

abstract class CatRepository {
  Future<CatEntity> oneMoreFactPlease();
}
