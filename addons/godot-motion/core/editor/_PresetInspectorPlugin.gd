extends EditorInspectorPlugin

#-------------------------------------------------------------------------------

const _AUTOLOAD_CLASS := preload("uid://p04dph4xrfh3")
const _PRESET_PREVIEW_CLASS := preload("uid://cia12nj0vs12b")

const _SPACING := 4.0

func _create_preset_preview(preset: MotionPreset) -> _PRESET_PREVIEW_CLASS:
	var preset_preview: _PRESET_PREVIEW_CLASS
	var preset_class: Script = preset.get_script()
	match preset_class:
		DecayMotionPreset:
			preset_preview = preload("uid://bx1uut7kke2e1").new()
			preset_preview.set_resource(preset)
		EasingMotionPreset:
			preset_preview = preload("uid://d3td8uykjlxyw").new()
			preset_preview.set_resource(preset)
		SpringMotionPreset:
			preset_preview = preload("uid://chmmixll1ha1d").new()
			preset_preview.set_resource(preset)
	return preset_preview

func _can_handle(object: Object) -> bool:
	return object is MotionPreset

func _parse_begin(object: Object) -> void:
	var preset_preview := _create_preset_preview(object)
	if is_instance_valid(preset_preview):
		var base_control := EditorInterface.get_base_control()

		var play_button: Button
		var velocity_edit: EditorSpinSlider
		var velocity_reset_button: Button

		play_button = Button.new()
		play_button.tooltip_text = _AUTOLOAD_CLASS.get_message(&"PRESET_PREVIEW_PLAY_CURVE")
		play_button.icon = base_control.get_theme_icon(&"Play", &"EditorIcons")
		play_button.pressed.connect(preset_preview.play)

		if preset_preview.has_initial_velocity():
			velocity_edit = EditorSpinSlider.new()
			velocity_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			velocity_edit.min_value = preset_preview.get_min_initial_velocity()
			velocity_edit.max_value = preset_preview.get_max_initial_velocity()
			velocity_edit.step = 0.1
			velocity_edit.value = 0.0
			velocity_edit.suffix = "units/s"
			velocity_edit.accessibility_name = _AUTOLOAD_CLASS.get_message(&"PRESET_PREVIEW_VELOCITY")
			velocity_edit.value_changed.connect(preset_preview.set_initial_velocity)

			velocity_reset_button = Button.new()
			velocity_reset_button.tooltip_text = _AUTOLOAD_CLASS.get_message(&"PRESET_PREVIEW_RESET_VELOCITY")
			velocity_reset_button.icon = base_control.get_theme_icon(&"Reload", &"EditorIcons")
			velocity_reset_button.pressed.connect(func () -> void:
				var initial_velocity := clampf(0.0, preset_preview.get_min_initial_velocity(), preset_preview.get_max_initial_velocity())
				velocity_edit.value = initial_velocity
				preset_preview.set_initial_velocity(initial_velocity))

		var toolbar := HFlowContainer.new()
		toolbar.add_child(play_button)
		if preset_preview.has_initial_velocity():
			toolbar.add_child(velocity_edit)
			toolbar.add_child(velocity_reset_button)

		var bottom_space := Control.new()
		bottom_space.custom_minimum_size = Vector2(0, EditorInterface.get_editor_scale() * _SPACING)

		var container := VBoxContainer.new()
		container.mouse_filter = Control.MOUSE_FILTER_STOP
		container.add_child(toolbar)
		container.add_child(preset_preview)
		container.add_child(bottom_space)

		preset_preview.playable_changed.connect(func (playable: bool) -> void:
			play_button.disabled = not playable)

		add_custom_control(container)
