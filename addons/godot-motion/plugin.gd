@tool
extends EditorPlugin

#-------------------------------------------------------------------------------

const _PRESET_INSPECTOR_PLUGIN_CLASS := preload("uid://bmf7jv0l6a0v8")

var _preset_inspector_plugin: _PRESET_INSPECTOR_PLUGIN_CLASS

static func _add_setting(
	key: String,
	default_value: Variant,
	property_hint := PROPERTY_HINT_NONE,
	property_hint_string := "") -> void:

	if not ProjectSettings.has_setting(key):
		var property_info := {
			&"name": key,
			&"type": typeof(default_value),
			&"hint": property_hint,
			&"hint_string": property_hint_string,
		}

		ProjectSettings.set_setting(key, default_value)
		ProjectSettings.add_property_info(property_info)
		ProjectSettings.set_initial_value(key, default_value)
		ProjectSettings.set_as_basic(key, true)

func _get_plugin_name() -> String:
	return "Godot Motion"

func _enable_plugin() -> void:
	var autoload_path := ResourceUID.ensure_path("uid://p04dph4xrfh3")
	add_autoload_singleton("_MotionAutoload", autoload_path)

func _disable_plugin() -> void:
	remove_autoload_singleton("_MotionAutoload")

func _enter_tree() -> void:
	_preset_inspector_plugin = _PRESET_INSPECTOR_PLUGIN_CLASS.new()

	_add_setting("godot_motion/transition_processor/retention_duration", 5.0, PROPERTY_HINT_RANGE, "0,60")
	_add_setting("godot_motion/debug/suppress_warning_message", false)
	_add_setting("godot_motion/debug/suppress_error_message", false)
	_add_setting("godot_motion/debug/user_time_scale_detection_enabled", true)
	_add_setting("godot_motion/debug/user_time_scale_detection_sample_count", 15, PROPERTY_HINT_RANGE, "1,60")
	_add_setting("godot_motion/debug/user_time_scale_detection_initial_skip_count", 30, PROPERTY_HINT_RANGE, "1,120")

	add_custom_type(
		"MotionPresetBank",
		"Node",
		preload("uid://bu14ry6fs0vok"),
		preload("uid://drdvvrohcwa2m"))
	add_inspector_plugin(_preset_inspector_plugin)

func _exit_tree() -> void:
	remove_inspector_plugin(_preset_inspector_plugin)
	remove_custom_type("MotionPresetBank")

	ProjectSettings.clear("godot_motion/transition_processor/retention_duration")
	ProjectSettings.clear("godot_motion/debug/suppress_warning_message")
	ProjectSettings.clear("godot_motion/debug/suppress_error_message")
	ProjectSettings.clear("godot_motion/debug/user_time_scale_detection_enabled")
	ProjectSettings.clear("godot_motion/debug/user_time_scale_detection_sample_count")
	ProjectSettings.clear("godot_motion/debug/user_time_scale_detection_initial_skip_count")

	_preset_inspector_plugin = null
