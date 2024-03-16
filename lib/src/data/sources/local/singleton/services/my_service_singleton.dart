import 'package:city_eye/src/domain/entities/home/home_service.dart';

class MyServiceSingleton {
  MyServiceSingleton._();

  static final MyServiceSingleton _instance = MyServiceSingleton._();
  List<HomeService> homeServices = [];
  List<HomeService> filteredServices = [];

  factory MyServiceSingleton() => _instance;
}
