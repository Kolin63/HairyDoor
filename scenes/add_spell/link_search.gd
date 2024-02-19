extends VBoxContainer
var wiki_checker = preload("res://scenes/wiki_checker/wiki_checker.tscn")

@onready var api_status = $APIStatus
@onready var bg3_status = $BG3Status

var api_display = "API: "
var bg3_display = "BG3: "

var red = Color(1.0, 0.0, 0.0, 1.0)
var yellow = Color(1.0, 1.0, 0.0, 1.0)
var green = Color(0.0, 1.0, 0.0, 1.0)
var white = Color(1.0, 1.0, 1.0, 1.0)

var api_link
var bg3_link

signal preview_api(link)
signal preview_bg3(link, bg3_id)

var bg3_id

func _ready():
	_on_text_changed("")
	$HBoxContainer/SpellName.text_changed.connect(_on_text_changed)
	$HBoxContainer/SpellName.text_submitted.connect(_on_text_submitted)
	$HBoxContainer/CheckLinks.pressed.connect(_check_links)
	
	api_status.set("theme_override_colors/font_color", white)
	bg3_status.set("theme_override_colors/font_color", white)


func _on_text_changed(new_text):
	$APIStatus.set("theme_override_colors/font_color", white)
	$BG3Status.set("theme_override_colors/font_color", white)
	
	api_display = "API: "
	bg3_display = "BG3: "
	
	api_link = "https://www.dnd5eapi.co/api/spells/"
	bg3_link = "https://www.bg3.wiki/wiki/"
	
	api_link += new_text.replace(" ", "-").to_lower().replace("'", "")
	api_link = fix_api_links(api_link)
	
	var fixed_bg3_suffix = new_text.to_pascal_case().capitalize().replace(" ", "_")
	bg3_link += fixed_bg3_suffix
	bg3_link = fix_bg3_links(bg3_link)
	bg3_id = bg3_link.right(-26)
	
	api_display += api_link
	bg3_display += bg3_link
	
	api_status.text = api_display
	bg3_status.text = bg3_display


func _check_links():
	var api_checker = wiki_checker.instantiate()
	var bg3_checker = wiki_checker.instantiate()
	add_child(api_checker)
	add_child(bg3_checker)

	api_status.set("theme_override_colors/font_color", yellow)
	bg3_status.set("theme_override_colors/font_color", yellow)
	
	if await api_checker.api_404(api_link) == 0:
		api_status.set("theme_override_colors/font_color", green)
		preview_api.emit(api_link)
	else:
		api_status.set("theme_override_colors/font_color", red)
		
	if await bg3_checker.bg3_404(bg3_link) == 0:
		bg3_status.set("theme_override_colors/font_color", green)
		preview_bg3.emit(bg3_link, bg3_id)
	else:
		bg3_status.set("theme_override_colors/font_color", red)


func _on_text_submitted(_new_text):
	_check_links()


func fix_bg3_links(bl):
	if bl.length() == 26:
		return bl
	for i in bl.length():
		if check_for_word(bl, "Of", i):
			bl[i - 1] = "o"
		if check_for_word(bl, "Armor", i):
			if bl.length() >= i+4:
				bl = bl.insert(i+3, "u")
		if check_for_word(bl, "Hunters", i):
			if bl.length() >= i+6:
				bl = bl.insert(i+5, "'")
		if check_for_word(bl, "With_", i):
			bl[i - 1] = "w"
	return bl


func fix_api_links(al):
	if al.length() == 26:
		return al
	for i in al.length():
		if check_for_word(al, "armour", i):
			if al.length() >= i+3:
				al[i+3] = ""
		if check_for_word(al, "hunter's", i):
			if al.length() >= i+7:
				al[i+7] = ""
	return al

func check_for_word(string, word, index):
	var contains = false
	if string.length() - 26 < word.length():
		return false
	elif string.length() == 26:
		return false
	for i in word.length():
		if index + i > string.length():
			contains = false
			break
		if string[index + i - 1] == word[i]:
			contains = true
		else:
			contains = false
			break
	return contains
