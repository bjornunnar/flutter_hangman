// using ENVied to generate variables for API keys
// to implement elsewhere, create an .env file at root,
// using the varNames below, then run
// 'dart run build_runner build' to generate the env.g.dart file
// and add both .env and env.g.dart to .gitignore

// in this setup, the .env at root looks like this:
// TMDB_KEY=<string without "">
// TMDB_TOKEN=<string without "">

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField(varName: 'TMDB_KEY')
    static const String key1 = _Env.key1;
    @EnviedField(varName: 'TMDB_TOKEN')
    static const String token = _Env.token;
}