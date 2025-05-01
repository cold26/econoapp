class Validator {
  Validator._();
  
    static String? validateName(String? value) {
      final condition = RegExp(r"^[a-zA-Z]([a-zA-Z]|\.| |-|')+$");
                  if (value != null && value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (value != null && !condition.hasMatch(value)) {
                    return "Nome Invalido. Digite um nome válido.";
                  }
                  
                  return null;
                }

    static String? validateEmail(String? value) {
      final condition = RegExp(r"[a-zA-Z0-9-]{1,}@([a-zA-Z\.])?[a-zA-Z]{1,}\.[a-zA-Z]{1,4}");
                  if (value != null && value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if(value != null && !condition.hasMatch(value)){
                    return "Email Inválido. Digite um email válido.";
                  }
                  
                  return null;
                }

     static String? validatePassword(String? value) {
        final condition = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
                  if (value != null && value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if(value != null && condition.hasMatch(value)){
                    return "Senha Inválida. Digite uma senha válida.";
                  }
                  
                  return null;
                }


        static String? validateConfirmPassword(String? first, String? second ) {
        if(first != second){
          return "As senhas não conferem. Tente novamente.";

        }
                return null;
                }

}


