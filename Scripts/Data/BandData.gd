@tool
extends Resource
class_name BandResource

@export_group("Band Info")
@export var band_name = str("")
@export_range(2, 7) var band_member_amount: int = 0
@export var has_singer: bool = false:
    set(value):
            has_singer = value
            notify_property_list_changed()
@export var band_singer: CharacterResource

@export var has_guitarist: bool = false:
    set(value):
            has_guitarist = value
            notify_property_list_changed()
@export var band_guitarist: CharacterResource

@export var has_bassist: bool = false:
    set(value):
            has_bassist = value
            notify_property_list_changed()
@export var band_bassist: CharacterResource

@export var has_keyboardist: bool = false:
    set(value):
            has_keyboardist = value
            notify_property_list_changed()
@export var band_keyboardist: CharacterResource

@export var has_drummer: bool = false:
    set(value):
            has_drummer = value
            notify_property_list_changed()
@export var band_drummer: CharacterResource

@export var has_extra_members: bool = false:
    set(value):
            has_extra_members = value
            notify_property_list_changed()
@export var extra_members: Array[CharacterResource]

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
    # Hide country enums that don't match the current birthplace.
    if property.name == "band_singer" and has_singer == false:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    if property.name == "band_guitarist" and has_guitarist == false:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    if property.name == "band_bassist" and has_bassist == false:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    if property.name == "band_keyboardist" and has_keyboardist == false:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    if property.name == "band_drummer" and has_drummer == false:
        property.usage = PROPERTY_USAGE_NO_EDITOR
    if property.name == "extra_members" and has_extra_members == false:
        property.usage = PROPERTY_USAGE_NO_EDITOR
