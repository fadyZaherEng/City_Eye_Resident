import 'dart:io';

import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class WebViewHtmlContentWidget extends BaseStatefulWidget {
  final String webViewHtmlContent;

  const WebViewHtmlContentWidget({Key? key, required this.webViewHtmlContent})
      : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _WebViewHtmlContentWidgetState();
}

class _WebViewHtmlContentWidgetState
    extends BaseState<WebViewHtmlContentWidget> {
  bool isPageLoaded = false;
  WebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: HtmlWidget(
            textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: ColorSchemes.black,
            ),
            widget.webViewHtmlContent ?? "",
            onTapUrl: (url) async {
              if (await canLaunchUrl(Uri(path: url))) {
                await launchUrl(Uri(path: url));
                return true;
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ),
      ),
    );
  }
}
