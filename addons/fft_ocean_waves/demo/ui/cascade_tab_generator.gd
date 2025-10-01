extends TabContainer

## Constructs a tab for each CascadeWaveParameter added to the water mesh.

const cascade_scene = preload("uid://ceicfrovdnjw2")
@onready var water: MeshInstance3D = $"../../Water"


func _ready() -> void:
	if (water == null && water.parameters == null): 
		printerr("Could not find default water mesh, please select one from the editor.")
		return
	
	# For each WaveCascadeParameter in the Array we create a tab, set it to 
	# the values set in the editor at startup.
	# Then we connect every signal with the index of that tab.
	for i in water.parameters.size():
		var instance = cascade_scene.instantiate()
		instance.name = str("Cascade ", i+1)
		var param = water.parameters[i]
		
		self.add_child(instance)
		
		# Get each UI Element
		var tile_length_x_node = instance.get_node("HBoxContainer/VBoxContainer/TileLengthX")
		var tile_length_y_node = instance.get_node("HBoxContainer/VBoxContainer/TileLengthY")
		var diplacement_scale = instance.get_node("HBoxContainer/GridContainer/DisplacementScale")
		var normal_scale = instance.get_node("HBoxContainer/GridContainer/NormalScale")
		var wind_speed = instance.get_node("HBoxContainer/GridContainer/WindSpeed")
		var wind_direction = instance.get_node("HBoxContainer/GridContainer/WindDirection")
		var fetch_length = instance.get_node("HBoxContainer/GridContainer/FetchLength")
		var swell = instance.get_node("HBoxContainer/GridContainer/Swell")
		var spread = instance.get_node("HBoxContainer/GridContainer/Spread")
		var detail = instance.get_node("HBoxContainer/GridContainer/Detail")
		var whitecap = instance.get_node("HBoxContainer/GridContainer/Whitecap")
		var foam_amount = instance.get_node("HBoxContainer/GridContainer/FoamAmount")
		
		# Set each value preset from the Editor.
		tile_length_x_node.value = param.tile_length.y
		tile_length_y_node.value = param.tile_length.x
		diplacement_scale.value = param.displacement_scale
		normal_scale.value = param.normal_scale
		wind_speed.value = param.wind_speed
		wind_direction.value = param.wind_direction
		fetch_length.value = param.fetch_length
		swell.value = param.swell
		spread.value = param.spread
		detail.value = param.detail
		whitecap.value = param.whitecap
		foam_amount.value = param.foam_amount
		
		# Hook up each signal and bind the index of the tab.
		# So we can tell which CascadeWaveParameter to edit on changes.
		tile_length_x_node.value_changed.connect(_tile_length_x_changed.bind(i))
		tile_length_y_node.value_changed.connect(_tile_length_y_changed.bind(i))
		diplacement_scale.value_changed.connect(_displacement_scale_changed.bind(i))
		normal_scale.value_changed.connect(_normal_scale_changed.bind(i))
		wind_speed.value_changed.connect(_wind_speed_changed.bind(i))
		wind_direction.value_changed.connect(_wind_direction_changed.bind(i))
		fetch_length.value_changed.connect(_fetch_length_changed.bind(i))
		swell.value_changed.connect(_swell_changed.bind(i))
		spread.value_changed.connect(_spread_changed.bind(i))
		detail.value_changed.connect(_detail_changed.bind(i))
		whitecap.value_changed.connect(_whitecap_changed.bind(i))
		foam_amount.value_changed.connect(_foam_amount_changed.bind(i))


func _tile_length_x_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.tile_length = Vector2(value, param.tile_length.y)

func _tile_length_y_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.tile_length = Vector2(param.tile_length.x, value)

func _displacement_scale_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.displacement_scale = value

func _normal_scale_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.normal_scale = value

func _wind_speed_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.wind_speed = value

func _wind_direction_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.wind_direction = value

func _fetch_length_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.fetch_length = value

func _swell_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.swell = value

func _spread_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.spread = value

func _detail_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.detail = value
	
func _whitecap_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.whitecap = value
	
func _foam_amount_changed(value: float, index: int) -> void:
	var param = water.parameters[index]
	if (param == null):
		printerr("Param is null")
		return
	param.foam_amount = value
