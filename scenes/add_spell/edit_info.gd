extends VBoxContainer
var element_script = load("res://scenes/add_spell/edit_info_element.gd")

func _ready():
	$EditShortDescription/VBoxContainer/AddElement.pressed.connect(add_element)


func add_element():
	var hbox = HBoxContainer.new()
	hbox.set_script(element_script)
	add_child(hbox)
