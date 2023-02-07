class Address {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final Geo? geo;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> parsedJson) {
    return Address(
      street: parsedJson['street'],
      suite: parsedJson['suite'],
      city: parsedJson['city'],
      zipcode: parsedJson['zipcode'],
      geo: Geo.fromJson(parsedJson['geo']),
    );
  }

  @override
  String toString() {
    return 'Address is on $street street at $suite, in the city of $city,'
        ' with zipcode $zipcode$geo';
  }
}

class Geo {
  final String? lat;
  final String? lng;

  Geo({
    this.lat,
    this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> parsedJson) {
    return Geo(
      lat: parsedJson['lat'],
      lng: parsedJson['lng'],
    );
  }

  @override
  String toString() {
    return '\nGeolocation is at latitude $lat, and longitude $lng';
  }
}
