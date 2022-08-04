


class Validaciones {

  static bool validarCorreo (String data) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(data);
  }

  static bool validarContrasena (String data) {
    if (data.isEmpty) {
      return false;
    }

    bool tieneMayuscula = data.contains(RegExp(r'[A-Z]'));
    bool longitudAdecuada = data.length >= 8;

    return tieneMayuscula && longitudAdecuada;
  }

}