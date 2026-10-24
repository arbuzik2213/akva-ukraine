class NotificationSetting {
  final bool alert10Min;
  final bool alert30Min;
  final bool alert1Hour;
  final bool alertOnRestore;
  final bool soundEnabled;
  final bool vibrationEnabled;

  const NotificationSetting({
    this.alert10Min = true,
    this.alert30Min = true,
    this.alert1Hour = false,
    this.alertOnRestore = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
  });

  NotificationSetting copyWith({
    bool? alert10Min,
    bool? alert30Min,
    bool? alert1Hour,
    bool? alertOnRestore,
    bool? soundEnabled,
    bool? vibrationEnabled,
  }) {
    return NotificationSetting(
      alert10Min: alert10Min ?? this.alert10Min,
      alert30Min: alert30Min ?? this.alert30Min,
      alert1Hour: alert1Hour ?? this.alert1Hour,
      alertOnRestore: alertOnRestore ?? this.alertOnRestore,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
    );
  }
}
