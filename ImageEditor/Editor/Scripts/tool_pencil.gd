extends Node
func pencil(image : Image, color : Color, position : Vector2)->void:
	image.set_pixelv(position,color)
	image.set_pixelv(position + Vector2(0,1),color)
	image.set_pixelv(position - Vector2(0,1),color)
	image.set_pixelv(position + Vector2(1,0),color)
	image.set_pixelv(position - Vector2(1,0),color)
