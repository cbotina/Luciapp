enum Gender { male, female, nonBinary }

extension FromString on String {
  Gender toGender() {
    switch (this) {
      case "Gender.male":
        return Gender.male;
      case "Gender.female":
        return Gender.female;
      case "Gender.nonBinary":
        return Gender.nonBinary;
      default:
        return Gender.male;
    }
  }
}
