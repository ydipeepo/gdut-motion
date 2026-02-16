class_name GDUT_PerceivedMotionPresetInspectorPlugin extends GDUT_MotionPresetInspectorPlugin

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func create_preview(preset: MotionPreset) -> GDUT_MotionPresetPreview:
	var preview: GDUT_PerceivedMotionPresetPreview
	var preset_script: Script = preset.get_script()
	match preset_script.get_global_name():
		&"BezierMotionPreset":
			preview = GDUT_BezierMotionPresetPreview.new()
			preview.set_preset(preset as BezierMotionPreset)
		&"IrregularMotionPreset":
			preview = GDUT_IrregularMotionPresetPreview.new()
			preview.set_preset(preset as IrregularMotionPreset)
		&"LinearMotionPreset":
			preview = GDUT_LinearMotionPresetPreview.new()
			preview.set_preset(preset as LinearMotionPreset)
		&"StepsMotionPreset":
			preview = GDUT_StepsMotionPresetPreview.new()
			preview.set_preset(preset as StepsMotionPreset)
		&"TweenMotionPreset":
			preview = GDUT_TweenMotionPresetPreview.new()
			preview.set_preset(preset as TweenMotionPreset)
	return preview
