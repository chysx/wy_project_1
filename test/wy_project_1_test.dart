import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wy_project_1/wy_project_1.dart';

void main() {
  const MethodChannel channel = MethodChannel('wy_project_1');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await WyProject_1.platformVersion, '42');
  });
}
