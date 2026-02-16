@abstract
class_name GDUT_PerceivedMotionPresetPreview extends GDUT_MotionPresetPreview

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_duration() -> float:
	var preset := get_preset() as PerceivedMotionPreset
	return preset.duration
