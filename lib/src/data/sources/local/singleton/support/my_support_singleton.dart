import 'package:city_eye/src/domain/entities/home/home_support.dart';

class MySupportSingleton {
  MySupportSingleton._();

  static final MySupportSingleton _instance = MySupportSingleton._();

  List<HomeSupport> supports = const [];

  factory MySupportSingleton() => _instance;

}
