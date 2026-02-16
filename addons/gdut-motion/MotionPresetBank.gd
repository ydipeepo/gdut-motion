## This node is used to register configuration presets.
##
## This node is used to manage animation definitions within the inspector.
## It can contain multiple animation definitions, separating script-based animation definitions
## as [MotionPreset] configuration presets.
## Separated presets can be loaded by name as follows:
## [codeblock]
## Motion \
##     .tween(self, "position:x") \
##     .preset("preset_name")
## [/codeblock]
## By specifying [member MotionPreset.name] in the [method MotionExpression.preset] method,
## the configuration preset will be applied to the animation expression [MotionExpression].
@icon("MotionPresetBank.png")
class_name MotionPresetBank extends Node

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## Array to include presets.
@export
var presets: Array[MotionPreset]:
	get:
		return _presets
	set(value):
		_on_presets_changing()
		_presets = value
		_on_presets_changed()

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

# Apply setting presets to the target. (Used internally by the add-on)
static func apply_preset(
	preset_name: StringName,
	target: Object) -> bool:

	assert(not preset_name.is_empty())
	assert(is_instance_valid(target))

	var target_script: Script = target.get_script()
	var target_script_id := target_script.get_instance_id()
	var preset_set: GDUT_MotionPresetSet = _preset_sets_by_target_script_id.get(target_script_id)
	if preset_set == null:
		return false

	var preset := preset_set.get_preset(preset_name)
	if preset == null:
		return false

	preset.apply(target)
	return true

#-------------------------------------------------------------------------------

static var _preset_sets_by_target_script_id: Dictionary[int, GDUT_MotionPresetSet]
var _presets: Array[MotionPreset]

static func _add_preset(preset: MotionPreset) -> void:
	if is_instance_valid(preset) and not preset.name.is_empty():
		var target_script_id := preset.get_target_script_id()
		var preset_set: GDUT_MotionPresetSet = _preset_sets_by_target_script_id.get(target_script_id)
		if preset_set == null:
			preset_set = GDUT_MotionPresetSet.new()
			_preset_sets_by_target_script_id[target_script_id] = preset_set
		preset_set.add(preset)

static func _remove_preset(preset: MotionPreset) -> void:
	if is_instance_valid(preset) and not preset.name.is_empty():
		var target_script_id := preset.get_target_script_id()
		var preset_set: GDUT_MotionPresetSet = _preset_sets_by_target_script_id.get(target_script_id)
		if preset_set != null and preset_set.remove(preset):
			_preset_sets_by_target_script_id.erase(target_script_id)

func _enter_tree() -> void:
	for preset: MotionPreset in _presets:
		if is_instance_valid(preset):
			_add_preset(preset)
			preset.name_changing.connect(_on_preset_name_changing.bind(preset))
			preset.name_changed.connect(_on_preset_name_changed.bind(preset))

func _exit_tree() -> void:
	for preset: MotionPreset in _presets:
		if is_instance_valid(preset):
			preset.name_changed.disconnect(_on_preset_name_changed)
			preset.name_changing.disconnect(_on_preset_name_changing)
			_remove_preset(preset)

func _on_presets_changing() -> void:
	if is_inside_tree():
		for preset: MotionPreset in _presets:
			if is_instance_valid(preset):
				preset.name_changed.disconnect(_on_preset_name_changed)
				preset.name_changing.disconnect(_on_preset_name_changing)
				_remove_preset(preset)

func _on_presets_changed() -> void:
	if is_inside_tree():
		for preset: MotionPreset in _presets:
			if is_instance_valid(preset):
				_add_preset(preset)
				preset.name_changing.connect(_on_preset_name_changing.bind(preset))
				preset.name_changed.connect(_on_preset_name_changed.bind(preset))

static func _on_preset_name_changing(preset: MotionPreset) -> void:
	_remove_preset(preset)

static func _on_preset_name_changed(preset: MotionPreset) -> void:
	_add_preset(preset)
