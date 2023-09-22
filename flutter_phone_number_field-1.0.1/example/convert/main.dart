void main() {
  String coordinates = "41°18'N 19°49'E";
  double latitude = 0.0;
  double longitude = 0.0;

  // Séparer la chaîne en parties : degrés, minutes, direction
  List<String> parts = coordinates.split(RegExp(r"[°' ]"));

  // Récupérer les valeurs numériques
  int degrees = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);
  String directionLat = parts[2];
  int degreesLon = int.parse(parts[3]);
  int minutesLon = int.parse(parts[4]);
  String directionLon = parts[5];

  // Calcul de la latitude en degrés décimaux
  latitude = degrees + (minutes / 60);
  if (directionLat == 'S') {
    latitude = -latitude;
  }

  // Calcul de la longitude en degrés décimaux
  longitude = degreesLon + (minutesLon / 60);
  if (directionLon == 'W') {
    longitude = -longitude;
  }

  print("Latitude: $latitude");
  print("Longitude: $longitude");
}
