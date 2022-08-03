

class TokenJwtModelo {
  final String token;

  const TokenJwtModelo({
    required this.token,
  });

  factory TokenJwtModelo.fromJson(Map<String, dynamic> json){
    return TokenJwtModelo(
      token: json['tokenDeAcceso'],
    );
  }
}