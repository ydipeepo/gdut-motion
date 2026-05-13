#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

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
			accumulated_probability += preset.get_probability()
		_accumulated_probability = accumulated_probability
		_presets_dirty = false
	var probability := randf() * _accumulated_probability
	var accumulating_probability := 0.0
	for preset: MotionPreset in _presets:
		accumulating_probability += preset.get_probability()
		if probability <= accumulating_probability:
			return preset
	return _presets.back()

#-------------------------------------------------------------------------------

var _presets: Array[MotionPreset]
var _presets_dirty: bool
var _accumulated_probability: float

func _on_preset_probability_changed() -> void:
	_presets_dirty = true
