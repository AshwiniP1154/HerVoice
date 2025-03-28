import 'package:flutter_test/flutter_test.dart';
import 'package:hervoice_app/main.dart';

void main() {
  testWidgets('HerVoiceApp Widget Test', (WidgetTester tester) async {
    // Build the HerVoiceApp and trigger a frame.
    await tester.pumpWidget(const HerVoiceApp()); // ✅ Corrected

    // Verify that the app displays the expected title.
    expect(find.text('HerVoice'), findsOneWidget);
  });
}
