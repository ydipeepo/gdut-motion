<<<<<<< Updated upstream
=======
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
>>>>>>> Stashed changes
@icon("MotionPresetBank.png")
class_name MotionPresetBank extends Node

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
=======
## Array to include presets.
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
=======
# Apply setting presets to the target. (Used internally by the add-on)
>>>>>>> Stashed changes
static func apply_preset(
	preset_name: StringName,
	target: Object) -> bool:

	assert(not preset_name.is_empty())
	assert(is_instance_valid(target))

	var target_script: Script = target.get_script()
	var target_script_id := target_script.get_instance_id()
<<<<<<< Updated upstream
	if target_script_id not in _presets_by_target_script_id:
		return false

	var presets_by_name: Dictionary[StringName, Array] = _presets_by_target_script_id[target_script_id]
	if preset_name not in presets_by_name:
		return false

	var presets: Array[MotionPreset] = presets_by_name[preset_name]
	var preset := presets.pick_random()
=======
	var preset_set: GDUT_MotionPresetSet = _preset_sets_by_target_script_id.get(target_script_id)
	if preset_set == null:
		return false

	var preset := preset_set.get_preset(preset_name)
	if preset == null:
		return false

>>>>>>> Stashed changes
	preset.apply(target)
	return true

#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
static var _presets_by_target_script_id: Dictionary[int, Dictionary]
var _presets: Array[MotionPreset]

static func _add_preset(preset: MotionPreset) -> void:
	assert(is_instance_valid(preset))

	var target_script_id := preset.get_target_script_id()
	var presets_by_name: Dictionary[StringName, Array]
	if target_script_id in _presets_by_target_script_id:
		presets_by_name = _presets_by_target_script_id[target_script_id]
	else:
		presets_by_name = {}
		_presets_by_target_script_id[target_script_id] = presets_by_name

	var presets: Array[MotionPreset]
	if preset.name in presets_by_name:
		presets = presets_by_name[preset.name]
	else:
		presets = []
		presets_by_name[preset.name] = presets
	presets.push_back(preset)

static func _remove_preset(preset: MotionPreset) -> void:
	assert(is_instance_valid(preset))

	var target_script_id := preset.get_target_script_id()
	if target_script_id not in _presets_by_target_script_id:
		return

	var presets_by_name: Dictionary[StringName, Array] = _presets_by_target_script_id[target_script_id]
	if preset.name not in presets_by_name:
		return

	var presets: Array[MotionPreset] = presets_by_name[preset.name]
	var preset_position := presets.rfind(preset)
	if preset_position == -1:
		return

	presets.remove_at(preset_position)
	if presets.is_empty():
		presets_by_name.erase(preset.name)
	if presets_by_name.is_empty():
		_presets_by_target_script_id.erase(target_script_id)
=======
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
>>>>>>> Stashed changes

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
