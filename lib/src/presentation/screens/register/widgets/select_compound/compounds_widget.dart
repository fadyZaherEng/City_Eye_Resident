import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/register/compound.dart';
import 'package:city_eye/src/domain/entities/register/city_compound.dart';
import 'package:city_eye/src/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class CompoundsWidget extends StatefulWidget {
  final List<CityCompound> regions;
  final CityCompound selectedRegion;
  final Compound selectedCompound;
  final Function(Compound compound) onSelectCompound;

  const CompoundsWidget({
    Key? key,
    required this.regions,
    required this.selectedRegion,
    required this.selectedCompound,
    required this.onSelectCompound,
  }) : super(key: key);

  @override
  State<CompoundsWidget> createState() => _CompoundsWidgetState();
}

class _CompoundsWidgetState extends State<CompoundsWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: widget.regions.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.regions.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.regions[index].id == -1
                    ? const SizedBox.shrink()
                    : _buildCompoundsWidget(
                        widget.regions[index],
                      );
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImagePaths.compoundEmpty,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(height: 15),
                  Text(S.of(context).noCompoundsFound,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                          )),
                ],
              ),
            ),
    );
  }

  Widget _buildCompoundsWidget(CityCompound region) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Text(
            region.name,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  letterSpacing: -0.24,
                  color: ColorSchemes.black,
                ),
          ),
        ),
        GridView.builder(
            itemCount: region.compounds.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 170,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  widget.onSelectCompound(region.compounds[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CardWidget(
                    color:
                        region.compounds[index].id == widget.selectedCompound.id
                            ? ColorSchemes.cardSelected
                            : ColorSchemes.white,
                    borderColor:
                        region.compounds[index].id == widget.selectedCompound.id
                            ? ColorSchemes.primary
                            : ColorSchemes.white,
                    widget: Image.network(
                      region.compounds[index].logo,
                      fit: BoxFit.scaleDown,
                      height: 50,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Center(
                            child: SvgPicture.asset(
                          ImagePaths.airConditioning,
                        ));
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 50,
                                  width: 50,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    title: region.compounds[index].name,
                    subtitle: "",
                  ),
                ),
              );
            })
      ],
    );
  }
}
