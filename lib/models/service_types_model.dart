class ServiceTypesModel {
  int? id;
  int? serviceId;
  String? type;
  String? unit;
  String? image;
  int? startingTime;
  int? endingTime;

  ServiceTypesModel(
      {this.id,
      this.serviceId,
      this.type,
      this.image,
      this.startingTime,
      this.endingTime,
      this.unit});
}
