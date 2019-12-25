class ListingImageListingLogo {
  String url;

  ListingImageListingLogo(this.url);

  ListingImageListingLogo.fromJson(Map<dynamic, dynamic> json)
      : url = json['url'];
}