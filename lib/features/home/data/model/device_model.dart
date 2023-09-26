class Device {
  String name= "";
  int color= 0;
  bool isActive = false;
  String icon = "";

  Device({required this.name,required this.color,required this.isActive,required this.icon});

  Device.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    isActive = json['isActive'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['color'] = color;
    data['isActive'] = isActive;
    data['icon'] = icon;
    return data;
  }
}
