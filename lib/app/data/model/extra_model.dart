
class ExtraModel {
  String title;
  String img;
  String desc;
  //TODO: Implement unidade de medida comumente usada(Tentar limitar a quantidade)
  //TODO: Quantidade dos extras (Ex: brocolis 2 unidades)

  ExtraModel({this.title, this.img, this.desc});

  ExtraModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    img = json['img'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['img'] = this.img;
    data['desc'] = this.desc;
    return data;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ExtraModel &&
      o.title == title &&
      o.img == img &&
      o.desc == desc;
  }

  @override
  int get hashCode => title.hashCode ^ img.hashCode ^ desc.hashCode;
}


/*

  static String unidadeToString(UnidadeType u, int a) {
    switch (u) {
      case UnidadeType.colher:
        return (a > 1) ? 'colheres' : 'colher';
      case UnidadeType.copo:
        return (a > 1) ? 'copos' : 'copo';
      case UnidadeType.porcao:
        return (a > 1) ? 'porções' : 'porção';
      case UnidadeType.unidade:
        return (a > 1) ? 'unidades' : 'unidade';
      case UnidadeType.xicara:
        return (a > 1) ? 'xícaras' : 'xícara';
      default:
        return null;
    }
  }
}

enum UnidadeType {
  porcao,
  unidade,
  colher,
  xicara,
  copo,
}
*/