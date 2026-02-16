class_name GDUT_StepsMotionPresetPreview extends GDUT_PerceivedMotionPresetPreview

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func reset() -> void:
	var preset := get_preset() as StepsMotionPreset
	_segments = preset.segments
	_inv_segments = 1.0 / preset.segments
	_round = \
		ceilf \
		if preset.round == GDUT_StepsMotionTransition.ROUND_CEIL else \
		floorf

func solve(t: float) -> float:
	t /= get_duration()
	return _round.call(t * _segments) * _inv_segments

#-------------------------------------------------------------------------------

var _segments: float
var _inv_segments: float
var _round: Callable
