class LocationData {
  const LocationData({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final String country;
  final String imageUrl;

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      LocationData(id: json['id'], name: json['name'], country: json['country'], imageUrl: json['imageUrl']);

  static List<LocationData> getLocationData() =>
      locationData.map((location) => LocationData.fromJson(location)).toList();

  @override
  String toString() {
    return 'LocationData{id: $id, name: $name, country: $country, imageUrl: $imageUrl}';
  }
}

const List<Map<String, dynamic>> locationData = [
  {
    "id": 1,
    "name": "Grand Canyon",
    "country": "USA",
    "imageUrl": "https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcSWZ5vg3f6F42qqoXhjv1oB84FivlYJ3_RgaRhz8yaifvWnqgTOv_Vgr147PK9NZ8U6Kmw1eD-PSdUj3lGY9_5N_V2TNUV_TlUmLp3ucQ"
  },
  {
    "id": 2,
    "name": "Machu Picchu",
    "country": "Peru",
    "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/e/eb/Machu_Picchu%2C_Peru.jpg"
  },
  {
    "id": 3,
    "name": "Sydney Opera House",
    "country": "Australia",
    "imageUrl": "https://lh3.googleusercontent.com/p/AF1QipMHftgSCBlvyjxYphi4gLqDC_62WWvZvyy1EBuh=s1360-w1360-h1020"
  },
  {
    "id": 4,
    "name": "Niagara Falls",
    "country": "Canada/USA",
    "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/a/ab/3Falls_Niagara.jpg"
  },
  {
    "id": 5,
    "name": "Colosseum",
    "country": "Italy",
    "imageUrl": "https://cdn.britannica.com/36/162636-050-932C5D49/Colosseum-Rome-Italy.jpg"
  },
  {
    "id": 6,
    "name": "Burj Khalifa",
    "country": "UAE",
    "imageUrl": "https://www.allplan.com/fileadmin/_processed_/6/5/csm_iStock-183346577_NEU_b998568fdd.jpg"
  },
  {
    "id": 7,
    "name": "Bagan",
    "country": "Myanmar",
    "imageUrl": "https://s3-cdn.designerjourneys.com/blog/wp-content/uploads/2018/02/21083327/Bagan-Temples.jpg"
  },
  {
    "id": 8,
    "name": "Antarctica",
    "country": "Antarctica",
    "imageUrl": "https://www.secretatlas.com/wp-content/uploads/2021/11/antarctica-photo-tour-1-1196x800.jpg"
  },
  {
    "id": 9,
    "name": "Stonehenge",
    "country": "England",
    "imageUrl": "https://media.cnn.com/api/v1/images/stellar/prod/220303081037-stonehenge-file-restricted.jpg?q=h_1688,w_3000,x_0,y_0"
  },
  {
    "id": 10,
    "name": "Swiss Alps",
    "country": "Switzerland",
    "imageUrl": "https://lp-cms-production.imgix.net/2024-04/LPT0115-001.jpg?w=1440&h=810&fit=crop&auto=format&q=75"
  },
  {
    "id": 11,
    "name": "Pitons of St. Lucia",
    "country": "Saint Lucia",
    "imageUrl": "https://www.premiumcaribbean.nl/wp-content/uploads/2017/08/Piton-Soufriere-1024x659.jpg"
  },
  {
    "id": 12,
    "name": "Yosemite National Park",
    "country": "USA",
    "imageUrl": "https://i.natgeofe.com/n/f14f6c30-8d11-4e33-a5e9-05f1b50bdde3/yosemite-national-park-california_16x9.jpg?w=1200"
  },
  {
    "id": 13,
    "name": "Louvre Museum",
    "country": "France",
    "imageUrl": "https://media.cntraveler.com/photos/57d961ce3e6b32bf25f5ad0f/16:9/w_2560,c_limit/most-beautiful-paris-louvre-GettyImages-536267205.jpg"
  },
  {
    "id": 14,
    "name": "Iceland's Waterfalls",
    "country": "Iceland",
    "imageUrl": "https://goldencircleiceland.com/wp-content/uploads/2021/05/Iceland-Godafoss-11401-PC-PostCover.jpg"
  },
  {
    "id": 15,
    "name": "Mount Kilimanjaro",
    "country": "Tanzania",
    "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Mt._Kilimanjaro_12.2006.JPG/800px-Mt._Kilimanjaro_12.2006.JPG"
  },
  {
    "id": 16,
    "name": "Florence",
    "country": "Italy",
    "imageUrl": "https://cdn-imgix.headout.com/media/images/1300daf8e72cbe5623b8a4d84a398f1f-Duomo%20Florence%20golden%20hour.jpg?auto=format&w=900&h=562.5&q=90&fit=crop&ar=16%3A10"
  },
  {
    "id": 17,
    "name": "Lake Tekapo",
    "country": "New Zealand",
    "imageUrl": "https://encrypted-tbn2.gstatic.com/licensed-image?q=tbn:ANd9GcSARAmBzTMq5yP1OubG6DOunS-EsfChHxIz1rcSZsaxrTGXLPzslBsE8TvXw0qlj6UJVi6eAHzlKXnueGpKjWAV5cBTX1NwpvZ73s3G8Q"
  },
  {
    "id": 18,
    "name": "Big Sur",
    "country": "USA",
    "imageUrl": "https://lp-cms-production.imgix.net/2019-06/28206231.jpg"
  },
  {
    "id": 19,
    "name": "Borobudur",
    "country": "Indonesia",
    "imageUrl": "https://encrypted-tbn0.gstatic.com/licensed-image?q=tbn:ANd9GcS99brTU4j31fd3IgFEE6ybxekkXJ-_yjhW5-QiDJuT1Ysvs4cWxMx9c5sq8xrX7fcLMjweqyM2GtryuVHxWSCDdW_-W1ibeFk_AqJWDb8"
  },
  {
    "id": 20,
    "name": "Pyramids of Giza",
    "country": "Egypt",
    "imageUrl": "https://i.natgeofe.com/n/535f3cba-f8bb-4df2-b0c5-aaca16e9ff31/giza-plateau-pyramids.jpg"
  }
];