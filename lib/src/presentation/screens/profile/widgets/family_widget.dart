import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FamilyWidget extends StatefulWidget {
  final List<FamilyMember> family;
  final Function(FamilyMember) onEdit;
  final Function(FamilyMember) onDelete;

  const FamilyWidget({
    Key? key,
    required this.family,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<FamilyWidget> createState() => _FamilyWidgetState();
}

class _FamilyWidgetState extends State<FamilyWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.family.isEmpty
        ? Center(
            child: CustomEmptyListWidget(
              text: S.of(context).noFamilyMembersRightNow,
              imagePath: ImagePaths.noFamily,
              isRefreshable: false,
            ),
          )
        : ListView.builder(
            itemCount: widget.family.length,
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
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.family[index].name,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            widget.onDelete(widget.family[index]);
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
                        Text(
                          "\u200E${widget.family[index].mobileNumber}",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.gray,
                                  ),
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            widget.onEdit(widget.family[index]);
                          },
                          child: SvgPicture.asset(
                            ImagePaths.edit,
                            fit: BoxFit.scaleDown,
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
