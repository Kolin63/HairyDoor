extends VBoxContainer
var wiki_checker = preload("res://scenes/wiki_checker/wiki_checker.tscn")
signal share_texture(bg3_texture_shared)
signal share_json(json_shared)


func _on_search_preview_api(link):
	var json_grabber = wiki_checker.instantiate()
	add_child(json_grabber)
	
	var json = await json_grabber.extract_json(link)
	share_json.emit(json)


func _on_search_preview_bg3(link, bg3_id):
	var id = fix_ids(bg3_id)
	bg3_image(link, id)


func bg3_image(link, id):
	var image_grabber = wiki_checker.instantiate()
	add_child(image_grabber)
	
	var image_compile = r'src="/w/images/thumb/.*'
	image_compile += id
	image_compile += r'\.webp\.png"'
	
	var image_link = "https://www.bg3.wiki"
	var image_link_2 = await image_grabber.extract(link, image_compile)
	
	if !image_link_2:
		print("Error extracting image link, ID is ", id)
		return
	image_link += image_link_2
	for i in 5:
		image_link[20] = ""
	image_link[image_link.length() - 1] = ""
	
	var bg3_texture = await image_grabber.extract_image(image_link)
	$ListComponent.set_image(bg3_texture)
	share_texture.emit(bg3_texture)


func fix_ids(id):
	id = id.replace("'", "%27")
	if id == "Command":
		id = "Command_Halt"
	elif id == "Shield":
		id = "Shield_Spell"
	
	for i in id.length():
		if id[i - 1] == "O" && id[i] == "f":
			id[i - 1] = "o"
	
	return id
