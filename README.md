# moru

> **Dieses Projekt basiert auf [`flutter_template_appwrite`](https://github.com/Cocotus/flutter_template_appwrite).**
> Die folgende Anleitung erklärt Schritt für Schritt, wie man aus dem Template eine eigene kleine Flutter-App baut —
> am Beispiel dieses Projekts hier.

---

## TODO / Entwickler-Anleitung: Vom Template zur eigenen App

Diese Anleitung richtet sich an **mittelmäßige Flutter-Entwickler**, die das Template-Repo als Startpunkt verwenden
und daraus ein eigenes Programm (z. B. einen Patcher, ein Verwaltungstool, eine kleine Utility-App) entwickeln wollen.
Alle Schritte bauen aufeinander auf — am besten der Reihe nach abarbeiten.

---

### Schritt 0 — Voraussetzungen

- Flutter SDK installiert (Dart ≥ 3.12)
- Ein Editor (VS Code oder Android Studio / IntelliJ)
- Zugang zu einem [Appwrite Cloud](https://appwrite.io/)-Projekt (oder lokal), falls du die Auth/Datenbank-Features nutzt

---

### Schritt 1 — Repo anlegen und Template klonen

1. Erstelle ein neues leeres GitHub-Repository (z. B. `mein-tool`).
2. Klone das Template lokal:
   ```bash
   git clone https://github.com/Cocotus/flutter_template_appwrite mein-tool
   cd mein-tool
   ```
3. Ändere die Git-Remote auf dein neues Repo:
   ```bash
   git remote set-url origin https://github.com/DEIN_USER/mein-tool
   git push -u origin main
   ```

---

### Schritt 2 — App-Namen und Package-ID ändern

Diese Stellen müssen **überall** auf deinen App-Namen angepasst werden:

| Datei | Was ändern |
|---|---|
| `pubspec.yaml` | `name:` (z. B. `moru`) und `description:` |
| `lib/` — alle `import`-Zeilen | Paketname im Import-Pfad (`flutter_template_appwrite` → `moru`) |
| `android/app/build.gradle` | `applicationId` |
| `windows/runner/Runner.rc` | `ProductName`, `FileDescription` |
| `web/index.html` | `<title>` |
| `web/manifest.json` | `"name"` und `"short_name"` |

**Tipp:** Am schnellsten geht es mit einem globalen Suchen & Ersetzen
(`flutter_template_appwrite` → `moru`) im gesamten Projektordner.
Danach `flutter pub get` ausführen.

---

### Schritt 3 — App-Titel (Fenstertitel / AppBar-Titel)

Der Titel, der oben in der AppBar und im Betriebssystem-Fenstertitel erscheint, steht an zwei Stellen:

1. **`lib/app.dart`** — dort wo `MaterialApp.router` oder `title:` gesetzt wird.
2. **Übersetzungsdateien** (siehe Schritt 5) — der Titel kommt aus dem Lokalisierungskey `appTitle`.

Ändere also in beiden ARB-Dateien den Wert von `"appTitle"`:
```jsonc
// lib/l10n/app_en.arb
"appTitle": "MorPatcher"

// lib/l10n/app_de.arb
"appTitle": "MorPatcher"
```

---

### Schritt 4 — Logo / App-Icon austauschen

Das Template verwendet **eine einzige Quelldatei** für alle Icons (Windows, Web, …):

```
assets/images/logo.png   ← dein Logo hier ablegen (1024×1024 px, PNG)
```

Danach einmalig ausführen:
```bash
dart run flutter_launcher_icons
```

Das überschreibt automatisch alle plattformspezifischen Icons (Windows `.ico`, Web `favicon.png`, …).
Die Konfiguration dafür steht am Ende der `pubspec.yaml` unter `flutter_launcher_icons:`.

**Hinweis:** Linux Desktop Icons werden von diesem Tool *nicht* abgedeckt.
Für Linux muss das Icon separat über eine `.desktop`-Datei beim Paketieren gesetzt werden.

Das Logo-Bild selbst wird auch in der App angezeigt (z. B. auf dem Splash-Screen oder der Login-Seite).
Es wird im Code so eingebunden:
```dart
Image.asset('assets/images/logo.png')
```

---

### Schritt 5 — Sprache: neue Textvariablen hinzufügen

Alle anzuzeigenden Texte gehören **nie direkt** als String-Literal in den Widget-Code,
sondern in die Übersetzungsdateien unter `lib/l10n/`.

**Welche Dateien bearbeiten?**
- `lib/l10n/app_en.arb` — englische Texte (das ist die Template-Datei)
- `lib/l10n/app_de.arb` — deutsche Texte

**Niemals** die `.dart`-Dateien im `l10n`-Ordner bearbeiten!
`app_localizations.dart`, `app_localizations_de.dart` und `app_localizations_en.dart`
sind **automatisch generiert** und werden bei jedem Build überschrieben.
Sie sollten idealerweise in `.gitignore` eingetragen werden.

**Beispiel — neuen Text hinzufügen:**
```jsonc
// lib/l10n/app_en.arb
{
  "@@locale": "en",
  "appTitle": "MorPatcher",
  "patchButtonLabel": "Apply Patch",
  "@patchButtonLabel": {
    "description": "Label on the main patch action button"
  },
  "patchSuccess": "Patch applied successfully!",
  "@patchSuccess": {}
}
```
```jsonc
// lib/l10n/app_de.arb
{
  "@@locale": "de",
  "appTitle": "MorPatcher",
  "patchButtonLabel": "Patch anwenden",
  "patchSuccess": "Patch erfolgreich angewendet!"
}
```

Danach `flutter pub get` (oder einfach speichern — VS Code triggert die Generierung automatisch).
Im Code verwendest du die Texte so:
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// In einer build()-Methode:
final AppLocalizations l10n = AppLocalizations.of(context)!;
Text(l10n.patchButtonLabel)
```

---

### Schritt 6 — Standard-Akzentfarbe ändern

Das Template startet mit einem Blauton als Default-Farbe.
Die **einzige Stelle**, die du ändern musst, ist:

```dart
// lib/theme/app_theme.dart — Zeile 24
static const Color defaultSeedColor = Color(0xFF3D5AFE); // ← hier deine Farbe
```

Daraus leitet das gesamte Material-3-Farbschema (Light, Dark, Sidebar, Buttons usw.) automatisch ab —
du musst **nichts weiter** im Theme anpassen.

**Tipp:** Die Liste der angebotenen Farben in den Einstellungen steht in
`lib/theme/accent_colors.dart`. Der erste Eintrag sollte auf `AppTheme.defaultSeedColor` zeigen:
```dart
// Gut: kein doppelter Farbwert
AccentColor(name: 'Meine Farbe', color: AppTheme.defaultSeedColor),
```

---

### Schritt 7 — Neue View (Seite) anlegen

Eine neue Seite besteht aus mindestens zwei Dateien:

```
lib/views/meine_seite/
  meine_seite_view.dart      ← das Widget (ConsumerWidget, kein StatefulWidget)
  meine_seite_controller.dart ← Riverpod-Notifier (optional, bei eigener Logik)
```

**Beispiel — minimale neue View:**
```dart
// lib/views/patch/patch_view.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatchView extends ConsumerWidget {
  const PatchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patch')),
      body: const Center(child: Text('Hier kommt der Patcher hin')),
    );
  }
}
```

**Dann in `lib/router/app_router.dart` registrieren (Schritt 8).**

---

### Schritt 8 — Neue Route mit go_router hinzufügen

Alle Routen stehen zentral in `lib/router/app_router.dart`.

**8a) Pfad-Konstante ergänzen** (in der Klasse `AppRoutes`):
```dart
/// Die Patcher-Hauptseite.
static const String patch = '/patch';
```

**8b) Route in den Router eintragen:**

Wenn die Seite **innerhalb der authentifizierten Shell** (mit Sidebar) erscheinen soll:
```dart
// In der StatefulShellRoute.indexedStack-Liste:
_buildBranch(talker, AppRoutes.patch, const PatchView()),
```

Wenn die Seite **außerhalb der Shell** (z. B. ein Vollbild-Dialog) erscheinen soll:
```dart
// Außerhalb der StatefulShellRoute, auf gleicher Ebene wie GoRoute(path: AppRoutes.login):
GoRoute(
  path: AppRoutes.patch,
  builder: (BuildContext context, GoRouterState state) {
    return const PatchView();
  },
),
```

**8c) Navigation aufrufen:**
```dart
// Von überall im Code (kein BuildContext-Weitergeben nötig):
context.go(AppRoutes.patch);
// oder
context.push(AppRoutes.patch);   // legt auf dem Stack ab (Back-Button funktioniert)
```

**8d) Navigationseintrag in der Sidebar** (wenn Shell-Route):
Die Sidebar ist in `lib/views/shell/app_shell.dart` definiert.
Dort wird ein neuer `NavigationRailDestination`-Eintrag ergänzt —
**in der gleichen Reihenfolge** wie die `branches`-Liste im Router.

---

### Schritt 9 — Appwrite-Backend konfigurieren

Wenn du Auth oder Datenbank nutzt:

1. Erstelle ein Projekt auf [appwrite.io](https://appwrite.io/).
2. Trage Endpoint und Projekt-ID in die Konfigurationsdatei ein:
   ```
   config/appwrite_config.dart   (oder wie im Template benannt)
   ```
3. Für die Web-Plattform: in Appwrite unter *Platforms* eine Web-Plattform
   mit deiner Domain (z. B. `localhost`) hinzufügen.

---

### Schritt 10 — Codegenerierung ausführen

Nach jeder Änderung an `@freezed`-Modellen oder `@riverpod`-Providern:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Während der Entwicklung praktischer (läuft dauerhaft und generiert bei Speichern neu):
```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

### Checkliste: Neue App aus Template

- [ ] Package-Namen global ersetzt (`flutter_template_appwrite` → eigener Name)
- [ ] `pubspec.yaml`: `name` und `description` angepasst
- [ ] `app_en.arb` und `app_de.arb`: `appTitle` gesetzt
- [ ] `assets/images/logo.png` ausgetauscht (1024×1024 px)
- [ ] `dart run flutter_launcher_icons` ausgeführt
- [ ] `AppTheme.defaultSeedColor` in `app_theme.dart` angepasst
- [ ] `AccentColor`-Standardeintrag in `accent_colors.dart` auf `AppTheme.defaultSeedColor` zeigend
- [ ] Neue Views und Routen angelegt
- [ ] Appwrite-Credentials eingetragen (falls verwendet)
- [ ] Generierte `app_localizations*.dart`-Dateien in `.gitignore` eingetragen
- [ ] `dart run build_runner build` ausgeführt
- [ ] `flutter analyze` ohne Fehler

---

## Bekannte Stolpersteine

### Generierte Dateien im l10n-Ordner

`lib/l10n/app_localizations.dart`, `app_localizations_de.dart` und `app_localizations_en.dart`
werden **automatisch generiert** und sollten nicht von Hand bearbeitet oder dauerhaft ins Git eingecheckt werden.
Nur `app_en.arb` und `app_de.arb` sind echte Quelldateien.

Empfehlung — in `.gitignore` aufnehmen:
```
lib/l10n/app_localizations.dart
lib/l10n/app_localizations_de.dart
lib/l10n/app_localizations_en.dart
```

### Akzentfarbe: nur eine Stelle ändern

Den Default-Farbwert (`0xFF3D5AFE`) gibt es im Template an zwei Stellen
(`app_theme.dart` und `accent_colors.dart`) — das ist redundant.
Beim Anpassen **beide** Stellen synchron halten, bis das Template das konsolidiert.
