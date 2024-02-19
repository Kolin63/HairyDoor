extends VBoxContainer
var bg3_texture
var school
var selected_index

var abjuration = preload("res://imports/beyond_schools/abjuration.png")
var conjuration = preload("res://imports/beyond_schools/conjuration.png")
var divination = preload("res://imports/beyond_schools/divination.png")
var enchantment = preload("res://imports/beyond_schools/enchantment.png")
var evocation = preload("res://imports/beyond_schools/evocation.png")
var illusion = preload("res://imports/beyond_schools/illusion.png")
var necromancy = preload("res://imports/beyond_schools/necromancy.png")
var transmutation = preload("res://imports/beyond_schools/transmutation.png")


func _ready():
	$SelectSource.item_selected.connect(_on_item_selected)
	selected_index = $SelectSource.selected


func _on_preview_share_texture(bg3_texture_shared):
	bg3_texture = bg3_texture_shared
	update_picture()


func _on_preview_share_json(json_shared):
	var json = json_shared
	school = json["school"]["index"]
	print(school)


func _on_item_selected(index):
	selected_index = index
	update_picture()


func update_picture():
	var logo = $HBoxContainer/Picture.texture
	if selected_index == 0:
		$HBoxContainer/Picture.texture = bg3_texture
	elif selected_index == 1:
		if school == "abjuration":
			$HBoxContainer/Picture.texture = abjuration
		elif school == "conjuration":
			$HBoxContainer/Picture.texture = conjuration
		elif school == "divination":
			$HBoxContainer/Picture.texture = divination
		elif school == "enchantment":
			$HBoxContainer/Picture.texture = enchantment
		elif school == "evocation":
			$HBoxContainer/Picture.texture = evocation
		elif school == "illusion":
			$HBoxContainer/Picture.texture = illusion
		elif  school == "necromancy":
			$HBoxContainer/Picture.texture = necromancy
		elif school == "transmutation":
			$HBoxContainer/Picture.texture = transmutation
	elif selected_index == 2:
		pass
	
	var current_texture = $HBoxContainer/Picture.texture
	$HBoxContainer/Picture.scale = Vector2(128.0 / current_texture.get_width(), 128.0 / current_texture.get_height())
