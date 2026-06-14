import 'dart:developer';
import 'dart:ui';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:stay_match/core/networking/endpoints.dart';
import '../utils/secure_storage_helper.dart';
import '../utils/secure_storage_keys.dart';
import '../utils/service_locator.dart';

class ChatService {
  // Instance variable to hold the persistent connection
  late HubConnection hubConnection;
  final secureStorage = getIt.get<SecureStorageHelper>();

  // Specific loggers for different SignalR layers
  // final _hubLogger = Logger("SignalR - hub");
  // final _transportLogger = Logger("SignalR - transport");

  /// Initializes the Hub and attaches listeners.
  /// [onRefresh] is the callback passed from the Cubit to trigger getInbox().
  Future<void> initHub({VoidCallback? onRefresh}) async {
    // 1. Setup Internal Logging
    // Logger.root.level = Level.ALL;
    // Logger.root.onRecord.listen((LogRecord rec) {
    //   log('${rec.level.name}: ${rec.time}: ${rec.message}');
    // });

    // 2. Retrieve JWT for Authorization
    final token = await secureStorage.readFromSecureStorage(
      key: SecureStorageKeys.tokenKey,
    );

    // 3. Configure Connection Options
    final httpOptions = HttpConnectionOptions(
      // logger: _transportLogger,
      accessTokenFactory: () async => token ?? '',
    );

    // 4. Build the Connection Instance
    hubConnection = HubConnectionBuilder()
        .withUrl(Endpoints.chatHubPath, options: httpOptions)
        // .configureLogging(_hubLogger)
        .withAutomaticReconnect() // Vital for mobile stability
        .build();

    // 5. Register Event Listeners
    _registerListeners(onRefresh);

    // 6. Start the Connection
    try {
      if (hubConnection.state != HubConnectionState.Connected) {
        await hubConnection.start();
        log('SignalR: Connected successfully');
      }
    } catch (e) {
      log('SignalR Start Error: $e');
    }
  }

  void _registerListeners(VoidCallback? onRefresh) {
    // Listens for the backend signal to refresh the conversation list
    hubConnection.on('RefreshChatList', (arguments) {
      log('SignalR: RefreshChatList event received');
      if (onRefresh != null) {
        onRefresh(); // Triggers the "Silent Update" in the Cubit
      }
    });

    // Global listener for new messages
    hubConnection.on('ReceiveMessage', (arguments) {
      log('SignalR: New message received: $arguments');
    });

    // Lifecycle Handlers
    hubConnection.onclose(({error}) => log("SignalR: Connection closed."));
    hubConnection.onreconnecting(({error}) => log("SignalR: Reconnecting..."));
    hubConnection.onreconnected(({connectionId}) => log("SignalR: Reconnected."));
  }

  /// Sends a message to the backend Hub
  Future<void> sendChatMessage(String receiverId, String content) async {
    if (hubConnection.state == HubConnectionState.Connected) {
      try {
        // Ensure 'SendMessage' matches your Backend Hub method name
        await hubConnection.invoke('SendMessage', args: [receiverId, content]);
      } catch (e) {
        log('SignalR Invoke Error: $e');
      }
    } else {
      log('SignalR: Cannot send, hub is ${hubConnection.state}');
    }
  }

  /// Properly closes the socket (Call this during Logout)
  Future<void> stopHub() async {
    try {
      if (hubConnection.state != HubConnectionState.Disconnected) {
        await hubConnection.stop();
        log('SignalR: Hub stopped');
      }
    } catch (e) {
      log('SignalR Stop Error: $e');
    }
  }
}