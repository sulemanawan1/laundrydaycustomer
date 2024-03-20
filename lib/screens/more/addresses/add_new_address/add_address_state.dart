class AddAddressState {

  
  String? imagePath;
  String? address;
  double selectedLat = 0.0;
  double selectedLng = 0.0;
  AddAddressState({required this.imagePath, required this.address});

  AddAddressState copyWith({
    String? imagePath,
    String? address,
  }) {
    return AddAddressState(
        address: address ?? this.address,
        imagePath: imagePath ?? this.imagePath);
  }
}
