@abstract
extends Control

#-------------------------------------------------------------------------------
#	SIGNALS
#-------------------------------------------------------------------------------

signal playable_changed(playable: bool)

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_resource() -> MotionPreset:
	return _preset

func set_resource(preset: MotionPreset) -> void:
	if is_instance_valid(_preset):
		_preset.changed.disconnect(_on_preset_changed)
	_preset = preset
	if is_instance_valid(_preset):
		_preset.changed.connect(_on_preset_changed)
		reset()

func get_theme_mono_color() -> Color:
	return _theme_mono_color

func get_theme_font_color() -> Color:
	return _theme_font_color

func get_theme_margin() -> float:
	return _theme_margin

func has_initial_velocity() -> bool:
	return false

@warning_ignore("unused_parameter")
func set_initial_velocity(value: float) -> void:
	reset()
	queue_redraw()

func get_initial_velocity() -> float:
	return 0.0

func get_min_initial_velocity() -> float:
	return 0.0

func get_max_initial_velocity() -> float:
	return 0.0

func get_playback_time() -> float:
	return _playback_time

func is_playable() -> bool:
	return true

func is_playing() -> bool:
	return _playback

func play() -> void:
	if is_instance_valid(_preset) and 0.0 < get_duration():
		_playback = true
		_playback_time = 0.0
		set_process(true)

func draw_dashed_polyline(
	points: PackedVector2Array,
	color: Color,
	width: float,
	dash_length: float,
	gap_length: float) -> void:

	if 2 <= points.size():
		var draw_segment := true
		var remaining := dash_length
		var pattern_length := dash_length + gap_length
		var p1 := points[0]
		var p2: Vector2
		for i: int in range(1, points.size()):
			p2 = points[i]
			var segment := p2 - p1
			var length := segment.length()
			if not is_zero_approx(length):
				var direction := segment / length
				var traveled := 0.0
				while traveled < length:
					var step := minf(remaining, length - traveled)
					if draw_segment:
						draw_line(
							p1 + direction * traveled,
							p1 + direction * (traveled + step),
							color,
							width,
							true)
					traveled += step
					remaining -= step
					if remaining <= 0.0:
						draw_segment = not draw_segment
						remaining = dash_length if draw_segment else gap_length
			p1 = p2

func draw(transform: Transform2D) -> void:
	var points_size := maxi(int(size.x - _theme_margin * 3.0) / 2.0, 1)
	var points1: PackedVector2Array
	var points2: PackedVector2Array

	var duration := get_duration()
	var t := get_playback_time()
	for i: int in points_size + 1:
		var x := i / float(points_size)
		var y := get_position_(x * duration)
		var p := transform * Vector2(x, y)
		if x * duration <= t:
			points1.append(p)
		else:
			points2.append(p)
	points2.reverse()

	draw_set_transform_matrix(Transform2D.IDENTITY)
	if 2 <= points1.size():
		draw_polyline(points1, _theme_font_color, 0.5, true)
	if 2 <= points2.size():
		draw_dashed_polyline(points2, _theme_font_color, 0.5, 4.0, 4.0)

@abstract
func reset() -> void

@abstract
func get_duration() -> float

@abstract
func get_position_(t: float) -> float

@abstract
func get_velocity(t: float) -> float

#-------------------------------------------------------------------------------

const _ASPECT_RATIO := 6.0 / 13.0
const _CROSSHAIR_X_LINE_COLOR := Color(1.0, 0.0, 0.0, 0.5)
const _CROSSHAIR_Y_LINE_COLOR := Color(0.0, 0.0, 1.0, 0.5)
const _TANGENT_LINE_COLOR := Color(0.0, 1.0, 0.0, 0.5)
const _GRID_STEPS := Vector2i(4, 2)
const _POINT_TEXT := "P"
const _POINT_SUBSCRIPT_FROM_TEXT := "from"
const _POINT_SUBSCRIPT_TO_TEXT := "to"

var _preset: MotionPreset
var _editor_scale := EditorInterface.get_editor_scale()
var _theme_panel_stylebox: StyleBox
var _theme_font: Font
var _theme_font_size: int
var _theme_font_height: float
var _theme_font_color: Color
var _theme_mono_color: Color
var _theme_margin: float
var _transform: Transform2D
var _transform_inverse: Transform2D
var _playback: bool
var _playback_time: float

func _theme_changed() -> void:
	_theme_panel_stylebox = get_theme_stylebox(&"panel", &"Tree")
	_theme_font = get_theme_font(&"font", &"Label")
	_theme_font_size = get_theme_font_size(&"font_size", &"Label")
	_theme_font_height = _theme_font.get_height(_theme_font_size)
	_theme_font_color = get_theme_color(&"font_color", &"Editor")
	_theme_mono_color = get_theme_color(&"mono_color", &"Editor")
	_theme_margin = _theme_font_height + _editor_scale * 2.0

func _resized() -> void:
	var margin_left := _theme_margin * 2.0
	var margin_top := _theme_margin
	var margin_right := _theme_margin * 1.5
	var margin_bottom := _theme_margin
	_transform = Transform2D() \
		.translated_local(Vector2.UP) \
		.scaled(Vector2(
			maxf(size.x - (margin_left + margin_right), 0.0001),
			minf((margin_top + margin_bottom) - size.y, 0.0001))) \
		.translated(Vector2(
			margin_left,
			margin_top))
	_transform_inverse = _transform.affine_inverse()

func _get_minimum_size() -> Vector2:
	return _editor_scale * Vector2(
		64.0,
		maxf(135.0, size.x * _ASPECT_RATIO))

func _init() -> void:
	clip_contents = true

func _process(delta: float) -> void:
	_playback_time += delta

	var duration := get_duration()
	if not is_instance_valid(_preset) or duration < _playback_time:
		_playback = false
		_playback_time = duration
		set_process(false)

	queue_redraw()

func _draw() -> void:
	if not is_instance_valid(_preset):
		return

	var step_size := Vector2.ONE / Vector2(_GRID_STEPS)
	var min_edge := _transform_inverse * Vector2(0.0, size.y)
	var max_edge := _transform_inverse * Vector2(size.x, 0.0)
	var pad := roundf(_editor_scale * 2.0)
	var font_size_primary := _theme_font_size
	var font_size := int(_theme_font_size * 0.8)
	var grid_color_primary := Color(_theme_mono_color, 0.25)
	var grid_color := Color(_theme_mono_color, 0.1)

	#
	# Panel & Grid
	#

	draw_style_box(_theme_panel_stylebox, Rect2(Vector2.ZERO, size))

	if is_playable():
		draw_set_transform_matrix(_transform)
		draw_line(Vector2(min_edge.x, 0.0), Vector2(max_edge.x, 0.0), grid_color_primary)
		draw_line(Vector2(min_edge.x, 1.0), Vector2(max_edge.x, 1.0), grid_color_primary)
		draw_line(Vector2(0.0, min_edge.y), Vector2(0.0, max_edge.y), grid_color_primary)
		draw_line(Vector2(1.0, min_edge.y), Vector2(1.0, max_edge.y), grid_color_primary)
		for i: int in range(1, _GRID_STEPS.x):
			var x := i * step_size.x
			draw_line(Vector2(x, min_edge.y), Vector2(x, max_edge.y), grid_color)
		for i: int in range(1, _GRID_STEPS.y):
			var y := i * step_size.y
			draw_line(Vector2(min_edge.x, y), Vector2(max_edge.x, y), grid_color)
	else:
		draw_set_transform_matrix(Transform2D.IDENTITY)
		draw_line(_transform * Vector2(min_edge.x, min_edge.y), _transform * Vector2(max_edge.x, max_edge.y), Color.RED, 0.5, true)
		draw_line(_transform * Vector2(max_edge.x, min_edge.y), _transform * Vector2(min_edge.x, max_edge.y), Color.RED, 0.5, true)

	#
	# Trajectory
	#

	if is_playable():
		if _playback:
			var duration := get_duration()
			var x := _playback_time / duration
			var y := get_position_(_playback_time)
			var dy := get_velocity(_playback_time) * duration
			draw_set_transform_matrix(_transform)
			draw_line(Vector2(min_edge.x, y), Vector2(max_edge.x, y), _CROSSHAIR_X_LINE_COLOR)
			draw_line(Vector2(x, min_edge.y), Vector2(x, max_edge.y), _CROSSHAIR_Y_LINE_COLOR)
			draw_set_transform_matrix(Transform2D.IDENTITY)
			draw_line(
				_transform * Vector2(min_edge.x, y + dy * (min_edge.x - x)),
				_transform * Vector2(max_edge.x, y + dy * (max_edge.x - x)),
				_TANGENT_LINE_COLOR,
				1.0)
			draw_circle(_transform * Vector2(x, y), 3.0, _theme_mono_color.inverted(), true)
			draw_circle(_transform * Vector2(x, y), 3.0, _theme_mono_color, false, 2.0)
		else:
			draw_set_transform_matrix(Transform2D.IDENTITY)
		draw(_transform)

	#
	# Tick Labels
	#

	if is_playable():
		for i: int in _GRID_STEPS.x + 1:
			var x := i * step_size.x
			var p := _transform * Vector2(x, 0.0)
			p.x += pad
			p.y += _theme_font_height - pad
			draw_string(_theme_font, p, String.num(x * get_duration(), 2), HORIZONTAL_ALIGNMENT_CENTER, -1, font_size_primary, _theme_font_color)
		for i: int in _GRID_STEPS.y + 1:
			var point_subscript_text: String
			match i:
				0:
					point_subscript_text = _POINT_SUBSCRIPT_FROM_TEXT
				_GRID_STEPS.y:
					point_subscript_text = _POINT_SUBSCRIPT_TO_TEXT
				_:
					continue
			var y := i * step_size.y
			var point_text_width := _theme_font.get_string_size(_POINT_TEXT, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size_primary).x
			var point_subscript_text_width := _theme_font.get_string_size(point_subscript_text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
			var p := _transform * Vector2(0.0, y) - Vector2(pad + point_text_width + point_subscript_text_width, pad)
			draw_string(_theme_font, p, _POINT_TEXT, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size_primary, _theme_font_color)
			p = _transform * Vector2(0.0, y) - Vector2(pad + point_subscript_text_width, pad)
			draw_string(_theme_font, p, point_subscript_text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, _theme_font_color)

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_THEME_CHANGED:
			_theme_changed()

		NOTIFICATION_READY:
			_theme_changed()
			_resized()
			_playback = false
			_playback_time = get_duration()
			set_process(false)

		NOTIFICATION_RESIZED:
			_resized()

func _on_preset_changed() -> void:
	set_process(false)
	reset()
	_playback = false
	_playback_time = get_duration()
	playable_changed.emit(is_playable())
	queue_redraw()
