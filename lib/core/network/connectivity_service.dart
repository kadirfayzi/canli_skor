import 'dart:async' show StreamController;
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { online, offline }

class ConnectivityService {
  final _controller = StreamController<NetworkStatus>.broadcast();
  final Connectivity _connectivity = Connectivity();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen(
      (results) => _handleConnectivityResults(results),
      onError: (error) => _controller.add(NetworkStatus.offline),
    );
  }

  /// Handles connectivity results and updates the stream accordingly.
  void _handleConnectivityResults(List<ConnectivityResult> results) {
    final hasConnection = results.any((r) => r == ConnectivityResult.wifi || r == ConnectivityResult.mobile);

    final status = hasConnection ? NetworkStatus.online : NetworkStatus.offline;
    _controller.sink.add(status);
  }

  /// Expose the network status stream to outside listeners.
  /// `.distinct()` ensures the same status isn't emitted multiple times in a row.
  Stream<NetworkStatus> get networkStatusStream => _controller.stream.distinct();

  void dispose() => _controller.close();
}
