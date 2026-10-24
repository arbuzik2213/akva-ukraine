enum WaterPointType {
  buvette,
  tanker,
  resilienceHub,
}

class WaterPoint {
  final String id;
  final String cityId;
  final String name;
  final String address;
  final WaterPointType type;
  final String workingHours;
  final double distanceKm;
  final bool isOpen;
  final String waterQualityNote;

  const WaterPoint({
    required this.id,
    required this.cityId,
    required this.name,
    required this.address,
    required this.type,
    required this.workingHours,
    required this.distanceKm,
    this.isOpen = true,
    this.waterQualityNote = 'Вода артезіанська, перевірена санепідемстанцією',
  });
}
