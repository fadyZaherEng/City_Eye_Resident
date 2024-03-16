import 'package:city_eye/src/domain/entities/register/city_compound.dart';

class SelectRegionUseCase {
  List<CityCompound> call(List<CityCompound> regions, CityCompound selectedRegion)  {
    List<CityCompound> selectedRegions = [];
    if(selectedRegion.id == -1) {
      for(int i = 0; i < regions.length; i++) {
        if(regions[i].parentId == 0){
          selectedRegions.add(regions[i]);
        }
      }
    } else {
      for(int i = 0; i < regions.length; i++) {
        if(selectedRegion.id == regions[i].id){
          selectedRegions.add(regions[i]);
        }
      }
    }
    return selectedRegions;
  }
}