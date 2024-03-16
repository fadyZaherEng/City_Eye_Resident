import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/web_view_html_content_widget.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends BaseStatefulWidget {
  final String screenTitle;
  final String content;
  final bool isLink;
  final bool isPdf;

  const WebViewScreen({
    Key? key,
    required this.screenTitle,
    required this.content,
    this.isLink = false,
    this.isPdf = false,
  }) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _WebViewScreenState();
}

class _WebViewScreenState extends BaseState<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void didUpdateWidget(covariant WebViewScreen oldWidget) {
    if (widget.isLink && widget.content.isNotEmpty) {
      _controller.loadUrl(widget.content);
      showLoading();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    if (widget.isLink && widget.content.isNotEmpty) {
      showLoading();
    }
    super.initState();
  }

  String encodedPdfUrl = "";
  String googleDocsUrl = "";

  @override
  Widget baseBuild(BuildContext context) {
    if (widget.isPdf) {
      encodedPdfUrl = Uri.encodeFull(widget.content);
      googleDocsUrl =
          "https://docs.google.com/gview?embedded=true&url=$encodedPdfUrl";
    }

    return Scaffold(
      backgroundColor: ColorSchemes.white,
      appBar: buildAppBarWidget(
        context,
        title: widget.screenTitle,
        isHaveBackButton: true,
        onBackButtonPressed: () => Navigator.pop(context),
      ),
      body: widget.isLink || widget.isPdf
          ? Column(
              children: [
                Expanded(
                  child: WebView(
                    onWebViewCreated: (controller) {
                      _controller = controller;
                    },
                    initialUrl: widget.isPdf ? googleDocsUrl : widget.content,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: (_) {
                      setState(() {
                        hideLoading();
                      });
                    },
                  ),
                ),
              ],
            )
          : Column(
              children: [
                const SizedBox(height: 8),
                Expanded(
                  child: WebViewHtmlContentWidget(
                    webViewHtmlContent: widget.content,
                  ),
                ),
              ],
            ),
    );
  }
}
