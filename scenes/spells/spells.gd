extends Control
@onready var spell_list = $HSplitContainer/List/ScrollContainer/VBoxContainer
var add_spell_popup = preload("res://scenes/add_spell/add_spell.tscn")

var list_component = preload("res://scenes/list_component/list_component.tscn")
var firebolt_image = preload("res://icon.svg")


func _ready():
	for i in 50:
		var firebolt = list_component.instantiate()
		firebolt.define(firebolt_image, "Firebolt", "from baldurs gate")
		spell_list.add_child(firebolt)


func _on_add_spell_pressed():
	var popup = add_spell_popup.instantiate()
	add_child(popup)
	popup.popup_centered()
