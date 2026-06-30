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

// class ChatService {
//   // Instance variable to hold the persistent connection
//   late HubConnection hubConnection;
//   final secureStorage = getIt.get<SecureStorageHelper>();
//
//   // Specific loggers for different SignalR layers
//   // final _hubLogger = Logger("SignalR - hub");
//   // final _transportLogger = Logger("SignalR - transport");
//
//   /// Initializes the Hub and attaches listeners.
//   /// [onRefresh] is the callback passed from the Cubit to trigger getInbox().
//   Future<void> initHub({VoidCallback? onRefresh}) async {
//     // 1. Setup Internal Logging
//     // Logger.root.level = Level.ALL;
//     // Logger.root.onRecord.listen((LogRecord rec) {
//     //   log('${rec.level.name}: ${rec.time}: ${rec.message}');
//     // });
//
//     // 2. Retrieve JWT for Authorization
//     final token = await secureStorage.readFromSecureStorage(
//       key: SecureStorageKeys.tokenKey,
//     );
//
//     // 3. Configure Connection Options
//     final httpOptions = HttpConnectionOptions(
//       // logger: _transportLogger,
//       accessTokenFactory: () async => token ?? '',
//     );
//
//     // 4. Build the Connection Instance
//     hubConnection = HubConnectionBuilder()
//         .withUrl(Endpoints.chatHubPath, options: httpOptions)
//         // .configureLogging(_hubLogger)
//         .withAutomaticReconnect() // Vital for mobile stability
//         .build();
//
//     // 5. Register Event Listeners
//     _registerListeners(onRefresh);
//
//     // 6. Start the Connection
//     try {
//       if (hubConnection.state != HubConnectionState.Connected) {
//         await hubConnection.start();
//         log('SignalR: Connected successfully');
//       }
//     } catch (e) {
//       log('SignalR Start Error: $e');
//     }
//   }
//
//   void _registerListeners(VoidCallback? onRefresh) {
//     // Listens for the backend signal to refresh the conversation list
//     hubConnection.on('RefreshChatList', (arguments) {
//       log('SignalR: RefreshChatList event received');
//       if (onRefresh != null) {
//         onRefresh(); // Triggers the "Silent Update" in the Cubit
//       }
//     });
//
//     // Global listener for new messages
//     hubConnection.on('ReceiveMessage', (arguments) {
//       log('SignalR: New message received: $arguments');
//     });
//
//     // Lifecycle Handlers
//     hubConnection.onclose(({error}) => log("SignalR: Connection closed."));
//     hubConnection.onreconnecting(({error}) => log("SignalR: Reconnecting..."));
//     hubConnection.onreconnected(({connectionId}) => log("SignalR: Reconnected."));
//   }
//
//   /// Sends a message to the backend Hub
//   Future<void> sendChatMessage(String receiverId, String content) async {
//     if (hubConnection.state == HubConnectionState.Connected) {
//       try {
//         // Ensure 'SendMessage' matches your Backend Hub method name
//         await hubConnection.invoke('SendMessage', args: [receiverId, content]);
//       } catch (e) {
//         log('SignalR Invoke Error: $e');
//       }
//     } else {
//       log('SignalR: Cannot send, hub is ${hubConnection.state}');
//     }
//   }
//
//   /// Properly closes the socket (Call this during Logout)
//   Future<void> stopHub() async {
//     try {
//       if (hubConnection.state != HubConnectionState.Disconnected) {
//         await hubConnection.stop();
//         log('SignalR: Hub stopped');
//       }
//     } catch (e) {
//       log('SignalR Stop Error: $e');
//     }
//   }
// }
// class ChatService {
//   late HubConnection hubConnection;
//   final secureStorage = getIt.get<SecureStorageHelper>();
//
//   bool _isConnected = false; // ← guard flag
//
//   Future<void> initHub({VoidCallback? onRefresh}) async {
//     if (_isConnected) {
//       // Already connected — just register the new listener
//       _registerListeners(onRefresh);
//       return;
//     }
//
//     final token = await secureStorage.readFromSecureStorage(
//       key: SecureStorageKeys.tokenKey,
//     );
//
//     final httpOptions = HttpConnectionOptions(
//       accessTokenFactory: () async => token ?? '',
//     );
//
//     hubConnection = HubConnectionBuilder()
//         .withUrl(Endpoints.chatHubPath, options: httpOptions)
//         .withAutomaticReconnect()
//         .build();
//
//     _registerListeners(onRefresh);
//
//     try {
//       if (hubConnection.state != HubConnectionState.Connected) {
//         await hubConnection.start();
//         _isConnected = true;
//         log('SignalR: Connected successfully');
//       }
//     } catch (e) {
//       log('SignalR Start Error: $e');
//     }
//   }
//
//   void _registerListeners(VoidCallback? onRefresh) {
//     // Each cubit registers its own named callback — avoid duplicates
//     hubConnection.off('RefreshChatList');
//     hubConnection.on('RefreshChatList', (arguments) {
//       log('SignalR: RefreshChatList received');
//       onRefresh?.call();
//     });
//
//     hubConnection.off('ReceiveMessage');
//     hubConnection.on('ReceiveMessage', (arguments) {
//       log('SignalR: ReceiveMessage: $arguments');
//       onRefresh?.call();
//     });
//
//     hubConnection.onclose(({error}) {
//       log("SignalR: Closed.");
//       _isConnected = false; // allow reconnect attempt
//     });
//     hubConnection.onreconnecting(({error}) => log("SignalR: Reconnecting..."));
//     hubConnection.onreconnected(({connectionId}) => log("SignalR: Reconnected."));
//   }
//   void registerMessageListener(VoidCallback onRefresh) {
//     hubConnection.off('ReceiveMessage');
//     hubConnection.on('ReceiveMessage', (_) {
//       log('SignalR: ReceiveMessage → refreshing messages');
//       onRefresh();
//     });
//   }
//
//   void unregisterMessageListener() {
//     hubConnection.off('ReceiveMessage');
//   }
//   Future<void> stopHub() async {
//     try {
//       if (hubConnection.state != HubConnectionState.Disconnected) {
//         await hubConnection.stop();
//         _isConnected = false;
//         log('SignalR: Hub stopped');
//       }
//     } catch (e) {
//       log('SignalR Stop Error: $e');
//     }
//   }
// }

// import 'dart:developer';
// import 'dart:ui';
// import 'package:signalr_netcore/http_connection_options.dart';
// import 'package:signalr_netcore/hub_connection.dart';
// import 'package:signalr_netcore/hub_connection_builder.dart';
// import 'package:stay_match/core/networking/endpoints.dart';
// import '../utils/secure_storage_helper.dart';
// import '../utils/secure_storage_keys.dart';
// import '../utils/service_locator.dart';
//
// class ChatService {
//   // 💡 1. Convert from 'late' to safe nullable type to prevent initialization crashes.
//   HubConnection? _hubConnection;
//
//   // Track precise state stages to eliminate concurrency race conditions.
//   bool _isConnecting = false;
//
//   final secureStorage = getIt.get<SecureStorageHelper>();
//
//   /// Safely returns the current lifecycle status of the SignalR instance.
//   HubConnectionState get currentState {
//     return _hubConnection?.state ?? HubConnectionState.Disconnected;
//   }
//
//   Future<void> initHub({VoidCallback? onRefresh}) async {
//     // If already connected, re-bind listeners and exit early.
//     if (_hubConnection != null && currentState == HubConnectionState.Connected) {
//       log('📡 [SignalR] Already connected. Re-binding listeners.');
//       _registerListeners(onRefresh);
//       return;
//     }
//
//     // Prevents duplicate connection attempts if double-triggered rapidly.
//     if (_isConnecting) {
//       log('⏳ [SignalR] Connection setup already in progress. Skipping duplicate invocation.');
//       return;
//     }
//     _isConnecting = true;
//
//     try {
//       final token = await secureStorage.readFromSecureStorage(
//         key: SecureStorageKeys.tokenKey,
//       );
//
//       final httpOptions = HttpConnectionOptions(
//         accessTokenFactory: () async => token ?? '',
//       );
//
//       _hubConnection = HubConnectionBuilder()
//           .withUrl(Endpoints.chatHubPath, options: httpOptions)
//           .withAutomaticReconnect()
//           .build();
//
//       _registerListeners(onRefresh);
//
//       if (currentState != HubConnectionState.Connected) {
//         await _hubConnection!.start();
//         log('📡 [SignalR] Connected successfully');
//       }
//     } catch (e) {
//       log('❌ [SignalR] Initialization/Start Error: $e');
//       _hubConnection = null; // Clean state on failure
//     } finally {
//       _isConnecting = false;
//     }
//   }
//
//   void _registerListeners(VoidCallback? onRefresh) {
//     if (_hubConnection == null) return;
//
//     // Safely unbind previous handles to avoid duplicate streaming side-effects
//     _hubConnection!.off('RefreshChatList');
//     _hubConnection!.on('RefreshChatList', (arguments) {
//       log('🔄 [SignalR] RefreshChatList received');
//       onRefresh?.call();
//     });
//
//     _hubConnection!.off('ReceiveMessage');
//     _hubConnection!.on('ReceiveMessage', (arguments) {
//       log('📩 [SignalR] ReceiveMessage received: $arguments');
//       onRefresh?.call();
//     });
//
//     _hubConnection!.onclose(({error}) {
//       log("🔌 [SignalR] Connection closed.");
//     });
//
//     _hubConnection!.onreconnecting(({error}) => log("🔄 [SignalR] Reconnecting..."));
//     _hubConnection!.onreconnected(({connectionId}) => log("✨ [SignalR] Reconnected."));
//   }
//
//   /// Registers individual view message observers cleanly
//   void registerMessageListener(VoidCallback onRefresh) {
//     if (_hubConnection != null) {
//       _hubConnection!.off('ReceiveMessage');
//       _hubConnection!.on('ReceiveMessage', (_) {
//         log('📩 [SignalR] Custom view message consumer triggered.');
//         onRefresh();
//       });
//     } else {
//       log('⚠️ [SignalR] Cannot register message listener: Connection instance is null.');
//     }
//   }
//
//   /// 💡 Safely unbinds a specific event target without risking late pointer crashes
//   void unregisterMessageListener() {
//     try {
//       _hubConnection?.off('ReceiveMessage');
//       log('🧹 [SignalR] Cleanly unbound ReceiveMessage consumer.');
//     } catch (e) {
//       log('❌ [SignalR] Error unregistering listener: $e');
//     }
//   }
//
//   /// Terminates the socket safely (e.g., during explicit User Sign-out profiles)
//   Future<void> stopHub() async {
//     try {
//       if (_hubConnection != null && currentState != HubConnectionState.Disconnected) {
//         await _hubConnection!.stop();
//         log('🛑 [SignalR] Hub stopped manually.');
//       }
//     } catch (e) {
//       log('❌ [SignalR] Error while shutting down hub: $e');
//     } finally {
//       _hubConnection = null;
//     }
//   }
// }
import 'dart:developer';
import 'dart:ui';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:stay_match/core/networking/endpoints.dart';
import '../utils/secure_storage_helper.dart';
import '../utils/secure_storage_keys.dart';
import '../utils/service_locator.dart';

class ChatService {
  HubConnection? _hubConnection;
  bool _isConnecting = false;

  // 💡 Global registry to manage multiple listeners concurrently
  final List<VoidCallback> _refreshListeners = [];

  final secureStorage = getIt.get<SecureStorageHelper>();

  HubConnectionState get currentState {
    return _hubConnection?.state ?? HubConnectionState.Disconnected;
  }

  /// Adds a listener to the registry
  void addRefreshListener(VoidCallback callback) {
    if (!_refreshListeners.contains(callback)) {
      _refreshListeners.add(callback);
      log('➕ [SignalR Service] Registered listener. Total observers: ${_refreshListeners.length}');
    }
  }

  /// Removes a listener from the registry to prevent memory leaks
  void removeRefreshListener(VoidCallback callback) {
    _refreshListeners.remove(callback);
    log('➖ [SignalR Service] Unregistered listener. Total observers: ${_refreshListeners.length}');
  }

  Future<void> initHub({VoidCallback? onRefresh}) async {
    // If a legacy callback is provided, attach it immediately to our multi-listener framework
    if (onRefresh != null) {
      addRefreshListener(onRefresh);
    }

    if (_hubConnection != null && currentState == HubConnectionState.Connected) {
      return;
    }

    if (_isConnecting) return;
    _isConnecting = true;

    try {
      final token = await secureStorage.readFromSecureStorage(
        key: SecureStorageKeys.tokenKey,
      );

      final httpOptions = HttpConnectionOptions(
        accessTokenFactory: () async => token ?? '',
      );

      _hubConnection = HubConnectionBuilder()
          .withUrl(Endpoints.chatHubPath, options: httpOptions)
          .withAutomaticReconnect()
          .build();

      _registerNativeListeners();

      if (currentState != HubConnectionState.Connected) {
        await _hubConnection!.start();
        log('SignalR: Connected successfully');
      }
    } catch (e) {
      log('SignalR Start Error: $e');
      _hubConnection = null;
    } finally {
      _isConnecting = false;
    }
  }

  void _registerNativeListeners() {
    if (_hubConnection == null) return;

    _hubConnection!.off('RefreshChatList');
    _hubConnection!.on('RefreshChatList', (arguments) {
      log('SignalR: RefreshChatList received');
      _broadcastUpdate();
    });

    _hubConnection!.off('ReceiveMessage');
    _hubConnection!.on('ReceiveMessage', (arguments) {
      log('SignalR: ReceiveMessage: $arguments');
      _broadcastUpdate();
    });

    _hubConnection!.onclose(({error}) {
      log("SignalR: Closed.");
    });
  }

  void _broadcastUpdate() {
    final activeObservers = List<VoidCallback>.from(_refreshListeners);
    for (final callback in activeObservers) {
      try {
        callback();
      } catch (e) {
        log('❌ [SignalR Service] Broadcast callback error: $e');
      }
    }
  }

  // Legacy fallback support for old cleanups
  void disposeReceiveListener() {
    // Handled dynamically via removeRefreshListener inside the cubits
  }

  Future<void> stopHub() async {
    try {
      if (_hubConnection != null && currentState != HubConnectionState.Disconnected) {
        await _hubConnection!.stop();
        log('SignalR: Hub stopped');
      }
    } catch (e) {
      log('SignalR Stop Error: $e');
    } finally {
      _hubConnection = null;
      _refreshListeners.clear();
    }
  }
}