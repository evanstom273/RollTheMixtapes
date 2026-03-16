@tool
extends Resource
class_name ProductResource

enum ProductType { NONE, SONG, ALBUM, MERCH }
enum SongGenre {
    NONE, POP, ROCK, METAL,
    HIP_HOP, RNB, JAZZ, BLUES,
    COUNTRY, FOLK, ELECTRONIC, REGGAE, LATIN,
    CLASSICAL, EXPERIMENTAL, WORLD
}
enum MerchType {
    NONE, TSHIRT, HOODIE, HAT,
    BEANIE, POSTER, CD, VINYL,
    CASSETTE, PHOTOBOOK, STICKER,
    KEYCHAIN, BADGE, PIN, TOTE_BAG,
    WRISTBAND, PHONE_CASE, MUG, FLAG,
    PLUSHIE
}
enum AlbumType {
    NONE,
    EP,
    STUDIO_ALBUM,
    COMPILATION,
    LIVE_ALBUM,
    REMIX_ALBUM,
    ACOUSTIC_ALBUM,
    SOUNDTRACK
}

@export_group("Project Details")
@export var project_name: String = ""
@export var product_type: ProductType = ProductType.NONE:
    set(value):
        product_type = value
        notify_property_list_changed()

@export var song_genre: Array[SongGenre] = []
@export var album_type: AlbumType = AlbumType.NONE
@export var merch_type: MerchType = MerchType.NONE
@export var artist: CharacterResource

@export var has_featured_artists: bool = false:
    set(value):
        has_featured_artists = value
        notify_property_list_changed()

@export var featured_artists: Array[CharacterResource] = []
@export var label: CompanyResource

@export_group("Stats")
@export_range(0, 100) var quality: int = 50
@export_range(0, 100) var appeal: int = 50
@export_range(0, 100) var hype: int = 0
@export_range(0, 100) var fan_score: int = 50
@export_range(0, 100) var critic_score: int = 50
@export var units_sold: int = 0
@export var revenue: int = 0
@export_range(0, 100) var longevity: int = 50

func _validate_property(property: Dictionary) -> void:
    # Show only properties relevant to the selected product setup.
    if property.name == "featured_artists" and not has_featured_artists:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "song_genre" and product_type != ProductType.SONG:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "album_type" and product_type != ProductType.ALBUM:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "merch_type" and product_type != ProductType.MERCH:
        property.usage = PROPERTY_USAGE_NO_EDITOR
