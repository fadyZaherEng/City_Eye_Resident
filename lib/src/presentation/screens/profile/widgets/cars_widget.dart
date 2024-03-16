import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/extensions/color_extension.dart';
import 'package:city_eye/src/domain/entities/profile/car.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarsWidget extends StatefulWidget {
  final List<Car> cars;
  final Function(Car) onDelete;
  final Function(Car) onEdit;

  const CarsWidget({
    Key? key,
    required this.cars,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<CarsWidget> createState() => _CarsWidgetState();
}

class _CarsWidgetState extends State<CarsWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.cars.isEmpty
        ? CustomEmptyListWidget(
            text: S.of(context).noCarsRightNow,
            imagePath: ImagePaths.noCars,
            isRefreshable: false,
          )
        : ListView.builder(
            itemCount: widget.cars.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ColorSchemes.cardSelected,
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        offset: Offset(0, 4),
                        blurRadius: 32,
                        spreadRadius: 0),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImagePaths.car,
                          fit: BoxFit.scaleDown,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          widget.cars[index].carType.name ?? "",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.black,
                                  ),
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            widget.onDelete(widget.cars[index]);
                          },
                          child: SvgPicture.asset(
                            ImagePaths.delete,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 36,
                        ),
                        Text(
                          widget.cars[index].modelType.name ?? "",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.gray,
                                  ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            color: widget.cars[index].colorType.code.toColor(),
                            borderRadius: BorderRadius.circular(4),
                            shape: BoxShape.rectangle,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 20,
                                spreadRadius: 0,
                                color: ColorSchemes.gray,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.cars[index].colorType.name,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: ColorSchemes.black,
                                  ),
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            widget.onEdit(widget.cars[index]);
                          },
                          child: SvgPicture.asset(
                            ImagePaths.edit,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 36,
                        ),
                        Text(
                          widget.cars[index].plateNumber,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: ColorSchemes.black,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }
}
