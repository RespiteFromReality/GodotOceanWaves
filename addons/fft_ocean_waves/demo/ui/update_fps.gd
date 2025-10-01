extends HSlider

@onready var label: Label = $Label

func _ready() -> void:
	if (value == 0):
		label.text = "Unlimited"
	else:
		label.text = str('%.0f' % value)

func _on_value_changed(value: float) -> void:
	if (value == 0):
		label.text = "Unlimited"
	else:
		label.text = str('%.0f' % value)
