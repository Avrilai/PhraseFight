import 'package:force/force_serverside.dart';

main() async {
  ForceServer fs = new ForceServer(
      host: '127.0.0.1',
      port: 8080,
      clientFiles: '../build/web/',
      startPage: 'index.html');

  await fs.start();

}
