import 'package:flutter/widgets.dart';

class Sizes {
  //construtor private
  Sizes._();

  double _widht = 0;
  double _height = 0;

  //valor inicial
  static const _designSize = Size(414.0, 896.0);

  static final Sizes _instance = Sizes._();

  //construtor singleton

  factory Sizes() => _instance;

  double get width => _widht;
  double get height => _height;


  //metodo de configuração inicial
  static void init(
    BuildContext context, {
      Size designSize = _designSize,
    }) {
      //verifica se existe dados de MediaQuery
      final deviceData = MediaQuery.of(context);

      //caso não exista, recebe o valor inicial do protótipo
      final deviceSize = deviceData?.size ?? _designSize;

      //atualiza getters
      _instance._height = deviceSize.height;
      _instance._height = deviceSize.width;
    }
}

extension SizeExt on num {
  //Calcula o valor proporcional baseado na largura do disponisivo
  ///em relação ao protótipo
  
 double get w {
  return (this * Sizes._instance.width) / Sizes._designSize.width;
  }

 double get h {
  return (this * Sizes._instance.height) / Sizes._designSize.height;
  }
 }
