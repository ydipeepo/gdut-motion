class_name RangeValue extends HBoxContainer

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export var min_value := 0.0:
	get:
		return %Slider.min_value
	set(value):
		%Slider.min_value = value

@export var max_value := 100.0:
	get:
		return %Slider.max_value
	set(value):
		%Slider.max_value = value

@export var value := 0.0:
	get:
		return %Slider.value
	set(value):
		%Slider.value = value

@export_range(0, 2, 1) var exponent := 0

#-------------------------------------------------------------------------------

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	#
	# TODO:
	# Separate this process into the changed, value_changed signal.
	#
	match exponent:
		0:
			%Slider.step = 1.0
			%Value.text = str(floori(%Slider.value))
			%MinValue.text = str(floori(%Slider.min_value))
			%MaxValue.text = str(floori(%Slider.max_value))
		1:
			%Slider.step = 0.1
			%Value.text = "%d.%d" % [floori(%Slider.value), roundi(%Slider.value * 10) % 10]
			%MinValue.text = "%d.%d" % [floori(%Slider.min_value), roundi(%Slider.min_value * 10) % 10]
			%MaxValue.text = "%d.%d" % [floori(%Slider.max_value), roundi(%Slider.max_value * 10) % 10]
		2:
			%Slider.step = 0.01
			%Value.text = "%d.%02d" % [floori(%Slider.value), roundi(%Slider.value * 100) % 100]
			%MinValue.text = "%d.%02d" % [floori(%Slider.min_value), roundi(%Slider.min_value * 100) % 100]
			%MaxValue.text = "%d.%02d" % [floori(%Slider.max_value), roundi(%Slider.max_value * 100) % 100]
