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

enum PropertyType {
  apartment("Apartment"),
  penthouse("Penthouse"),
  hotel("Hotel"),
  villa("Villa");

  final String displayName;
  const PropertyType(this.displayName);
}