class_name Posture2D extends ColorRect

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

var angle: float:
	get:
		return %Cube.rotation
	set(value):
		%Cube.rotation = value
