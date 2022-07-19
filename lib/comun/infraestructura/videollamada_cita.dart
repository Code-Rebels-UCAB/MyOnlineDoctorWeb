
  class VideollamadaCita {
    final String nombreCanal;
    final String tokenTemp;
    VideollamadaCita({
      required this.nombreCanal,
      required this.tokenTemp
  });

    factory VideollamadaCita.fromJson(Map<String, dynamic> json){
      return VideollamadaCita(
          nombreCanal: json['nombreCanal'],
          tokenTemp: json['tokenTemp']);
    }

}