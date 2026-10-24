class LocationSchedule {
  final String id;
  final String label; // "ДІМ", "СЕЛО", "ОФІС", "БАТЬКИ"
  final String queue; // "тиск 3.2 бар" or "черга 15.1"
  final String statusText; // "Вода є", "Води немає", "Знижений тиск"
  final bool hasWater;
  final bool isLowPressure;
  final String nextEventTimeText; // "вимкнуть о 16:00", "увімкнуть о 18:30", "стабільно"
  final String address; // "вул. Голего Миколи, 7В • Київ"
  final String cityId;
  final List<bool> hourlyWaterStatus; // 24 hours (true = water ON, false = outage)

  const LocationSchedule({
    required this.id,
    required this.label,
    required this.queue,
    required this.statusText,
    required this.hasWater,
    this.isLowPressure = false,
    required this.nextEventTimeText,
    required this.address,
    required this.cityId,
    required this.hourlyWaterStatus,
  });

  LocationSchedule copyWith({
    String? id,
    String? label,
    String? queue,
    String? statusText,
    bool? hasWater,
    bool? isLowPressure,
    String? nextEventTimeText,
    String? address,
    String? cityId,
    List<bool>? hourlyWaterStatus,
  }) {
    return LocationSchedule(
      id: id ?? this.id,
      label: label ?? this.label,
      queue: queue ?? this.queue,
      statusText: statusText ?? this.statusText,
      hasWater: hasWater ?? this.hasWater,
      isLowPressure: isLowPressure ?? this.isLowPressure,
      nextEventTimeText: nextEventTimeText ?? this.nextEventTimeText,
      address: address ?? this.address,
      cityId: cityId ?? this.cityId,
      hourlyWaterStatus: hourlyWaterStatus ?? this.hourlyWaterStatus,
    );
  }
}
