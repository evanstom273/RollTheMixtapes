@tool
extends Resource
class_name CharacterResource


enum Region { NORTH_AMERICA, LATIN_AMERICA, EUROPE, ASIA, AFRICA, OCEANIA }
enum CountryNorthAmerica { USA, CANADA, MEXICO }
enum CountryLatinAmerica { BRAZIL, ARGENTINA, CHILE }
enum CountryEurope { ENGLAND, SCOTLAND, FRANCE, GERMANY, IRELAND, ITALY, SPAIN, WALES }
enum CountryAsia { JAPAN, CHINA, INDIA, SOUTH_KOREA }
enum CountryAfrica { NIGERIA, SOUTH_AFRICA, GHANA }
enum CountryOceania { NEW_ZEALAND, AUSTRALIA, SAMOA }

enum CharacterGender { MALE, FEMALE }

enum CharacterType {
    MUSICIAN,
    PRODUCER,
    SONGWRITER,
    MANAGER
}

enum MusicianType { NONE, SINGER, GUITARIST, BASSIST, KEYBOARDIST, DJ, DRUMMER }

var _is_normalizing_specialities := false

# --- Personal Info ---

@export_group("Character Info")
@export var character_name: String = ""
@export_range(16, 85) var character_age: int = 16
@export var character_gender: CharacterGender = CharacterGender.MALE
@export var birthplace: Region = Region.NORTH_AMERICA:
    set(value):
        birthplace = value
        notify_property_list_changed()

@export var country_north_america: CountryNorthAmerica = CountryNorthAmerica.USA
@export var country_latin_america: CountryLatinAmerica = CountryLatinAmerica.BRAZIL
@export var country_europe: CountryEurope = CountryEurope.ENGLAND
@export var country_asia: CountryAsia = CountryAsia.JAPAN
@export var country_africa: CountryAfrica = CountryAfrica.NIGERIA
@export var country_oceania: CountryOceania = CountryOceania.NEW_ZEALAND

@export var character_type: CharacterType = CharacterType.MUSICIAN:
    set(value):
        character_type = value
        if not _is_normalizing_specialities:
            _normalize_musician_specialities()
        notify_property_list_changed()

@export var musician_speciality_1: MusicianType = MusicianType.NONE:
    set(value):
        musician_speciality_1 = value
        if not _is_normalizing_specialities:
            _normalize_musician_specialities()
        notify_property_list_changed()

@export var musician_speciality_2: MusicianType = MusicianType.NONE:
    set(value):
        musician_speciality_2 = value
        if not _is_normalizing_specialities:
            _normalize_musician_specialities()
        notify_property_list_changed()

@export var musician_speciality_3: MusicianType = MusicianType.NONE:
    set(value):
        musician_speciality_3 = value
        if not _is_normalizing_specialities:
            _normalize_musician_specialities()
        notify_property_list_changed()

# --- Character Stats ---

@export_group("Popularity")
@export_range(0, 100) var pop_north_america: int = 0
@export_range(0, 100) var pop_latin_america: int = 0
@export_range(0, 100) var pop_europe: int = 0
@export_range(0, 100) var pop_asia: int = 0
@export_range(0, 100) var pop_africa: int = 0
@export_range(0, 100) var pop_oceania: int = 0
@export var pop_global: int:
    get:
        return roundi((
            pop_north_america
            + pop_latin_america
            + pop_europe
            + pop_asia
            + pop_africa
            + pop_oceania
        ) / 6.0)

@export_group("Music Stats")
@export_range(1, 99) var singing_skill: int = 1
@export_range(1, 99) var guitar_skill: int = 1
@export_range(1, 99) var bass_skill: int = 1
@export_range(1, 99) var keyboard_skill: int = 1
@export_range(1, 99) var dj_skill: int = 1
@export_range(1, 99) var drumming_skill: int = 1

@export_group("Other Stats")
@export_range(1, 99) var writing_skill: int = 1
@export_range(1, 99) var production_skill: int = 1
@export_range(1, 99) var management_skill: int = 1

func _validate_property(property: Dictionary) -> void:
    # Hide country enums that don't match the current birthplace.
    if property.name == "country_north_america" and birthplace != Region.NORTH_AMERICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_latin_america" and birthplace != Region.LATIN_AMERICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_europe" and birthplace != Region.EUROPE:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_asia" and birthplace != Region.ASIA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_africa" and birthplace != Region.AFRICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_oceania" and birthplace != Region.OCEANIA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "musician_speciality_1" and character_type != CharacterType.MUSICIAN:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "musician_speciality_2" and character_type != CharacterType.MUSICIAN:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "musician_speciality_3" and character_type != CharacterType.MUSICIAN:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "musician_speciality_2" and musician_speciality_1 == MusicianType.NONE:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "musician_speciality_3" and musician_speciality_2 == MusicianType.NONE:
        property.usage = PROPERTY_USAGE_NO_EDITOR

func _normalize_musician_specialities() -> void:
    _is_normalizing_specialities = true

    if character_type != CharacterType.MUSICIAN:
        musician_speciality_1 = MusicianType.NONE
        musician_speciality_2 = MusicianType.NONE
        musician_speciality_3 = MusicianType.NONE
        _is_normalizing_specialities = false
        return

    if musician_speciality_1 == MusicianType.NONE:
        musician_speciality_2 = MusicianType.NONE
        musician_speciality_3 = MusicianType.NONE
        _is_normalizing_specialities = false
        return

    if musician_speciality_2 == musician_speciality_1:
        musician_speciality_2 = MusicianType.NONE

    if musician_speciality_2 == MusicianType.NONE:
        musician_speciality_3 = MusicianType.NONE
        _is_normalizing_specialities = false
        return

    if musician_speciality_3 == musician_speciality_1 or musician_speciality_3 == musician_speciality_2:
        musician_speciality_3 = MusicianType.NONE

    _is_normalizing_specialities = false

func _enum_to_display_name(enum_key: String) -> String:
    var words := enum_key.to_lower().split("_")
    for i in range(words.size()):
        words[i] = words[i].capitalize()
    return " ".join(words)

func get_country_name() -> String:
    match birthplace:
        Region.NORTH_AMERICA:
            return _enum_to_display_name(CountryNorthAmerica.keys()[country_north_america])
        Region.LATIN_AMERICA:
            return _enum_to_display_name(CountryLatinAmerica.keys()[country_latin_america])
        Region.EUROPE:
            return _enum_to_display_name(CountryEurope.keys()[country_europe])
        Region.ASIA:
            return _enum_to_display_name(CountryAsia.keys()[country_asia])
        Region.AFRICA:
            return _enum_to_display_name(CountryAfrica.keys()[country_africa])
        Region.OCEANIA:
            return _enum_to_display_name(CountryOceania.keys()[country_oceania])
    return "Unknown"
