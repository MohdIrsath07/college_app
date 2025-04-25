import 'package:cloud_firestore/cloud_firestore.dart';

class HostelMenuModel {
  final String id;
  final List<DailyMenu> weekMenu;
  final String hostelName;
  final DateTime validFrom;
  final DateTime validUntil;

  HostelMenuModel({
    required this.id,
    required this.weekMenu,
    required this.hostelName,
    required this.validFrom,
    required this.validUntil,
  });

  factory HostelMenuModel.fromJson(Map<String, dynamic> json) {
    List<DailyMenu> menuList = [];
    if (json['weekMenu'] != null) {
      menuList = (json['weekMenu'] as List)
          .map((day) => DailyMenu.fromJson(day))
          .toList();
    }

    return HostelMenuModel(
      id: json['id'] ?? '',
      weekMenu: menuList,
      hostelName: json['hostelName'] ?? '',
      validFrom: json['validFrom'] != null
          ? (json['validFrom'] as Timestamp).toDate()
          : DateTime.now(),
      validUntil: json['validUntil'] != null
          ? (json['validUntil'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weekMenu': weekMenu.map((day) => day.toJson()).toList(),
      'hostelName': hostelName,
      'validFrom': validFrom,
      'validUntil': validUntil,
    };
  }
}

class DailyMenu {
  final String id;
  final String day;
  final Meal breakfast;
  final Meal lunch;
  final Meal snacks;
  final Meal dinner;

  DailyMenu({
    required this.id,
    required this.day,
    required this.breakfast,
    required this.lunch,
    required this.snacks,
    required this.dinner,
  });

  factory DailyMenu.fromJson(Map<String, dynamic> json) {
    return DailyMenu(
      id: json['id'] ?? '',
      day: json['day'] ?? '',
      breakfast: Meal.fromJson(json['breakfast'] ?? {}),
      lunch: Meal.fromJson(json['lunch'] ?? {}),
      snacks: Meal.fromJson(json['snacks'] ?? {}),
      dinner: Meal.fromJson(json['dinner'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'breakfast': breakfast.toJson(),
      'lunch': lunch.toJson(),
      'snacks': snacks.toJson(),
      'dinner': dinner.toJson(),
    };
  }
}

class Meal {
  final String id;
  final String name;
  final List<String> items;
  final String time;

  Meal({
    required this.id,
    required this.name,
    required this.items,
    required this.time,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> itemsList = [];
    if (json['items'] != null) {
      itemsList = List<String>.from(json['items']);
    }

    return Meal(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      items: itemsList,
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'items': items,
      'time': time,
    };
  }
}