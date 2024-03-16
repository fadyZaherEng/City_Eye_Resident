import 'package:city_eye/src/domain/entities/register/compound.dart';
import 'package:city_eye/src/domain/entities/register/city_compound.dart';

class SearchCompoundsUseCase {
  List<CityCompound> call(
      List<CityCompound> regions, CityCompound selectedRegions, String value) {
    List<CityCompound> filteredRegions = [];

    if (selectedRegions.id == -1) {
      for (int i = 0; i < regions.length; i++) {
        List<Compound> compounds = regions[i]
            .compounds
            .where((element) =>
                element.name!.toLowerCase().contains(value.toLowerCase()))
            .toList();
        if (compounds.isNotEmpty && regions[i].parentId == 0) {
          filteredRegions.add(CityCompound(
            id: regions[i].id,
            name: regions[i].name,
            parentId: regions[i].parentId,
            compounds: compounds,
          ));
        }
      }
    } else {
      for (int i = 0; i < regions.length; i++) {
        if (selectedRegions.id == regions[i].id) {
          List<Compound> compounds = regions[i]
              .compounds
              .where((element) =>
                  element.name!.toLowerCase().contains(value.toLowerCase()))
              .toList();
          if (compounds.isNotEmpty) {
            filteredRegions.add(CityCompound(
              id: regions[i].id,
              name: regions[i].name,
              parentId: regions[i].parentId,
              compounds: compounds,
            ));
          }
        }
      }
    }
    return filteredRegions;
  }
}
