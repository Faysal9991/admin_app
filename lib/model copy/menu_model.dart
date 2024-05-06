// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
    String? name;
    String? details;
  String? id;
    MenuModel({
        this.name,
        this.details,
        this.id
    });

    factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        name: json["name"],
        details: json["details"],
        
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "details": details,
    };
}
