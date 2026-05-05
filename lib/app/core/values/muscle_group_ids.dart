class MuscleGroupIds {
  static const Map<String, String> nameToId = {
    "Abdominals": "69d982ed85f6bfa972bf2218",
    "Glutes": "69d982ed85f6bfa972bf221a",
    "Chest": "69d982ed85f6bfa972bf2220",
    "Shoulders": "69d982ed85f6bfa972bf2224",
    "Back": "69d982ee85f6bfa972bf2226",
    "Adductors": "69d982ee85f6bfa972bf222a",
    "Biceps": "69d982ee85f6bfa972bf222c",
    "Quadriceps": "69d982ee85f6bfa972bf222e",
    "Hamstrings": "69d982ee85f6bfa972bf2230",
    "Abductors": "69d982ee85f6bfa972bf2232",
    "Trapezius": "69d982ee85f6bfa972bf2234",
    "Triceps": "69d982ee85f6bfa972bf2236",
    "Forearms": "69d982ee85f6bfa972bf2238",
    "Calves": "69d982ef85f6bfa972bf223e",
    "Shins": "69d982ef85f6bfa972bf2240",
    "Hip Flexors": "69d982ef85f6bfa972bf2244",
    "Trapezius ": "69d982ef85f6bfa972bf2246",
  };

  static String? getId(String? name) {
    if (name == null) return null;
    return nameToId[name] ?? nameToId[name.trim()];
  }
}
