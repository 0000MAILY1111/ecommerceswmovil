import 'package:admin_dashboard/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/api/CafeApi.dart';
// 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
// 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:firebase_core/firebase_core.dart';

 
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

await NotificationsBloc.initializeFCM();

  await LocalStorage.configurePrefs();
  CafeApi.configureDio();
  
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  Flurorouter.configureRoutes();
  runApp(AppState());
}
 
class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       // BlocProvider(create: (_) => NotificationsBloc()),

        ChangeNotifierProvider(lazy: false, create: ( _ ) => AuthProvider() ),
        ChangeNotifierProvider(lazy: false, create: ( _ ) => SideMenuProvider() ),
        ChangeNotifierProvider(create: ( _ ) => CategoriesProvider() ),
        ChangeNotifierProvider(create: ( _ ) => UsersProvider() ),
        ChangeNotifierProvider(create: ( _ ) => UserFormProvider() ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca Dominica',
      initialRoute: '/',
      
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: ( _ , child ){
        
        final authProvider = Provider.of<AuthProvider>(context);

        if ( authProvider.authStatus == AuthStatus.checking )
          return SplashLayout();

        if( authProvider.authStatus == AuthStatus.authenticated ) {
         return DashboardLayout( child: child! );
        } else {
          return AuthLayout( child: child! );
         }
              // ignore: dead_code
              return AuthLayout( child: child );

      },
     
    );
  }
}


class HandleNotificationInteractions extends StatefulWidget {
  
  final Widget child;
  const HandleNotificationInteractions({super.key, required this.child});

  @override
  State<HandleNotificationInteractions> createState() => _HandleNotificationInteractionsState();
}

class _HandleNotificationInteractionsState extends State<HandleNotificationInteractions> {

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
  
  void _handleMessage(RemoteMessage message) {

    context.read<NotificationsBloc>()
      .handleRemoteMessage(message);

    // ignore: unused_local_variable
    final messageId = message.messageId?.replaceAll(':', '').replaceAll('%', '');
    print('Handling a background message ${message.messageId}');
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
