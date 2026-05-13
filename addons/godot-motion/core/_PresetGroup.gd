#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func add(preset: MotionPreset) -> void:
	assert(is_instance_valid(preset))
	assert(not preset.get_preset_name().is_empty())

	var preset_group := _preset_groups_by_preset_name.get(preset.get_preset_name())
	if preset_group == null:
		preset_group = _PRESET_GROUP_ITEM_CLASS.new()
		_preset_groups_by_preset_name[preset.get_preset_name()] = preset_group
	preset_group.add(preset)

func remove(preset: MotionPreset) -> bool:
	assert(is_instance_valid(preset))
	assert(not preset.get_preset_name().is_empty())

	var preset_group := _preset_groups_by_preset_name.get(preset.get_preset_name())
	if preset_group != null and preset_group.remove(preset):
		_preset_groups_by_preset_name.erase(preset.get_preset_name())
	return _preset_groups_by_preset_name.is_empty()

func get_preset(preset_name: StringName) -> MotionPreset:
	var preset_group := _preset_groups_by_preset_name.get(preset_name)
	if preset_group == null:
		return null
	return preset_group.get_preset()

#-------------------------------------------------------------------------------

const _PRESET_GROUP_ITEM_CLASS := preload("uid://da25c7yolp41t")

var _preset_groups_by_preset_name: Dictionary[StringName, _PRESET_GROUP_ITEM_CLASS]
