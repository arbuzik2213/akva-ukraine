enum OutageType {
  planned,
  emergency,
  pressureDrop,
}

enum WaterSupplyStatus {
  normal,
  lowPressure,
  shutOff,
}

class WaterOutage {
  final String id;
  final String cityId;
  final String street;
  final OutageType type;
  final DateTime startTime;
  final DateTime estimatedEndTime;
  final String reason;
  final List<String> affectedAddresses;
  final String utilitySource;
  final bool isResolved;
  final double networkPressureBar;

  const WaterOutage({
    required this.id,
    required this.cityId,
    required this.street,
    required this.type,
    required this.startTime,
    required this.estimatedEndTime,
    required this.reason,
    required this.affectedAddresses,
    required this.utilitySource,
    this.isResolved = false,
    this.networkPressureBar = 0.0,
  });

  bool get isActive {
    final now = DateTime.now();
    return !isResolved && now.isAfter(startTime) && now.isBefore(estimatedEndTime);
  }

  bool get isUpcoming {
    final now = DateTime.now();
    return !isResolved && now.isBefore(startTime);
  }

  Duration get timeUntilStart {
    final now = DateTime.now();
    return startTime.difference(now);
  }

  Duration get timeUntilRestore {
    final now = DateTime.now();
    return estimatedEndTime.difference(now);
  }
}
