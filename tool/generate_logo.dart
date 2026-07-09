// One-shot generator for assets/images/logo.png (1024x1024).
//
// Draws the MoRPatcher emblem — dark medieval plate, blood-crimson gothic
// "MoR" and a bronze "PATCHER" banner — with the real Flutter engine
// rasterizer. Run it as a test so dart:ui is available:
//
//   flutter test tool/generate_logo.dart
//
// NOTE: uses the Windows system fonts "Old English Text MT" (OLDENGL.TTF)
// and "Century Gothic Bold" (GOTHICB.TTF); on another OS adjust the font
// paths below. This file is intentionally outside test/ so it never runs
// as part of the normal `flutter test` suite.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const double _size = 1024;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('generate assets/images/logo.png', () async {
    await _loadFont('OldEnglish', r'C:\Windows\Fonts\OLDENGL.TTF');
    await _loadFont('CenturyGothicBold', r'C:\Windows\Fonts\GOTHICB.TTF');

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(
      recorder,
      const Rect.fromLTWH(0, 0, _size, _size),
    );

    _drawPlate(canvas);
    _drawBorder(canvas);
    _drawTitle(canvas);
    _drawBanner(canvas);

    final ui.Picture picture = recorder.endRecording();
    final ui.Image image = await picture.toImage(_size.toInt(), _size.toInt());
    final ByteData? pngBytes =
        await image.toByteData(format: ui.ImageByteFormat.png);
    expect(pngBytes, isNotNull);

    final File output = File('assets/images/logo.png');
    output.writeAsBytesSync(pngBytes!.buffer.asUint8List());
    // ignore: avoid_print — this is a CLI tool, not app code.
    print('Wrote ${output.path} (${output.lengthSync()} bytes)');
  });
}

Future<void> _loadFont(String family, String path) async {
  final Uint8List fontData = File(path).readAsBytesSync();
  final FontLoader loader = FontLoader(family);
  loader.addFont(Future<ByteData>.value(ByteData.view(fontData.buffer)));
  await loader.load();
}

// The dark, slightly vignetted background plate with rounded corners.
void _drawPlate(Canvas canvas) {
  final RRect plate = RRect.fromRectAndRadius(
    const Rect.fromLTWH(16, 16, _size - 32, _size - 32),
    const Radius.circular(200),
  );

  final Paint background = Paint()
    ..shader = ui.Gradient.radial(
      const Offset(_size / 2, _size / 2 - 60),
      _size * 0.75,
      <Color>[
        const Color(0xFF33222A),
        const Color(0xFF1B1015),
        const Color(0xFF0E0709),
      ],
      <double>[0.0, 0.55, 1.0],
    );
  canvas.drawRRect(plate, background);
}

// Bronze double border, like a metal fitting around the plate.
void _drawBorder(Canvas canvas) {
  final RRect outer = RRect.fromRectAndRadius(
    const Rect.fromLTWH(30, 30, _size - 60, _size - 60),
    const Radius.circular(188),
  );
  final Paint outerStroke = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 16
    ..shader = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(_size, _size),
      <Color>[
        const Color(0xFFC9A45C),
        const Color(0xFF8C6D3F),
        const Color(0xFFC9A45C),
      ],
      <double>[0.0, 0.5, 1.0],
    );
  canvas.drawRRect(outer, outerStroke);

  final RRect inner = RRect.fromRectAndRadius(
    const Rect.fromLTWH(58, 58, _size - 116, _size - 116),
    const Radius.circular(164),
  );
  final Paint innerStroke = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4
    ..color = const Color(0x668C6D3F);
  canvas.drawRRect(inner, innerStroke);
}

// The gothic "MoR" in blood crimson with a deep drop shadow.
void _drawTitle(Canvas canvas) {
  const String title = 'MoR';
  const double fontSize = 380;

  // Shadow pass first, slightly offset.
  final TextPainter shadowPainter = _titlePainter(
    title,
    fontSize,
    const Color(0xCC000000),
  );
  shadowPainter.paint(
    canvas,
    Offset((_size - shadowPainter.width) / 2 + 10, 170 + 12),
  );

  // Main pass with a vertical crimson gradient.
  final TextPainter titlePainter = _titlePainter(title, fontSize, null);
  titlePainter.paint(
    canvas,
    Offset((_size - titlePainter.width) / 2, 170),
  );
}

TextPainter _titlePainter(String text, double fontSize, Color? flatColor) {
  final Paint? gradientPaint;
  if (flatColor == null) {
    gradientPaint = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(_size / 2, 160),
        const Offset(_size / 2, 660),
        <Color>[
          const Color(0xFFC03040),
          const Color(0xFF8B1E2D),
          const Color(0xFF5E0F1B),
        ],
        <double>[0.0, 0.55, 1.0],
      );
  } else {
    gradientPaint = null;
  }

  final TextPainter painter = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: 'OldEnglish',
        fontSize: fontSize,
        color: flatColor,
        foreground: gradientPaint,
      ),
    ),
    textDirection: TextDirection.ltr,
  );
  painter.layout();
  return painter;
}

// "PATCHER" in bronze caps with flanking flourish lines.
void _drawBanner(Canvas canvas) {
  const double bannerCenterY = 745;

  final TextPainter bannerPainter = TextPainter(
    text: const TextSpan(
      text: 'PATCHER',
      style: TextStyle(
        fontFamily: 'CenturyGothicBold',
        fontSize: 116,
        letterSpacing: 26,
        color: Color(0xFFC9A45C),
      ),
    ),
    textDirection: TextDirection.ltr,
  );
  bannerPainter.layout();
  final double textLeft = (_size - bannerPainter.width) / 2;
  bannerPainter.paint(
    canvas,
    Offset(textLeft, bannerCenterY - bannerPainter.height / 2),
  );

  // Flourish lines with diamond tips on both sides of the word.
  final Paint linePaint = Paint()
    ..color = const Color(0xFF8C6D3F)
    ..strokeWidth = 6;
  const double lineY = bannerCenterY + 4;
  final double leftLineEnd = textLeft - 36;
  final double rightLineStart = textLeft + bannerPainter.width + 20;

  canvas.drawLine(
    const Offset(120, lineY),
    Offset(leftLineEnd, lineY),
    linePaint,
  );
  canvas.drawLine(
    Offset(rightLineStart, lineY),
    const Offset(_size - 120, lineY),
    linePaint,
  );

  _drawDiamond(canvas, Offset(leftLineEnd, lineY));
  _drawDiamond(canvas, Offset(rightLineStart, lineY));
}

void _drawDiamond(Canvas canvas, Offset center) {
  const double radius = 14;
  final Path diamond = Path();
  diamond.moveTo(center.dx, center.dy - radius);
  diamond.lineTo(center.dx + radius, center.dy);
  diamond.lineTo(center.dx, center.dy + radius);
  diamond.lineTo(center.dx - radius, center.dy);
  diamond.close();
  canvas.drawPath(diamond, Paint()..color = const Color(0xFFC9A45C));
}
