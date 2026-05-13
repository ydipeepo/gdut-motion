@icon("MotionPresetBank.png")
class_name MotionPresetBank extends Node

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export
var presets: Array[MotionPreset]:
	set = set_presets,
	get = get_presets

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func apply(
	preset_name: StringName,
	transition_factory: MotionTransitionFactory,
	expression_name := &"") -> void:

	assert(is_instance_valid(transition_factory))

	var preset: MotionPreset
	if not preset_name.is_empty():
		var transition_factory_class: Script = transition_factory.get_script()
		var target_class_id := transition_factory_class.get_instance_id()
		var preset_group: _PRESET_GROUP_CLASS = _preset_groups_by_target_class_id.get(target_class_id)
		if preset_group != null:
			preset = preset_group.get_preset(preset_name)
	if preset == null:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_PRESET_NAME",
			expression_name,
			preset_name)
		return

	preset.apply(transition_factory)

func get_presets() -> Array[MotionPreset]:
	return _presets

func set_presets(value: Array[MotionPreset]) -> void:
	_on_presets_changing()
	_presets = value
	_on_presets_changed()

#-------------------------------------------------------------------------------

const _AUTOLOAD_CLASS := preload("uid://p04dph4xrfh3")
const _PRESET_GROUP_CLASS := preload("uid://c011wxf1m8lfj")

static var _preset_groups_by_target_class_id: Dictionary[int, _PRESET_GROUP_CLASS]
var _presets: Array[MotionPreset]

static func _add_preset(preset: MotionPreset) -> void:
	if is_instance_valid(preset) and preset.is_valid():
		for target_class_id: int in preset.get_target_class_ids():
			var preset_group: _PRESET_GROUP_CLASS = _preset_groups_by_target_class_id.get(target_class_id)
			if preset_group == null:
				preset_group = _PRESET_GROUP_CLASS.new()
				_preset_groups_by_target_class_id[target_class_id] = preset_group
			preset_group.add(preset)

static func _remove_preset(preset: MotionPreset) -> void:
	if is_instance_valid(preset) and preset.is_valid():
		for target_class_id: int in preset.get_target_class_ids():
			var preset_group: _PRESET_GROUP_CLASS = _preset_groups_by_target_class_id.get(target_class_id)
			if preset_group != null and preset_group.remove(preset):
				_preset_groups_by_target_class_id.erase(target_class_id)

func _enter_tree() -> void:
	for preset: MotionPreset in _presets:
		if is_instance_valid(preset):
			_add_preset(preset)
			preset.criteria_invalidating.connect(_on_preset_criteria_invalidating.bind(preset))
			preset.criteria_invalidated.connect(_on_preset_criteria_invalidated.bind(preset))

func _exit_tree() -> void:
	for preset: MotionPreset in _presets:
		if is_instance_valid(preset):
			preset.criteria_invalidated.disconnect(_on_preset_criteria_invalidated)
			preset.criteria_invalidating.disconnect(_on_preset_criteria_invalidating)
			_remove_preset(preset)

func _on_presets_changing() -> void:
	if is_inside_tree():
		for preset: MotionPreset in _presets:
			if is_instance_valid(preset):
				preset.criteria_invalidated.disconnect(_on_preset_criteria_invalidated)
				preset.criteria_invalidating.disconnect(_on_preset_criteria_invalidating)
				_remove_preset(preset)

func _on_presets_changed() -> void:
	if is_inside_tree():
		for preset: MotionPreset in _presets:
			if is_instance_valid(preset):
				_add_preset(preset)
				preset.criteria_invalidating.connect(_on_preset_criteria_invalidating.bind(preset))
				preset.criteria_invalidated.connect(_on_preset_criteria_invalidated.bind(preset))

static func _on_preset_criteria_invalidating(preset: MotionPreset) -> void:
	_remove_preset(preset)

static func _on_preset_criteria_invalidated(preset: MotionPreset) -> void:
	_add_preset(preset)
