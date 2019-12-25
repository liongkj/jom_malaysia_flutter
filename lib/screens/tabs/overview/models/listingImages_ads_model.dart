class ListingImagesAds {
  final String ads;

  ListingImagesAds({
    this.ads
  });

  factory ListingImagesAds.fromJson(List<dynamic> parsedJson) {
      List<String> adsList = parsedJson.cast<String>();
      var ads = adsList.toString().replaceAll("[", "").replaceAll("]", "");
      return ListingImagesAds(
        ads: ads,
      );
  }
}