class_name GDUT_PhysicsMotionPresetInspectorPlugin extends GDUT_MotionPresetInspectorPlugin

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_velocity_edit_visibility() -> bool:
	return true

func create_preview(preset: MotionPreset) -> GDUT_MotionPresetPreview:
	var preview: GDUT_MotionPresetPreview
	var preset_script: Script = preset.get_script()
	match preset_script.get_global_name():
		&"GlideMotionPreset":
			preview = GDUT_GlideMotionPresetPreview.new()
			preview.set_preset(preset as GlideMotionPreset)
			preview.set_final_position_text_visibility(false)
		&"SpringMotionPreset":
			preview = GDUT_SpringMotionPresetPreview.new()
			preview.set_preset(preset as SpringMotionPreset)
	return preview
