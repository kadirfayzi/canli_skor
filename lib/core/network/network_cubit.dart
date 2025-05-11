import 'dart:async' show StreamSubscription;

import 'package:flutter_bloc/flutter_bloc.dart';
import '../network/connectivity_service.dart';

class NetworkState {
  final NetworkStatus status;
  const NetworkState(this.status);
}

class NetworkCubit extends Cubit<NetworkState> {
  final ConnectivityService _connectivityService;
  late final StreamSubscription _subscription;

  NetworkCubit(this._connectivityService) : super(const NetworkState(NetworkStatus.online)) {
    /// Listen to the networkStatusStream and emit a new state when it changes.
    _subscription = _connectivityService.networkStatusStream.listen((status) {
      emit(NetworkState(status));
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
