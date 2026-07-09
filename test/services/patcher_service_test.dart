import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_template_appwrite/models/patch_rule.dart';
import 'package:flutter_template_appwrite/models/patcher_config.dart';
import 'package:flutter_template_appwrite/services/patcher_service.dart';

/// Unit tests for [PatcherService] — the pure port of the original
/// MoRPatcher C# console tool's search & replace logic.
void main() {
  const PatcherService service = PatcherService();

  group('parseConfig', () {
    test('parses a valid config with rules and defaults missing fields', () {
      const String jsonString = '''
      {
        "name": "Test config",
        "rules": [
          {
            "name": "Rule A",
            "searchText": "foo",
            "replaceText": "bar"
          }
        ]
      }
      ''';

      final PatcherConfig config = service.parseConfig(jsonString);

      expect(config.name, 'Test config');
      expect(config.version, 1);
      expect(config.rules, hasLength(1));
      expect(config.rules.first.name, 'Rule A');
      // Fields missing in the JSON fall back to their defaults.
      expect(config.rules.first.category, '');
      expect(config.rules.first.isActive, isTrue);
    });

    test('throws a FormatException for invalid JSON', () {
      expect(
        () => service.parseConfig('this is not json'),
        throwsA(isA<FormatException>()),
      );
    });

    test('throws a FormatException when the root is not an object', () {
      expect(
        () => service.parseConfig('[1, 2, 3]'),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('encodeConfig', () {
    test('round-trips a config including isActive states', () {
      const PatcherConfig original = PatcherConfig(
        name: 'Backup',
        rules: <PatchRule>[
          PatchRule(name: 'On', searchText: 'a', replaceText: 'b'),
          PatchRule(
            name: 'Off',
            searchText: 'c',
            replaceText: 'd',
            isActive: false,
          ),
        ],
      );

      final String jsonString = service.encodeConfig(original);
      final PatcherConfig restored = service.parseConfig(jsonString);

      expect(restored, original);
    });
  });

  group('applyPatches', () {
    test('replaces every occurrence and reports the match count', () {
      const PatcherConfig config = PatcherConfig(
        rules: <PatchRule>[
          PatchRule(name: 'Rule', searchText: 'old', replaceText: 'new'),
        ],
      );

      final PatchRunResult result = service.applyPatches(
        htmlContent: 'old text with old value',
        config: config,
      );

      expect(result.patchedContent, 'new text with new value');
      expect(result.results, hasLength(1));
      expect(result.results.first.wasFound, isTrue);
      expect(result.results.first.matchCount, 2);
      expect(result.appliedCount, 1);
    });

    test('reports a rule whose search text is missing as not found', () {
      const PatcherConfig config = PatcherConfig(
        rules: <PatchRule>[
          PatchRule(name: 'Miss', searchText: 'absent', replaceText: 'x'),
        ],
      );

      final PatchRunResult result = service.applyPatches(
        htmlContent: 'some content',
        config: config,
      );

      expect(result.patchedContent, 'some content');
      expect(result.results.first.wasFound, isFalse);
      expect(result.results.first.matchCount, 0);
      expect(result.appliedCount, 0);
    });

    test('skips inactive rules entirely', () {
      const PatcherConfig config = PatcherConfig(
        rules: <PatchRule>[
          PatchRule(
            name: 'Inactive',
            searchText: 'old',
            replaceText: 'new',
            isActive: false,
          ),
        ],
      );

      final PatchRunResult result = service.applyPatches(
        htmlContent: 'old text',
        config: config,
      );

      expect(result.patchedContent, 'old text');
      expect(result.results, isEmpty);
    });

    test(
        'normalizes Windows line endings in search and replace texts '
        '(like the original C# tool)', () {
      // The rule texts use \r\n (as the C# sources did), the game file \n.
      const PatcherConfig config = PatcherConfig(
        rules: <PatchRule>[
          PatchRule(
            name: 'Multiline',
            searchText: 'line1\r\nline2',
            replaceText: 'patched1\r\npatched2',
          ),
        ],
      );

      final PatchRunResult result = service.applyPatches(
        htmlContent: 'before line1\nline2 after',
        config: config,
      );

      expect(result.patchedContent, 'before patched1\npatched2 after');
      expect(result.results.first.matchCount, 1);
    });

    test('treats an empty search text as not found instead of matching', () {
      const PatcherConfig config = PatcherConfig(
        rules: <PatchRule>[
          PatchRule(name: 'Empty', searchText: '', replaceText: 'x'),
        ],
      );

      final PatchRunResult result = service.applyPatches(
        htmlContent: 'content',
        config: config,
      );

      expect(result.patchedContent, 'content');
      expect(result.results.first.wasFound, isFalse);
    });

    test('applies rules in order, so later rules see earlier replacements',
        () {
      const PatcherConfig config = PatcherConfig(
        rules: <PatchRule>[
          PatchRule(name: 'First', searchText: 'a', replaceText: 'b'),
          PatchRule(name: 'Second', searchText: 'b', replaceText: 'c'),
        ],
      );

      final PatchRunResult result = service.applyPatches(
        htmlContent: 'a',
        config: config,
      );

      expect(result.patchedContent, 'c');
    });
  });

  group('countMatches', () {
    test('counts non-overlapping occurrences', () {
      expect(service.countMatches('aaaa', 'aa'), 2);
      expect(service.countMatches('abcabcabc', 'abc'), 3);
      expect(service.countMatches('abc', 'xyz'), 0);
      expect(service.countMatches('', 'a'), 0);
      expect(service.countMatches('abc', ''), 0);
    });
  });
}
