extends Control

@export var selected_character: CharacterResource

@onready var player_name_label = $MarginContainer3/VBoxContainer/HBoxContainer2/Player/PlayerInfo/MarginContainer/VBoxContainer/PlayerName
@onready var player_age_label = $MarginContainer3/VBoxContainer/HBoxContainer2/Player/PlayerInfo/MarginContainer/VBoxContainer/PlayerAge
@onready var player_birthplace_label = $MarginContainer3/VBoxContainer/HBoxContainer2/Player/PlayerInfo/MarginContainer/VBoxContainer/PlayerBirthplace
@onready var player_job_label = $MarginContainer3/VBoxContainer/HBoxContainer2/Player/PlayerInfo/MarginContainer/VBoxContainer/PlayerRole

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    player_name_label.text = str("Name: " + selected_character.character_name)
    player_age_label.text = str("Age: ") + str(selected_character.character_age)
    player_birthplace_label.text = str("Region: " + Region.keys([selected_character.birthplace]))
    player_name_label.text = str("Name: " + selected_character.character_name)
