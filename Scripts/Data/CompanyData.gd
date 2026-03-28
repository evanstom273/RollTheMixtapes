@tool
extends Resource
class_name CompanyResource

enum Region { NORTH_AMERICA, LATIN_AMERICA, EUROPE, ASIA, AFRICA, OCEANIA }
enum CountryNorthAmerica { USA, CANADA, MEXICO }
enum CountryLatinAmerica { BRAZIL, ARGENTINA, CHILE }
enum CountryEurope { ENGLAND, SCOTLAND, FRANCE, GERMANY, IRELAND, ITALY, SPAIN, WALES }
enum CountryAsia { JAPAN, CHINA, INDIA, SOUTH_KOREA }
enum CountryAfrica { NIGERIA, SOUTH_AFRICA, GHANA }
enum CountryOceania { NEW_ZEALAND, AUSTRALIA, SAMOA }

enum CompanyType { NONE, LABEL, STUDIO }

@export_group("Company Info")
@export var company_name = str("")
@export var location: Region = Region.NORTH_AMERICA:
    set(value):
        location = value
        notify_property_list_changed()
@export var country_north_america: CountryNorthAmerica = CountryNorthAmerica.USA
@export var country_latin_america: CountryLatinAmerica = CountryLatinAmerica.BRAZIL
@export var country_europe: CountryEurope = CountryEurope.ENGLAND
@export var country_asia: CountryAsia = CountryAsia.JAPAN
@export var country_africa: CountryAfrica = CountryAfrica.NIGERIA
@export var country_oceania: CountryOceania = CountryOceania.NEW_ZEALAND
@export var company_type: CompanyType = CompanyType.NONE:
     set(value):
        company_type = value
        notify_property_list_changed()
@export var preferred_genres: Array[ProductResource.SongGenre]
@export_range(1, 10) var studio_quality: int = 0

@export_group("Financial Info & Contracts")
@export_range(0, 1000000, 1000) var bank_balance: int = 0
@export var signed_artists: Array[CharacterResource]
@export var signed_bands: Array[BandResource]

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

func _validate_property(property: Dictionary) -> void:
    # Hide country enums that don't match the current location.
    if property.name == "country_north_america" and location != Region.NORTH_AMERICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_latin_america" and location != Region.LATIN_AMERICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_europe" and location != Region.EUROPE:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_asia" and location != Region.ASIA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_africa" and location != Region.AFRICA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "country_oceania" and location != Region.OCEANIA:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "preferred_genres" and company_type != CompanyType.LABEL:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "studio_quality" and company_type != CompanyType.STUDIO:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "signed_artists" and company_type != CompanyType.LABEL:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    elif property.name == "signed_bands" and company_type != CompanyType.LABEL:
        property.usage = PROPERTY_USAGE_NO_EDITOR
