import 'dart:developer';
import 'dart:ui';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:stay_match/core/networking/endpoints.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';
import 'package:stay_match/core/utils/secure_storage_keys.dart';
import 'package:stay_match/core/utils/service_locator.dart';

class NotificationService {
  late HubConnection hubConnection;
  final _secureStorage = getIt.get<SecureStorageHelper>();

  Future<void> initHub({required VoidCallback onRefresh}) async {
    final token = await _secureStorage.readFromSecureStorage(
      key: SecureStorageKeys.tokenKey,
    );

    final httpOptions = HttpConnectionOptions(
      accessTokenFactory: () async => token ?? '',
    );

    hubConnection = HubConnectionBuilder()
        .withUrl(Endpoints.notificationsHub, options: httpOptions)
        .withAutomaticReconnect()
        .build();

    hubConnection.on('ReceiveNotification', (_) {
      log('NotificationHub: ReceiveNotification — refreshing');
      onRefresh();
    });

    hubConnection.onclose(({error}) => log('NotificationHub: Closed'));
    hubConnection.onreconnecting(({error}) => log('NotificationHub: Reconnecting...'));
    hubConnection.onreconnected(({connectionId}) => log('NotificationHub: Reconnected'));

    try {
      if (hubConnection.state != HubConnectionState.Connected) {
        await hubConnection.start();
        log('NotificationHub: Connected');
      }
    } catch (e) {
      log('NotificationHub Start Error: $e');
    }
  }

  Future<void> stopHub() async {
    try {
      if (hubConnection.state != HubConnectionState.Disconnected) {
        await hubConnection.stop();
      }
    } catch (e) {
      log('NotificationHub Stop Error: $e');
    }
  }
}