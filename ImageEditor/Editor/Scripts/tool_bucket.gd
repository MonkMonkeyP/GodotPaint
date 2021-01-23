extends Node

#- The starts the flood fill -
func fill_start(image : Image, position : Vector2, fill_colour : Color)->void:
	var initial_color := image.get_pixelv(position)
	fill_flood(image, position, initial_color, fill_colour)

#- The Actual fill function -
func fill_flood (image : Image, position : Vector2, initial_colour : Color, fill_colour : Color)->void:
	#- This is the criteria for if it sets the pixel or not -
	if position.x < 0:
		return
	if position.y < 0:
		return
	if position.x > image.get_size().x - 1:
		return
	if position.y > image.get_size().y - 1:
		return
	if image.get_pixelv(position) != initial_colour:
		return
	#- After the criteria it sets that pixel -
	image.set_pixelv(position, fill_colour)
	#- this recursivly calls its self with a new positin and that is how it works - 
	fill_flood(image, Vector2(position.x + 1, position.y), initial_colour,  fill_colour)
	fill_flood(image, Vector2(position.x - 1, position.y), initial_colour,  fill_colour)
	fill_flood(image, Vector2(position.x, position.y + 1), initial_colour,  fill_colour)
	fill_flood(image, Vector2(position.x, position.y - 1), initial_colour,  fill_colour)
	return
