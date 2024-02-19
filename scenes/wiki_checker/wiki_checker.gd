extends HTTPRequest
var source = null
var request_body = null


func _ready():
	request_completed.connect(_on_request_completed)


func extract(link, ecompile):
	request(link)
	
	var compile = ecompile
	var regex = RegEx.new()
	regex.compile(compile)
	
	await request_completed
	
	var html = request_body.get_string_from_utf8()
	var search_result = regex.search(html)
	if search_result:
		return search_result.get_string()
	else:
		print("Error extracting information from HTTP Request")


func _on_request_completed(_result, _response_code, _headers, body):
	request_body = body


func isolate(input):
	if input == null:
		return
	var quotes_found = 0
	var slice_location
	for i in input.length():
		if input.unicode_at(i) == 34:
			quotes_found += 1
			if quotes_found == 3:
				slice_location = i
				break
	
	for i in slice_location + 1:
		input[0] = ""
	input[input.length() - 1] = ""
	return input


func api_404(link):
	if !is_inside_tree():
		return
	if link == "https://www.dnd5eapi.co/api/spells/":
		return
	
	request(link)
	
	await request_completed
	
	if request_body == null:
		return
	
	var json = JSON.parse_string(request_body.get_string_from_utf8())
	if json.size() == 1:
		return -1
	else:
		return 0


func bg3_404(link):
	if !is_inside_tree():
		return
	if link == "https://www.bg3.wiki/wiki/":
		return
	request(link)
	
	var compile = "<p>There is currently no text in this page."
	
	await request_completed
	
	if request_body == null:
		print("Error extracting HTML when checking for bg3 404")
		return
	
	var html = request_body.get_string_from_utf8()
	var regex = RegEx.new()
	regex.compile(compile)
	var search_result = regex.search(html)
	
	if search_result == null:
		return 0
	elif search_result.get_string() == compile:
		return -1
	else:
		return 0


func extract_image(link):
	request(link)
	await request_completed
	
	var image = Image.new()
	var error = image.load_png_from_buffer(request_body)
	if error != OK:
		print("Error extracting image")
	
	var texture = ImageTexture.create_from_image(image)
	return texture
