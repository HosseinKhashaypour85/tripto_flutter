class TripsHistoryModel {
  TripsHistoryModel({
      this.page, 
      this.perPage, 
      this.totalItems, 
      this.totalPages, 
      this.items,});

  TripsHistoryModel.fromJson(dynamic json) {
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
    tripTime = json['trip_time'];
    updated = json['updated'];
    tripPrice = json['trip_price'] ?? 0;
  }
  String? collectionId;
  String? collectionName;
  String? created;
  String? destinationPlace;
  int? tripPrice;
  String? id;
  String? originPlace;
  bool? roundTrip;
  String? tripTime;
  String? updated;

}