import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoer/firebase_options.dart';
import 'package:todoer/src/data/auth_api.dart';
import 'package:todoer/src/epics/app_epics.dart';
import 'package:todoer/src/models/index.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:todoer/src/presentation/home.dart';
import 'package:todoer/src/presentation/register_page.dart';
import 'package:todoer/src/reducer/reducer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final AuthApi authApi = AuthApi(auth: FirebaseAuth.instance);
  final AppEpics epics = AppEpics(authApi: authApi);

  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epics.epic),
    ]
  );

  runApp(TodoApp(store: store,));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key, required this.store});

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          theme: ThemeData(
            textTheme: GoogleFonts.varelaRoundTextTheme(
              Theme.of(context).textTheme,
            )
          ),
          title: 'ToDo-er',
          routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => const Home(),
            '/register': (BuildContext context) => const RegisterPage(),
          },
        ),
    );
  }
}
