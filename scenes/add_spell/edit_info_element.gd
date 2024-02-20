extends Node
var type_select = OptionButton.new()


func _ready():
	add_child(type_select)
	type_select.add_item("Text")
	type_select.add_item("Damage")
	type_select.add_item("Saving Throw")
	type_select.item_selected.connect(_on_item_selected)
	type_select.add_to_group("type_select")
	
	_on_item_selected(0)


func _on_item_selected(index):
	var text_input = LineEdit.new()
	text_input.placeholder_text = "Text"
	
	var dice_select = new_dice_select()
	var dice_amount = LineEdit.new()
	dice_amount.placeholder_text = "Amt."
	var damage_type = new_damage_type()
	
	var save_effect = OptionButton.new()
	save_effect.add_item("Half Effect")
	save_effect.add_item("No Effect")
	
	for i in get_children():
		if !i.get_groups().has("type_select"):
			i.queue_free()
	
	if index == 0:
		add_child(text_input)
	elif index == 1:
		add_child(dice_amount)
		add_child(dice_select)
		add_child(damage_type)
	elif index == 2:
		add_child(damage_type)
		add_child(save_effect)
	
	var delete = Button.new()
	delete.text = "Delete"
	delete.pressed.connect(delete_row)
	add_child(delete)


func new_dice_select():
	var dice_select = OptionButton.new()
	dice_select.add_item("d4")
	dice_select.add_item("d6")
	dice_select.add_item("d8")
	dice_select.add_item("d10")
	dice_select.add_item("d12")
	dice_select.add_item("d20")
	return dice_select


func new_damage_type():
	var damage_type = OptionButton.new()
	damage_type.add_item("Bludgeoning")
	damage_type.add_item("Piercing")
	damage_type.add_item("Slashing")
	damage_type.add_item("Cold")
	damage_type.add_item("Fire")
	damage_type.add_item("Lightning")
	damage_type.add_item("Thunder")
	damage_type.add_item("Acid")
	damage_type.add_item("Poison")
	damage_type.add_item("Radiant")
	damage_type.add_item("Necrotic")
	damage_type.add_item("Force")
	damage_type.add_item("Psychic")
	return damage_type


func delete_row():
	queue_free()
