extends Node2D

var MAX_DIST = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print(radians_to_one(angle(0, 1)))


func _process(delta):
	#queue_redraw()
	pass
	
#func _draw():
#	var color = Color.from_hsv(0, 1.0, 1.0)
#
#
#	for x in range(-MAX_DIST, MAX_DIST):
#		for y in range(-MAX_DIST, MAX_DIST):
#			var r = sqrt(x*x + y*y)
#			var phi = angle(x, y)
#
#
#			#var modified_radius = r * sin(angle)
#			var curve1 = normalized_sin(radians_to_one(phi*7))/10
#			var curve2 = normalized_sin(radians_to_one(phi*13))/12
#
#			color.h = normalized_sin(curve1  + curve2 + r  / 1000)
#			#color.s = normalized_sin(radians_to_one(phi)) 
#
#			draw_line(Vector2(x, y), Vector2(x, y + 1), color, 1.0)


func angle(x: float, y: float):
	var base = null
		
	if x == 0:
		if y <= 0:
			base = PI/2
		else:
			base =  PI 	/ 2
	else:
		base = atan(abs(y) / abs(x))
		

	if x >= 0 and y >= 0:
		return base
	elif x <= 0 and y >= 0:
		return PI - base 
	elif x <= 0 and y <= 0:
		return base +  PI
	elif x >= 0 and y <= 0:
		return 2* PI - base
	
func radians_to_one(radians: float):
	return radians / (2 * PI)
	
func normalized_sin(phi: float):
	return (sin(phi * 2 * PI) + 1) / 2
