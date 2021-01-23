extends Control
#- Colors -
var first_color : Color = Color(1.0, 1.0, 1.0)
var second_color : Color = Color(0.0, 0.0, 0.0)
#- Image -
var image := Image.new()
var image_texture := ImageTexture.new()
#- Vars about height -
var image_height : int = 28
var image_width : int = 28
#- Tool State Machine -
enum {
	PENCIL,
	FILL
}
#- Just the tool State -
var current_tool := FILL

var zoom_step : int = 2

func _ready()->void:
	image.create(image_width, image_height, false, Image.FORMAT_RGBF)
	image.fill(second_color)
	image.lock()
	texture_update()
	$ImageDisplay.texture = image_texture

func texture_update()->void:
	image_texture.create_from_image(image)
	image_texture.flags = 0

func _input(event):
	if event is InputEventMouse:
		if Input.is_action_pressed("primary_action") and is_in_bounds(event.position):
				match current_tool:
					PENCIL:
						$Pencil.pencil(image, first_color, pos_to_pix(event.position))
						texture_update()
					FILL:
						$BucketFill.fill_start(image, pos_to_pix(event.position), first_color)
						texture_update()
	if Input.is_action_pressed("alt_action_control") and Input.is_action_pressed("zoom_in"):
		$ImageDisplay.rect_scale += Vector2(zoom_step,zoom_step)
	elif Input.is_action_pressed("alt_action_control") and Input.is_action_just_pressed("zoom_out"):
		$ImageDisplay.rect_scale -= Vector2(zoom_step,zoom_step)
		

func is_in_bounds(position : Vector2)->bool:
	if position.x > image.get_size().x * $ImageDisplay.rect_scale.x:
		return false
	if position.y > image.get_size().y * $ImageDisplay.rect_scale.y:
		return false
	else:
		return true

func pos_to_pix(position : Vector2)->Vector2:
	var pixel_cord : Vector2 = Vector2.ZERO
	pixel_cord.x = int(position.x/$ImageDisplay.rect_scale.x)
	pixel_cord.y = int(position.y/$ImageDisplay.rect_scale.y)
	return pixel_cord

func _on_ColorPicker_color_changed(color)->void:
	first_color = color

func _on_ButtonPencil_pressed()->void:
	current_tool = PENCIL

func _on_ButtonBucket_pressed()->void:
	current_tool = FILL

