import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentFileWidget extends StatefulWidget {
  final Function() onTap;
  final void Function(String file) deleteFileAction;
  final String file;
  final String fileName;
  final bool fileValid;
  final String description;
  final String errorMessage;
  final GlobalKey? globalKey;

  const DocumentFileWidget({
    Key? key,
    required this.onTap,
    required this.file,
    required this.deleteFileAction,
    required this.fileValid,
    required this.fileName,
    required this.description,
    required this.errorMessage,
    this.globalKey,
  }) : super(key: key);

  @override
  State<DocumentFileWidget> createState() => _DocumentFileWidgetState();
}

class _DocumentFileWidgetState extends State<DocumentFileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: widget.globalKey,
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      child: widget.file.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.fileName,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.24,
                      ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: widget.onTap,
                  child: Container(
                    height: 114,
                    width: 343,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        border: Border.all(
                          color: widget.fileValid
                              ? ColorSchemes.lightGray
                              : ColorSchemes.redError,
                          width: 1,
                        )),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImagePaths.documentUpload,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: ColorSchemes.gray,
                                  fontWeight: Constants.fontWeightRegular,
                                  letterSpacing: -0.13,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.errorMessage,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.redError,
                            fontWeight: Constants.fontWeightRegular,
                            letterSpacing: -0.13,
                          ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  ImagePaths.pdf,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.pdfScreen,
                            arguments: {
                              "screenTitle": S.of(context).documents,
                              "link": widget.file,
                              "isNetworkPDF": false,
                            },
                          );
                        },
                        child: Text(
                          widget.file.split('/').last,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.13,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        S.of(context).editNow,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.12,
                            ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => widget.deleteFileAction(widget.file),
                  child: SvgPicture.asset(
                    ImagePaths.close,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
    );
  }
}
