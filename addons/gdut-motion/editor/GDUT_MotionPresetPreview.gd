@abstract
class_name GDUT_MotionPresetPreview extends Control

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_preset() -> MotionPreset:
	return _preset

func set_preset(preset: MotionPreset) -> void:
		if is_instance_valid(_preset):
			_preset.changed.disconnect(_on_preset_changed)
		_preset = preset
		reset()
		if is_instance_valid(_preset):
			_preset.changed.connect(_on_preset_changed)

func set_final_position_text_visibility(value: bool) -> void:
	if _draw_final_position != value:
		_draw_final_position = value
		queue_redraw()

@abstract
func get_duration() -> float

func play() -> void:
	if is_instance_valid(_preset) and 0.0 < get_duration():
		_play = true
		_play_elapsed_time = 0.0
		set_process(true)

func draw(transform: Transform2D) -> void:
	var points := PackedVector2Array([transform * Vector2.ZERO])
	var points_count := maxi(int(size.x - _theme_margin * 4.0), 1)
	for i: int in points_count + 1:
		var x := i / float(points_count)
		var y := solve(x * get_duration())
		points.push_back(transform * Vector2(x, y))
	draw_set_transform_matrix(Transform2D())
	draw_polyline(points, _theme_font_color, 0.5, true)

@abstract
func reset() -> void

@abstract
func solve(t: float) -> float

#-------------------------------------------------------------------------------

const _ASPECT_RATIO := 6.0 / 13.0
const _CROSSHAIR_X_LINE_COLOR := Color(1.0, 0.0, 0.0, 0.75)
const _CROSSHAIR_Y_LINE_COLOR := Color(0.0, 1.0, 0.0, 0.75)
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
var _play: bool
var _play_elapsed_time: float
var _draw_final_position := true

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
	set_process(false)

func _process(delta: float) -> void:
	_play_elapsed_time += delta
	if not is_instance_valid(_preset) or get_duration() < _play_elapsed_time:
		_play = false
		set_process(false)
	queue_redraw()

func _draw() -> void:
	if is_instance_valid(_preset):
		var step_size := Vector2.ONE / Vector2(_GRID_STEPS)
		var min_edge := _transform_inverse * Vector2(0.0, size.y)
		var max_edge := _transform_inverse * Vector2(size.x, 0.0)
		var pad := roundf(_editor_scale * 2.0)
		var font_size_primary := _theme_font_size
		var font_size := int(_theme_font_size * 0.8)
		var grid_color_primary := Color(_theme_mono_color, 0.25)
		var grid_color := Color(_theme_mono_color, 0.1)

		draw_style_box(_theme_panel_stylebox, Rect2(Vector2.ZERO, size))
		draw_set_transform_matrix(_transform)
		draw_line(Vector2(min_edge.x, 0.0), Vector2(max_edge.x, 0.0), grid_color_primary)
		if _draw_final_position:
			draw_line(Vector2(min_edge.x, 1.0), Vector2(max_edge.x, 1.0), grid_color_primary)
		else:
			draw_line(Vector2(min_edge.x, 1.0), Vector2(max_edge.x, 1.0), grid_color)
		draw_line(Vector2(0.0, min_edge.y), Vector2(0.0, max_edge.y), grid_color_primary)
		draw_line(Vector2(1.0, min_edge.y), Vector2(1.0, max_edge.y), grid_color_primary)
		for i: int in range(1, _GRID_STEPS.x):
			var x := i * step_size.x
			draw_line(Vector2(x, min_edge.y), Vector2(x, max_edge.y), grid_color)
		for i: int in range(1, _GRID_STEPS.y):
			var y := i * step_size.y
			draw_line(Vector2(min_edge.x, y), Vector2(max_edge.x, y), grid_color)
		draw(_transform)
		if _play:
			var x := _play_elapsed_time / get_duration()
			var y := solve(x * get_duration())
			var p := Vector2(x, y)
			draw_set_transform_matrix(_transform)
			draw_line(Vector2(min_edge.x, p.y), Vector2(max_edge.x, p.y), _CROSSHAIR_X_LINE_COLOR)
			draw_line(Vector2(p.x, min_edge.y), Vector2(p.x, max_edge.y), _CROSSHAIR_Y_LINE_COLOR)
			draw_set_transform_matrix(Transform2D())
			p = _transform * p
			draw_circle(p, 3.0, _theme_mono_color.inverted(), true)
			draw_circle(p, 3.0, _theme_mono_color, false, 2.0)
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
					if not _draw_final_position:
						continue
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
		NOTIFICATION_RESIZED:
			_resized()

func _on_preset_changed() -> void:
	_play = false
	set_process(false)
	reset()
	queue_redraw()
