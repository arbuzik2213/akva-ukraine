class RegionItem {
  final String id;
  final String name;
  final String utilityDescription;
  final List<String> sampleAddresses;

  const RegionItem({
    required this.id,
    required this.name,
    required this.utilityDescription,
    required this.sampleAddresses,
  });

  static const List<RegionItem> allRegions = [
    RegionItem(
      id: 'kyiv_city',
      name: 'Київ',
      utilityDescription: 'ПрАТ «АК «Київводоканал»',
      sampleAddresses: [
        'вул. Голего Миколи, 7В',
        'вул. Хрещатик, 24',
        'просп. Берестейський, 45',
        'вул. Велика Васильківська, 112',
        'просп. Бажана, 16',
      ],
    ),
    RegionItem(
      id: 'vinnytsia_obl',
      name: 'Вінницька область',
      utilityDescription: 'Вінницяоблводоканал • за адресою',
      sampleAddresses: [
        'вул. Соборна, 56, м. Вінниця',
        'вул. Келецька, 89, м. Вінниця',
        'просп. Коцюбинського, 30, м. Вінниця',
      ],
    ),
    RegionItem(
      id: 'volyn_obl',
      name: 'Волинська область',
      utilityDescription: 'Луцькводоканал • за адресою',
      sampleAddresses: [
        'просп. Волі, 14, м. Луцьк',
        'вул. Лесі Українки, 42, м. Луцьк',
      ],
    ),
    RegionItem(
      id: 'dnipro_obl',
      name: 'Дніпропетровська область',
      utilityDescription: 'Дніпроводоканал / Кривбасводоканал',
      sampleAddresses: [
        'просп. Дмитра Яворницького, 64, м. Дніпро',
        'вул. Набережна Перемоги, 32, м. Дніпро',
        'просп. Миру, 28, м. Кривий Ріг',
      ],
    ),
    RegionItem(
      id: 'donetsk_obl',
      name: 'Донецька область',
      utilityDescription: 'Вода Донбасу',
      sampleAddresses: [
        'вул. Центральна, 12, м. Краматорськ',
        'вул. Паркова, 45, м. Слов\'янськ',
      ],
    ),
    RegionItem(
      id: 'zhytomyr_obl',
      name: 'Житомирська область',
      utilityDescription: 'Житомирводоканал',
      sampleAddresses: [
        'вул. Марчуків, 45',
        'вул. Велика Бердичівська, 22, м. Житомир',
        'вул. Київська, 54, м. Житомир',
      ],
    ),
    RegionItem(
      id: 'zakarpattia_obl',
      name: 'Закарпатська область',
      utilityDescription: 'Водоканал м. Ужгород',
      sampleAddresses: [
        'просп. Свободи, 18, м. Ужгород',
        'вул. Корзо, 9, м. Ужгород',
      ],
    ),
    RegionItem(
      id: 'zaporizhzhia_obl',
      name: 'Запорізька область',
      utilityDescription: 'Запоріжводоканал',
      sampleAddresses: [
        'просп. Соборний, 110, м. Запоріжжя',
        'вул. Перемоги, 45, м. Запоріжжя',
      ],
    ),
    RegionItem(
      id: 'ivano_frankivsk_obl',
      name: 'Івано-Франківська область',
      utilityDescription: 'Івано-Франківськводоекотехпром',
      sampleAddresses: [
        'вул. Незалежності, 36, м. Івано-Франківськ',
        'вул. Галицька, 102, м. Івано-Франківськ',
      ],
    ),
    RegionItem(
      id: 'kyiv_obl',
      name: 'Київська область',
      utilityDescription: 'Київводоканал / Броваритепловодоенергія',
      sampleAddresses: [
        'вул. Гагаріна, 15, м. Бровари',
        'вул. Соборна, 88, м. Ірпінь',
        'вул. Ярослава Мудрого, 40, м. Біла Церква',
      ],
    ),
    RegionItem(
      id: 'lviv_obl',
      name: 'Львівська область',
      utilityDescription: 'Львівводоканал • за адресою',
      sampleAddresses: [
        'просп. Свободи, 15, м. Львів',
        'вул. Городоцька, 132, м. Львів',
        'вул. Стрийська, 84, м. Львів',
      ],
    ),
    RegionItem(
      id: 'mykolaiv_obl',
      name: 'Миколаївська область',
      utilityDescription: 'Миколаївводоканал',
      sampleAddresses: [
        'просп. Центральний, 72, м. Миколаїв',
        'вул. Соборна, 14, м. Миколаїв',
      ],
    ),
    RegionItem(
      id: 'odesa_obl',
      name: 'Одеська область',
      utilityDescription: 'Філія «Інфоксводоканал»',
      sampleAddresses: [
        'вул. Дерибасівська, 12, м. Одеса',
        'просп. Шевченка, 4, м. Одеса',
      ],
    ),
    RegionItem(
      id: 'poltava_obl',
      name: 'Полтавська область',
      utilityDescription: 'Полтававодоканал',
      sampleAddresses: [
        'вул. Соборності, 34, м. Полтава',
        'вул. Європейська, 60, м. Полтава',
      ],
    ),
    RegionItem(
      id: 'kharkiv_obl',
      name: 'Харківська область',
      utilityDescription: 'Харківводоканал',
      sampleAddresses: [
        'вул. Сумська, 39, м. Харків',
        'просп. Науки, 25, м. Харків',
      ],
    ),
  ];
}
