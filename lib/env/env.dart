
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField(varName: 'TMDB_KEY')
    static const String key1 = _Env.key1;
}