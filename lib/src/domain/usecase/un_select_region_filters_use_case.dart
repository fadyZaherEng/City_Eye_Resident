import 'package:city_eye/src/domain/entities/register/city_compound.dart';

class UnSelectRegionFiltersUseCase {
  List<CityCompound> call(List<CityCompound> regions, CityCompound selectedRegion)  {
    List<CityCompound> selectedRegions = [];
    for(int i = 0; i < regions.length; i++) {
      if(selectedRegion.parentId == regions[i].parentId || selectedRegion.parentId == regions[i].id) {
        selectedRegions.add(regions[i]);
      }
    }
    return selectedRegions;
  }
}