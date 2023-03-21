extends Sprite2D


func _ready():
	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		update_mouse_position()
	
func _process(delta):
	pass

func update_mouse_position():
	var mouse = get_viewport().get_mouse_position();
	var screen = get_viewport().get_visible_rect().size
	mouse.x /= screen.x
	mouse.y /= screen.y
#	get_material().set_shader_param("mouse_position", mouse)
	var shaderMaterial = material as ShaderMaterial
	shaderMaterial.set_shader_parameter("mouse_position", mouse)
	queue_redraw()
