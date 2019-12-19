class ListingImages {

ListingLogo listingLogo;
CoverPhoto coverPhoto;
Ads ads;

ListingImages(this.listingLogo,this.coverPhoto,this.ads);
ListingImages.fromJson(Map<String, dynamic> json) 
: listingLogo = json['url'];

}

class ListingLogo {
  String url;

  ListingLogo(this.url);

  ListingLogo.fromJson(Map<String, dynamic> json) : url = json['url'];
}

class CoverPhoto {
  String url;

  CoverPhoto(this.url);

  CoverPhoto.fromJson(Map<String, dynamic> json) : url = json['url'];
}

class Ads {
  final List<String> ads;

  Ads({
    this.ads
  });

  factory Ads.fromJson(Map<String, dynamic> parsedJson) {
    var ads  = parsedJson['ads'];
    List<String> adsList = ads.cast<String>();

    return new Ads(
      ads: adsList,
    );
  }

}