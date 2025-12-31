extends MarginContainer

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export var color_marker_start: Color
@export var color_marker_end: Color

#-------------------------------------------------------------------------------

var _posture_2d_expression: MotionExpression
var _posture_3d_expression: MotionExpression

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	%Posture2D_Graph.value = %Posture2D.angle
	%Posture3D_Graph.value = %Posture3D.angle

func _on_posture_2d_start_pressed() -> void:
	%Posture2D_Cancel.disabled = false
	%Posture2D_Graph.add_marker(color_marker_start)
	_posture_2d_expression = %Posture2D_Transition.create(%Posture2D, ^"angle")
	if _posture_2d_expression is not GlideMotionExpression:
		_posture_2d_expression = _posture_2d_expression.to(randf_range(-PI, PI))
	await _posture_2d_expression.wait()
	%Posture2D_Graph.add_marker(color_marker_end)
	%Posture2D_Cancel.disabled = true

func _on_posture_2d_cancel_pressed() -> void:
	if _posture_2d_expression != null:
		await _posture_2d_expression.wait(Cancel.canceled())
		_posture_2d_expression = null
		%Posture2D_Cancel.disabled = true

func _on_posture_3d_start_pressed() -> void:
	%Posture3D_Cancel.disabled = false
	%Posture3D_Graph.add_marker(color_marker_start)
	_posture_3d_expression = %Posture3D_Transition.create(%Posture3D, ^"angle")
	if _posture_3d_expression is not GlideMotionExpression:
		_posture_3d_expression = _posture_3d_expression.to(Vector2(randf_range(-PI, PI), randf_range(-PI, PI)))
	await _posture_3d_expression.wait()
	%Posture3D_Graph.add_marker(color_marker_end)
	%Posture3D_Cancel.disabled = true

func _on_posture_3d_cancel_pressed() -> void:
	if _posture_3d_expression != null:
		await _posture_3d_expression.wait(Cancel.canceled())
		_posture_3d_expression = null
		%Posture3D_Cancel.disabled = true
