enum Sex {
  male,
  female,
  noReply,
}

extension SexExtention on Sex {
  String getValueMappingWithApi() {
    switch (this) {
      case Sex.male:
        return '1';
      case Sex.female:
        return '2';
      case Sex.noReply:
        return '3';
    }
  }
}
