import 'package:flutter/material.dart';

class NoInternetOverlayWidget extends StatelessWidget {
  const NoInternetOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) => IgnorePointer(
        ignoring: false,
        child: ColoredBox(
          color: Colors.black.withValues(alpha: 0.6),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off,
                  color: Colors.white,
                  size: 48,
                ),
                SizedBox(height: 16),
                Text(
                  'İnternet bağlantısı yok!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 8),
                Text(
                  'Bağlantı sağlandığında otomatik olarak yenilenecektir',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
}
