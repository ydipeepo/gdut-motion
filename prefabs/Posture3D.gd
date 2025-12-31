class_name Posture3D extends ColorRect

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

var angle: Vector2:
	get:
		return Vector2(
			%Cube.rotation.x,
			%Cube.rotation.y)
	set(value):
		%Cube.rotation.x = value.x
		%Cube.rotation.y = value.y
