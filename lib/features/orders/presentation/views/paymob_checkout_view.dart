import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/widgets/primary_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/widgets/app_top_bar.dart';

class PaymobCheckoutView extends StatefulWidget {
  final String checkoutUrl;

  const PaymobCheckoutView({
    Key? key,
    required this.checkoutUrl,
  }) : super(key: key);

  @override
  State<PaymobCheckoutView> createState() => _PaymobCheckoutViewState();
}

class _PaymobCheckoutViewState extends State<PaymobCheckoutView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint('PAYMOB PAGE STARTED: $url');

            if (mounted) {
              setState(() => _isLoading = true);
            }
          },
          onPageFinished: (url) {
            debugPrint('PAYMOB PAGE FINISHED: $url');

            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
          onWebResourceError: (error) {
            debugPrint('PAYMOB WEB ERROR:');
            debugPrint('Code: ${error.errorCode}');
            debugPrint('Description: ${error.description}');
            debugPrint('URL: ${error.url}');
            debugPrint('Main frame: ${error.isForMainFrame}');

            if (error.isForMainFrame == true && mounted) {
              setState(() => _isLoading = false);
            }
          },
          onHttpError: (error) {
            debugPrint('PAYMOB HTTP ERROR: ${error.response?.statusCode}');
            debugPrint('URL: ${error.request?.uri}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  void _checkPaymentStatus() {
    context.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(title: 'Paymob Checkout'),
            Expanded(
              child: Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: PrimaryButton(
                label: 'I have completed payment',
                onPressed: _isLoading ? null : _checkPaymentStatus,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
