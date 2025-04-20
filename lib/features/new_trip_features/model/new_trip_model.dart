class NewTripModel {
  NewTripModel({
      this.page, 
      this.perPage, 
      this.totalItems, 
      this.totalPages, 
      this.items,});

  NewTripModel.fromJson(dynamic json) {
    page = json['page'];
    perPage = json['perPage'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  int? page;
  int? perPage;
  int? totalItems;
  int? totalPages;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['perPage'] = perPage;
    map['totalItems'] = totalItems;
    map['totalPages'] = totalPages;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Items {
  Items({
      this.collectionId, 
      this.collectionName, 
      this.created, 
      this.destinationPlace, 
      this.id, 
      this.originPlace, 
      this.roundTrip, 
      this.tripPrice, 
      this.tripTime, 
      this.updated,});

  Items.fromJson(dynamic json) {
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    created = json['created'];
    destinationPlace = json['destination_place'];
    id = json['id'];
    originPlace = json['origin_place'];
    roundTrip = json['round_trip'];
    tripPrice = json['trip_price'];
    tripTime = json['trip_time'];
    updated = json['updated'];
  }
  String? collectionId;
  String? collectionName;
  String? created;
  String? destinationPlace;
  String? id;
  String? originPlace;
  bool? roundTrip;
  int? tripPrice;
  String? tripTime;
  String? updated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['collectionId'] = collectionId;
    map['collectionName'] = collectionName;
    map['created'] = created;
    map['destination_place'] = destinationPlace;
    map['id'] = id;
    map['origin_place'] = originPlace;
    map['round_trip'] = roundTrip;
    map['trip_price'] = tripPrice;
    map['trip_time'] = tripTime;
    map['updated'] = updated;
    return map;
  }

}