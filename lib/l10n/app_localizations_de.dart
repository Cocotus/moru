// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'MoRPatcher';

  @override
  String get welcome => 'Willkommen';

  @override
  String get home => 'Start';

  @override
  String get homeIntro =>
      'Patche deine Masters-of-Raana-start_game.html: Konfiguration importieren, gewünschte Tweaks aktivieren und die gepatchte Datei herunterladen.';

  @override
  String get patcherConfigTitle => 'Patcher-Konfiguration';

  @override
  String get importConfig => 'Konfiguration importieren';

  @override
  String get loadDefaultConfig => 'Standard laden';

  @override
  String get noConfigLoaded =>
      'Importiere deine config_morpatcher.json oder lade die mitgelieferte Standard-Konfiguration.';

  @override
  String configRulesSummary(int activeCount, int totalCount) {
    return '$activeCount von $totalCount Regeln aktiv';
  }

  @override
  String get htmlFileTitle => 'Spiel-HTML-Datei';

  @override
  String get chooseHtmlFile => 'HTML-Datei wählen';

  @override
  String get noHtmlLoaded =>
      'Wähle die start_game.html des Spiels zum Patchen aus.';

  @override
  String get patch => 'Patchen';

  @override
  String get downloadPatched => 'Gepatchte HTML herunterladen';

  @override
  String get backupConfig => 'Konfiguration sichern';

  @override
  String patchRunSummary(int appliedCount, int activeCount) {
    return '$appliedCount von $activeCount aktiven Regeln angewendet';
  }

  @override
  String ruleReplacements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Ersetzungen',
      one: '1 Ersetzung',
    );
    return '$_temp0';
  }

  @override
  String get ruleNotFound => 'Suchtext nicht gefunden';

  @override
  String get invalidConfigFile =>
      'Diese Datei ist keine gültige Patcher-Konfiguration';

  @override
  String get uncategorized => 'Allgemein';

  @override
  String get login => 'Anmelden';

  @override
  String get logout => 'Abmelden';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Passwort';

  @override
  String get settings => 'Einstellungen';

  @override
  String get profile => 'Profil';

  @override
  String get about => 'Über';

  @override
  String get aboutDescription =>
      'MoRPatcher patcht die start_game.html von Masters of Raana mit konfigurierbaren Suchen-und-Ersetzen-Regeln — gebaut mit Riverpod 3, Freezed, go_router, Talker und Appwrite Cloud für Web, Windows und Linux.';

  @override
  String get help => 'Hilfe';

  @override
  String get helpIntro =>
      'Diese Seite ist ein vorbereiteter Platzhalter. Verlinke hier deine Produktdokumentation oder ersetze sie durch eingebettete Hilfe-Inhalte.';

  @override
  String get theme => 'Design';

  @override
  String get language => 'Sprache';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get accentColor => 'Akzentfarbe';

  @override
  String get version => 'Version';

  @override
  String get logs => 'Logs';

  @override
  String get developerMode => 'Entwicklermodus';

  @override
  String get developerModeDescription =>
      'Zeigt die Live-Logansicht in der Seitenleiste';

  @override
  String get demoMode => 'Demomodus';

  @override
  String get demoModeDescription =>
      'App mit Beispieldaten erkunden, ohne Konto';

  @override
  String get demoBadge => 'DEMO';

  @override
  String get save => 'Speichern';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get register => 'Registrieren';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get displayName => 'Anzeigename';

  @override
  String get passwordsDoNotMatch => 'Die Passwörter stimmen nicht überein';

  @override
  String get noAccountRegister => 'Noch kein Konto? Registrieren';

  @override
  String get haveAccountLogin => 'Schon ein Konto? Anmelden';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get resetPasswordSent =>
      'Falls diese E-Mail registriert ist, wurde ein Link zum Zurücksetzen gesendet';

  @override
  String get errorEmailAlreadyExists => 'Diese E-Mail ist bereits registriert';

  @override
  String get errorInvalidCredentials => 'E-Mail oder Passwort ist ungültig';

  @override
  String get errorGeneric =>
      'Etwas ist schiefgelaufen. Bitte versuche es erneut.';

  @override
  String get showPassword => 'Passwort anzeigen';

  @override
  String get hidePassword => 'Passwort verbergen';
}
