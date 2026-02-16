class_name GDUT_MotionPresetSet

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func add(preset: MotionPreset) -> void:
	assert(is_instance_valid(preset))
	assert(not preset.name.is_empty())

	var preset_group := _preset_groups_by_name.get(preset.name)
	if preset_group == null:
		preset_group = _Group.new()
		_preset_groups_by_name[preset.name] = preset_group
	preset_group.add(preset)

func remove(preset: MotionPreset) -> bool:
	assert(is_instance_valid(preset))
	assert(not preset.name.is_empty())

	var preset_group := _preset_groups_by_name.get(preset.name)
	if preset_group != null and preset_group.remove(preset):
		_preset_groups_by_name.erase(preset.name)
	return _preset_groups_by_name.is_empty()

func get_preset(preset_name: StringName) -> MotionPreset:
	var preset_group := _preset_groups_by_name.get(preset_name)
	return \
		preset_group.get_preset() \
		if preset_group != null else \
		null

#-------------------------------------------------------------------------------

class _Group:

	func add(preset: MotionPreset) -> void:
		assert(preset not in _presets)
		preset.probability_changed.connect(_on_preset_probability_changed)
		_presets.append(preset)
		_presets_dirty = true

	func remove(preset: MotionPreset) -> bool:
		assert(preset in _presets)
		_presets.remove_at(_presets.find(preset))
		_presets_dirty = true
		preset.probability_changed.disconnect(_on_preset_probability_changed)
		return _presets.is_empty()

	func get_preset() -> MotionPreset:
		if _presets_dirty:
			var accumulated_probability := 0.0
			for preset: MotionPreset in _presets:
				accumulated_probability += preset.probability
			_accumulated_probability = accumulated_probability
			_presets_dirty = false
		var probability := randf() * _accumulated_probability
		var accumulating_probability := 0.0
		for preset: MotionPreset in _presets:
			accumulating_probability += preset.probability
			if probability <= accumulating_probability:
				return preset
		return _presets.back()

	var _presets: Array[MotionPreset]
	var _presets_dirty: bool
	var _accumulated_probability: float

	func _on_preset_probability_changed() -> void:
		_presets_dirty = true

var _preset_groups_by_name: Dictionary[StringName, _Group]
