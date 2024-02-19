extends VBoxContainer
var wiki_checker = preload("res://scenes/wiki_checker/wiki_checker.tscn")


func _on_search_preview_api(_link):
	pass # Replace with function body.


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
	
	$ListComponent.set_image(await image_grabber.extract_image(image_link))


func fix_ids(id):
	id = id.replace("'", "%27")
	if id == "Command":
		id = "Command_Halt"
	
	for i in id.length():
		if id[i - 1] == "O" && id[i] == "f":
			id[i - 1] = "o"
	
	print(id)
	return id
