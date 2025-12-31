@tool
extends EditorPlugin

#-------------------------------------------------------------------------------

static func _add_setting(
	key: String,
	default_value: Variant,
	property_hint := PROPERTY_HINT_NONE,
	property_hint_string := "") -> void:

	if not ProjectSettings.has_setting(key):
		var property_info := {
			"name": key,
			"type": typeof(default_value),
			"hint": property_hint,
			"hint_string": property_hint_string,
		}

		ProjectSettings.set_setting(key, default_value)
		ProjectSettings.add_property_info(property_info)
		ProjectSettings.set_initial_value(key, default_value)
		ProjectSettings.set_as_basic(key, true)

static func _remove_setting(key: String) -> void:
	ProjectSettings.clear(key)

func _add_canonical() -> void:
	add_autoload_singleton("GDUT_MotionCanonical", "GDUT_MotionCanonical.gd")

func _remove_canonical() -> void:
	remove_autoload_singleton("GDUT_MotionCanonical")

func _add_custom_types() -> void:
	add_custom_type(
		"MotionPresetBank",
		"Node",
		preload("MotionPresetBank.gd"),
		preload("MotionPresetBank.png"))

func _remove_custom_types() -> void:
	remove_custom_type("MotionPresetBank")

#func _print(message: String, plugin_name: Variant = null) -> void:
#	if OS.has_feature("editor"):
#		if plugin_name == null:
#			plugin_name = _get_plugin_name()
#		print_rich("🔌 [u]", plugin_name, "[/u]: ", message)

func _get_plugin_name() -> String:
	return "GDUT Motion"

func _enable_plugin() -> void:
	_add_canonical()

func _disable_plugin() -> void:
	_remove_canonical()

func _enter_tree() -> void:
	_add_setting("gdut/motion/transition_processor/retention_duration", 5.0, PROPERTY_HINT_RANGE, "0,60")
	_add_setting("gdut/motion/debug/suppress_warning_message", false, 0, "")
	_add_setting("gdut/motion/debug/suppress_error_message", false, 0, "")
	_add_setting("gdut/motion/debug/user_time_scale_detection_enabled", true, 0, "")
	_add_setting("gdut/motion/debug/user_time_scale_detection_sample_count", 15, PROPERTY_HINT_RANGE, "1,60")
	_add_setting("gdut/motion/debug/user_time_scale_detection_initial_skip_count", 30, PROPERTY_HINT_RANGE, "1,120")
	_add_custom_types()
#	_print("Activated.")

func _exit_tree() -> void:
	_remove_custom_types()
	_remove_setting("gdut/motion/transition_processor/retention_duration")
	_remove_setting("gdut/motion/debug/suppress_warning_message")
	_remove_setting("gdut/motion/debug/suppress_error_message")
	_remove_setting("gdut/motion/debug/user_time_scale_detection_enabled")
	_remove_setting("gdut/motion/debug/user_time_scale_detection_sample_count")
	_remove_setting("gdut/motion/debug/user_time_scale_detection_initial_skip_count")
