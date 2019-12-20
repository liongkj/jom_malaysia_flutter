class ListingImageCoverPhoto {
  String url;

  ListingImageCoverPhoto(this.url);

  ListingImageCoverPhoto.fromJson(Map<String, dynamic> json)
      : url = json['url'];
}