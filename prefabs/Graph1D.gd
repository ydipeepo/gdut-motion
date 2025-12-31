class_name Graph1D extends ColorRect

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_range(1, 1000, 1) var update_interval := 10
@export_range(0, 1000, 1) var tail_offset := 20
@export var value_color := Color.RED
@export var level_color := Color.DIM_GRAY
@export var level_array: Array[float]
@export var max_level := 1.0
@export var min_level := -1.0

var value := 0.0

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@warning_ignore("shadowed_variable_base_class")
func add_marker(color: Color) -> void:
	_value_marker = true
	_value_marker_color = color

#-------------------------------------------------------------------------------

var _last_elapsed_ticks: int
var _total_ticks: int
var _value_array: Array[Dictionary]
var _value_marker: bool
var _value_marker_color: Color

func _ready() -> void:
	_last_elapsed_ticks = Time.get_ticks_msec()

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	var ticks := Time.get_ticks_msec()
	var delta_ticks := ticks - _last_elapsed_ticks
	_last_elapsed_ticks = ticks
	_total_ticks += delta_ticks

	if update_interval <= _total_ticks:
		while update_interval <= _total_ticks:
			if _value_marker:
				_value_array.push_back({
					&"x": value,
					&"marker": true,
					&"marker_color": _value_marker_color,
				})
				_value_marker = false
			else:
				_value_array.push_back({
					&"x": value,
					&"marker": false,
				})
			_total_ticks -= update_interval
		var max_size := 1 + int(size.x) - tail_offset
		if max_size < _value_array.size():
			_value_array = _value_array.slice(_value_array.size() - max_size)

	queue_redraw()

func _draw() -> void:
	var value_x_polyline: PackedVector2Array
	var count := _value_array.size()
	for index in count:
		@warning_ignore("shadowed_variable")
		var value := _value_array[index]
		var value_x := roundf(remap(value.x, min_level, max_level, size.y, 0.0))
		value_x_polyline.push_back(Vector2(index, value_x))
		if value.marker:
			draw_line(Vector2(index, 0.0), Vector2(index, size.y), value.marker_color, 1.0)

	draw_line(Vector2(count, 0.0), Vector2(count, size.y), level_color, 1.0)
	for level: float in level_array:
		level = roundf(remap(level, min_level, max_level, size.y, 0.0))
		draw_line(Vector2(0.0, level), Vector2(size.x, level), level_color, 1.0)
	if 2 <= value_x_polyline.size():
		draw_polyline(value_x_polyline, value_color, 1.0)
