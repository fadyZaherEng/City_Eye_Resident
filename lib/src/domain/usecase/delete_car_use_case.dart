import 'package:city_eye/src/domain/entities/profile/car.dart';

class DeleteCarUseCase {
  List<Car> call(List<Car> cars, Car car) {
    return cars.where((element) => element != car).toList();
  }
}
