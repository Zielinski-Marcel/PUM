import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/network/http_client.dart';


final httpClientProvider = Provider<HttpClient>((ref) {
  final baseUrl = dotenv.env['API_URL']!;
  return HttpClient(baseUrl: baseUrl);
});
