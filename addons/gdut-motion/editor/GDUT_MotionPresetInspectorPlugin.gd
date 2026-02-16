@abstract
class_name GDUT_MotionPresetInspectorPlugin extends EditorInspectorPlugin

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_velocity_edit_visibility() -> bool:
	return false

@abstract
func create_preview(preset: MotionPreset) -> GDUT_MotionPresetPreview

#-------------------------------------------------------------------------------

func _can_handle(object: Object) -> bool:
	return object is MotionPreset

func _parse_begin(object: Object) -> void:
	const SPACING := 4.0

	var preview := create_preview(object as MotionPreset)
	if is_instance_valid(preview):
		var base_control := EditorInterface.get_base_control()

		var play_button: Button
		var velocity_edit: EditorSpinSlider
		var velocity_reset_button: Button

		play_button = Button.new()
		play_button.tooltip_text = GDUT_Motion.get_message(&"PRESET_PREVIEW_PLAY_CURVE")
		play_button.icon = base_control.get_theme_icon(&"Play", &"EditorIcons")
		play_button.pressed.connect(preview.play)

		if get_velocity_edit_visibility():
			velocity_edit = EditorSpinSlider.new()
			velocity_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			velocity_edit.min_value = preview.get_minimum_initial_velocity()
			velocity_edit.max_value = preview.get_maximum_initial_velocity()
			velocity_edit.step = 0.1
			velocity_edit.value = 0.0
			velocity_edit.suffix = "units/s"
			velocity_edit.accessibility_name = GDUT_Motion.get_message(&"PRESET_PREVIEW_VELOCITY")
			velocity_edit.value_changed.connect(preview.set_initial_velocity)

			velocity_reset_button = Button.new()
			velocity_reset_button.tooltip_text = GDUT_Motion.get_message(&"PRESET_PREVIEW_RESET_VELOCITY")
			velocity_reset_button.icon = base_control.get_theme_icon(&"Reload", &"EditorIcons")
			velocity_reset_button.pressed.connect(func () -> void:
				velocity_edit.value = 0.0
				preview.set_initial_velocity.bind(0.0))

		var toolbar := HFlowContainer.new()
		toolbar.add_child(play_button)
		if get_velocity_edit_visibility():
			toolbar.add_child(velocity_edit)
			toolbar.add_child(velocity_reset_button)

		var bottom_space := Control.new()
		bottom_space.custom_minimum_size = Vector2(0, EditorInterface.get_editor_scale() * SPACING)

		var container := VBoxContainer.new()
		container.mouse_filter = Control.MOUSE_FILTER_STOP
		container.add_child(toolbar)
		container.add_child(preview)
		container.add_child(bottom_space)

		add_custom_control(container)
