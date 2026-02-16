class_name GDUT_TweenMotionPresetPreview extends GDUT_PerceivedMotionPresetPreview

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func reset() -> void:
	var preset := get_preset() as TweenMotionPreset
	_get_value = GDUT_TweenMotionTransition.get_value_function(preset.trans, preset.ease)

func solve(t: float) -> float:
	t /= get_duration()
	return _get_value.call(t)

#-------------------------------------------------------------------------------

var _get_value: Callable
