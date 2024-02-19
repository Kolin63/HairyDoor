extends Control


func define(image, spell_name, short_description):
	$Image.texture = image
	$Image.scale = Vector2(128.0 / image.get_width(), 128.0 / image.get_height())
	$Name.text = spell_name
	$ShortDescription.text = short_description


func set_image(image):
	$Image.texture = image
	$Image.scale = Vector2(128.0 / image.get_width(), 128.0 / image.get_height())


func set_spell_name(spell_name):
	$Name.text = spell_name


func set_short_description(short_description):
	$ShortDescription.text = short_description
