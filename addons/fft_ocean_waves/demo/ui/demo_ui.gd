extends Control

## Controls demo user interface and applied changes to respective water parameters.

const resolution = [ 1024, 512, 256, 128 ]
const mesh_quality = [ "Low", "High" ]

@onready var camera: Camera3D = $"../Camera"
@onready var water: MeshInstance3D = $"../Water"
@onready var water_spray_emitter: GPUParticles3D = $"../Water/WaterSprayEmitter"
@onready var fps_label: Label = $OceanWaves/VBoxContainer/CameraContainer/FPS
@onready var camera_fov: HSlider = $OceanWaves/VBoxContainer/CameraContainer/CameraFOV
@onready var camera_position: Label = $OceanWaves/VBoxContainer/CameraContainer/CameraPosition
@onready var ui_toggle: CheckBox = $UIToggle

func _ready() -> void:
	camera_fov.value = camera.fov
	update_framerate()
	update_camera_position()

func _process(delta : float) -> void:
	update_framerate()
	update_camera_position()
	
func _input(event: InputEvent) -> void:
	#if event.is_action_pressed(&'toggle_imgui'):
		#should_render_imgui = not should_render_imgui
	if event.is_action_pressed(&'toggle_fullscreen'):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED else DisplayServer.WINDOW_MODE_WINDOWED)
	elif event.is_action_pressed(&'ui_cancel'):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func update_framerate() -> void:
	var fps := Engine.get_frames_per_second()
	fps_label.text = str('%.0f' % fps, " ", '(%.2fms)' % (1.0 / fps*1e3))

func update_camera_position() -> void: 
	if (camera == null):
		printerr("Camera is missing or reference is broken.")
		return
	camera_position.text = '%+.2v' % camera.global_position

func _on_sea_spray_toggle_toggled(toggled_on: bool) -> void:
	water_spray_emitter.visible = toggled_on

func _on_wave_resolution_item_selected(index: int) -> void:
	water.map_size = resolution[index]

func _on_wave_mesh_quality_item_selected(index: int) -> void:
	water.mesh_quality = mesh_quality[index]

func _on_updates_per_second_value_changed(value: float) -> void:
	water.updates_per_second = value

func _on_water_color_color_changed(color: Color) -> void:
	water.water_color = color

func _on_foam_color_color_changed(color: Color) -> void:
	water.foam_color = color

func _on_camera_fov_value_changed(value: float) -> void:
	if (camera != null): camera.fov = camera_fov.value
