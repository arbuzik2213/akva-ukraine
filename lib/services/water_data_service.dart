import 'dart:async';
import '../models/city.dart';
import '../models/outage.dart';
import '../models/water_point.dart';

class WaterDataService {
  // Simulates live network fetch with fallback to open municipal cache
  Future<List<WaterOutage>> fetchOutagesForCity(String cityId) async {
    // Artificial small delay for network realism
    await Future.delayed(const Duration(milliseconds: 350));
    final now = DateTime.now();

    if (cityId == 'kyiv') {
      return [
        WaterOutage(
          id: 'kyiv-out-101',
          cityId: 'kyiv',
          street: 'вул. Хрещатик, 24',
          type: OutageType.emergency,
          startTime: now.subtract(const Duration(hours: 1, minutes: 20)),
          estimatedEndTime: now.add(const Duration(hours: 2, minutes: 40)),
          reason: 'Локалізація аварійного витоку на чавунному водогоні Д=300 мм. Працює аварійна бригада №4.',
          affectedAddresses: [
            'вул. Хрещатик, 20, 22, 24, 26',
            'вул. Прорізна, 3, 5',
            'вул. Архітектора Городецького, 9',
          ],
          utilitySource: 'Диспетчерська Київводоканал (1581) & Портал 1551',
          networkPressureBar: 0.0,
        ),
        WaterOutage(
          id: 'kyiv-out-102',
          cityId: 'kyiv',
          street: 'вул. Велика Васильківська, 112',
          type: OutageType.pressureDrop,
          startTime: now.add(const Duration(minutes: 45)),
          estimatedEndTime: now.add(const Duration(hours: 4)),
          reason: 'Знеструмлення підвищувальної насосної станції (ПНС-14). Можливе зниження тиску вище 5-го поверху.',
          affectedAddresses: [
            'вул. Велика Васильківська, 108-116',
            'вул. Німецька, 3-7',
          ],
          utilitySource: 'Служба моніторингу тиску Київенерго/Водоканал',
          networkPressureBar: 1.2,
        ),
        WaterOutage(
          id: 'kyiv-out-103',
          cityId: 'kyiv',
          street: 'просп. Перемоги (Берестейський), 45',
          type: OutageType.planned,
          startTime: DateTime(now.year, now.month, now.day + 1, 9, 0),
          estimatedEndTime: DateTime(now.year, now.month, now.day + 1, 17, 0),
          reason: 'Планова заміна запірної арматури Д=400 мм на розподільчій камері.',
          affectedAddresses: [
            'просп. Берестейський, 41-49',
            'вул. Смоленська, 4, 6',
          ],
          utilitySource: 'План капітальних ремонтів ПрАТ «АК «Київводоканал»',
          networkPressureBar: 0.0,
        ),
      ];
    } else if (cityId == 'lviv') {
      return [
        WaterOutage(
          id: 'lviv-out-201',
          cityId: 'lviv',
          street: 'вул. Городоцька, 132',
          type: OutageType.emergency,
          startTime: now.subtract(const Duration(minutes: 30)),
          estimatedEndTime: now.add(const Duration(hours: 3)),
          reason: 'Ліквідація пориву на магістральному водогоні "Винники-Львів".',
          affectedAddresses: ['вул. Городоцька, 120-140', 'вул. Патона, 2-12'],
          utilitySource: 'Гаряча лінія міста Львова 1580 / Львівводоканал',
          networkPressureBar: 0.0,
        ),
        WaterOutage(
          id: 'lviv-out-202',
          cityId: 'lviv',
          street: 'вул. Стрийська, 84',
          type: OutageType.pressureDrop,
          startTime: now.add(const Duration(hours: 1)),
          estimatedEndTime: now.add(const Duration(hours: 5)),
          reason: 'Регламентні роботи на насосній станції другого підйому "Сокільники".',
          affectedAddresses: ['вул. Стрийська, 70-98', 'вул. Наукова, 1-15'],
          utilitySource: 'ЛКП «Львівводоканал»',
          networkPressureBar: 1.4,
        ),
      ];
    } else if (cityId == 'dnipro') {
      return [
        WaterOutage(
          id: 'dnipro-out-301',
          cityId: 'dnipro',
          street: 'вул. Набережна Перемоги, 32',
          type: OutageType.emergency,
          startTime: now.subtract(const Duration(hours: 2)),
          estimatedEndTime: now.add(const Duration(hours: 1, minutes: 30)),
          reason: 'Проведення аварійно-відновлювальних робіт на водогоні Д=500 мм.',
          affectedAddresses: ['ж/м Перемога-1, буд. 28-36'],
          utilitySource: 'КП «Дніпроводоканал» Оперативна диспетчерська',
          networkPressureBar: 0.0,
        ),
      ];
    } else {
      // Generic template for any other Ukrainian city
      return [
        WaterOutage(
          id: '$cityId-out-default',
          cityId: cityId,
          street: 'Центральний район',
          type: OutageType.planned,
          startTime: DateTime(now.year, now.month, now.day + 1, 10, 0),
          estimatedEndTime: DateTime(now.year, now.month, now.day + 1, 16, 0),
          reason: 'Профілактичне промивання та дезінфекція міських водопровідних мереж.',
          affectedAddresses: ['Центральні міські квартали'],
          utilitySource: 'Офіційний портал міської ради та водоканалу',
          networkPressureBar: 0.0,
        ),
      ];
    }
  }

  // Generate 24-hour slot data (status for each hour 00..23)
  List<Map<String, dynamic>> generate24HourTimeline(List<WaterOutage> outages) {
    final now = DateTime.now();
    final List<Map<String, dynamic>> timeline = [];

    for (int hour = 0; hour < 24; hour++) {
      final slotTime = DateTime(now.year, now.month, now.day, hour, 0);
      
      // Determine if there is an outage active at this hour
      WaterSupplyStatus status = WaterSupplyStatus.normal;
      String note = 'Тиск 3.2 бар';

      for (final outage in outages) {
        if (slotTime.isAfter(outage.startTime.subtract(const Duration(minutes: 30))) &&
            slotTime.isBefore(outage.estimatedEndTime)) {
          if (outage.type == OutageType.pressureDrop) {
            status = WaterSupplyStatus.lowPressure;
            note = 'Знижений тиск (1.2 бар)';
          } else {
            status = WaterSupplyStatus.shutOff;
            note = 'Відключення: ${outage.type == OutageType.emergency ? "Аварія" : "Ремонт"}';
          }
          break;
        }
      }

      timeline.add({
        'hour': hour,
        'label': '${hour.toString().padLeft(2, '0')}:00',
        'status': status,
        'note': note,
        'isCurrentHour': now.hour == hour,
      });
    }

    return timeline;
  }

  // Fetch nearby water points (buvettes, water trucks, resilience points)
  Future<List<WaterPoint>> fetchWaterPoints(String cityId) async {
    await Future.delayed(const Duration(milliseconds: 150));

    if (cityId == 'kyiv') {
      return const [
        WaterPoint(
          id: 'bp-kyiv-1',
          cityId: 'kyiv',
          name: 'Артезіанський бювет «Хрещатик»',
          address: 'вул. Хрещатик / вул. Архітектора Городецького, 4',
          type: WaterPointType.buvette,
          workingHours: '06:00 - 22:00',
          distanceKm: 0.25,
          isOpen: true,
          waterQualityNote: 'Глибина свердловини 290м (Юрський горизонт). Вода перевірена.',
        ),
        WaterPoint(
          id: 'bp-kyiv-2',
          cityId: 'kyiv',
          name: 'Чергова автоцистерна Київводоканал',
          address: 'вул. Прорізна, 8 (біля скверу)',
          type: WaterPointType.tanker,
          workingHours: '08:00 - 21:00 (на час ремонту)',
          distanceKm: 0.45,
          isOpen: true,
          waterQualityNote: 'Питна сертифікована вода. Роздача безкоштовна.',
        ),
        WaterPoint(
          id: 'bp-kyiv-3',
          cityId: 'kyiv',
          name: 'Пункт Незламності та резервуар',
          address: 'вул. Богдана Хмельницького, 15 (Гімназія №86)',
          type: WaterPointType.resilienceHub,
          workingHours: 'Цілодобово 24/7',
          distanceKm: 0.70,
          isOpen: true,
          waterQualityNote: 'Генератор, резервуар 5000л питної води, підзарядка.',
        ),
        WaterPoint(
          id: 'bp-kyiv-4',
          cityId: 'kyiv',
          name: 'Бюветний комплекс «Володимирська гірка»',
          address: 'парк Володимирська Гірка (біля фунікулера)',
          type: WaterPointType.buvette,
          workingHours: '07:00 - 21:30',
          distanceKm: 0.95,
          isOpen: true,
          waterQualityNote: 'Сеноманський горизонт, природна мінералізація.',
        ),
      ];
    } else if (cityId == 'lviv') {
      return const [
        WaterPoint(
          id: 'bp-lviv-1',
          cityId: 'lviv',
          name: 'Міський пункт роздачі води',
          address: 'вул. Городоцька, 110',
          type: WaterPointType.tanker,
          workingHours: '08:00 - 20:00',
          distanceKm: 0.3,
          isOpen: true,
          waterQualityNote: 'Питна вода з резервуарів Львівводоканалу.',
        ),
        WaterPoint(
          id: 'bp-lviv-2',
          cityId: 'lviv',
          name: 'Пункт Незламності Залізничного району',
          address: 'вул. Патона, 5',
          type: WaterPointType.resilienceHub,
          workingHours: '24/7',
          distanceKm: 0.8,
          isOpen: true,
          waterQualityNote: 'Питна та технічна вода, генератор.',
        ),
      ];
    } else {
      return const [
        WaterPoint(
          id: 'bp-gen-1',
          cityId: 'all',
          name: 'Міський артезіанський бювет',
          address: 'Центральний міський парк',
          type: WaterPointType.buvette,
          workingHours: '07:00 - 22:00',
          distanceKm: 0.5,
          isOpen: true,
          waterQualityNote: 'Контрольована питна вода високої якості.',
        ),
        WaterPoint(
          id: 'bp-gen-2',
          cityId: 'all',
          name: 'Пункт Незламності та питна вода',
          address: 'вул. Соборна, 22',
          type: WaterPointType.resilienceHub,
          workingHours: '24/7',
          distanceKm: 0.85,
          isOpen: true,
          waterQualityNote: 'Резервуар питної води, автономне живлення.',
        ),
      ];
    }
  }
}
