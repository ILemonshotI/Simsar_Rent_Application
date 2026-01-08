enum Province {
  damascus("Damascus"),
  aleppo("Aleppo"),
  homs("Homs"),
  rifdimashq("Rif Dimashq"),
  tartous("Tartous"),
  latakia("Latakia");

  final String displayName;
  const Province(this.displayName);
}
extension ProvinceApiMapper on Province {
  static Province fromApi(String? value) {
    if (value == null) return Province.damascus;

    return Province.values.firstWhere(
      (p) => p.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => Province.damascus,
    );
  }
}


enum City {
  // Damascus Cities
  mouhajrin("Mouhajrin", Province.damascus),
  mazzeh("Mazzeh", Province.damascus),
  dummar("Dummar", Province.damascus),
  
  // Aleppo Cities
  shahba("Shahba", Province.aleppo),
  jamiliyah("Jamiliyah", Province.aleppo),
  soleymanye("Soleymanye", Province.aleppo),
  
  // Homs Cities
  waer("Al-Waer", Province.homs),
  hamidiya("Hamidiya", Province.homs),
  alzahraa("Al Zahraa", Province.homs),

  // Rif Dimashq Cities
  douma("Douma", Province.rifdimashq),
  yafour("Yafour", Province.rifdimashq),
  zamalka("Zamalka", Province.rifdimashq),

  // Latakia Cities
  kessab("Kessab", Province.latakia),
  alkournish("Al Kournish", Province.latakia),
  jableh("Jableh", Province.latakia),

  // Tartous Cities
  baniyas("Baniyas", Province.tartous),
  alqadmous("Al Qadmous", Province.tartous),
  safita("Safita", Province.tartous);

  final String displayName;
  final Province province; // The link to the parent enum
  
  const City(this.displayName, this.province);

  // Helper method to get cities for a specific province
  static List<City> getByProvince(Province? province) {
    if (province == null) return [];
    return City.values.where((city) => city.province == province).toList();
  }
}
extension CityApiMapper on City {
  static City fromApi(String? value) {
    if (value == null) return City.mouhajrin;

    return City.values.firstWhere(
      (c) => c.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => City.mouhajrin,
    );
  }
}


enum PropertyType {
  apartment("Apartment"),
  penthouse("Penthouse"),
  hotel("Hotel"),
  villa("Villa");

  final String displayName;
  const PropertyType(this.displayName);
}

extension PropertyTypeApiMapper on PropertyType {
  static PropertyType fromApi(String? value) {
    if (value == null) return PropertyType.apartment;

    return PropertyType.values.firstWhere(
      (t) => t.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => PropertyType.apartment,
    );
  }
}
