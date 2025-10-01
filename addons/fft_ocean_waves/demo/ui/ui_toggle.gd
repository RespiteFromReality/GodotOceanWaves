extends Button

@onready var background: Panel = $"../Background"
@onready var ocean_waves: MarginContainer = $"../OceanWaves"
@onready var cascade_tab_container: TabContainer = %CascadeTabContainer

func _on_toggled(toggled_on: bool) -> void:
	background.visible = toggled_on
	ocean_waves.visible = toggled_on
	cascade_tab_container.visible = toggled_on
