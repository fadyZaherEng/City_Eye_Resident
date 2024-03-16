import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/presentation/screens/pdf_viewer/pdf_screen.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

class PreviewWidget extends BaseStatefulWidget {
  final String pdfUrl;
  final void Function() onTapPreviewDone;

  const PreviewWidget(
      {required this.pdfUrl, required this.onTapPreviewDone, super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends BaseState<PreviewWidget> {
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: widget.pdfUrl.isEmpty
                ? const SizedBox()
                : PDFScreen(
                    pdfLink: widget.pdfUrl,
                    screenTitle: "",
                    showAppBar: false,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButtonWidget(
              onTap: () {
                widget.onTapPreviewDone();
              },
              width: double.infinity,
              text: S.of(context).done,
              backgroundColor: F.isNiceTouch ? ColorSchemes.ghadeerDarkBlue : ColorSchemes.primary,
            ),
          )
        ],
      ),
    );
  }
}
