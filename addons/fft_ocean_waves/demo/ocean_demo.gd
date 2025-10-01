extends Node3D

@onready var viewport : Viewport = get_viewport()
@onready var camera : Camera3D = viewport.get_camera_3d()
@onready var water: MeshInstance3D = $Water
@onready var ocean_audio_player: AudioStreamPlayer = $OceanAudioPlayer
@onready var wind_audio_player: AudioStreamPlayer = $WindAudioPlayer

var clipmap_tile_size := 1.0 # Not the smallest tile size, but one that reduces the amount of vertex jitter.
var previous_tile := Vector3i.MAX


func _init() -> void:
	if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	var monitor_size : Vector2 = DisplayServer.screen_get_size(DisplayServer.SCREEN_OF_MAIN_WINDOW)
	var monitor_origin : Vector2 = DisplayServer.screen_get_position(DisplayServer.SCREEN_OF_MAIN_WINDOW)
	var window_size : Vector2 = monitor_size * 0.75
	var centered_offset : Vector2 = (monitor_size - window_size) / 2
	var window_position : Vector2 = monitor_origin + centered_offset
	DisplayServer.window_set_position(window_position)
	DisplayServer.window_set_size(window_size)

func _physics_process(delta: float) -> void:
	if (camera == null || camera.global_position == null): 
		printerr("Camera is missing or reference is broken.")
		return
	if (water == null || water.parameters == null):
		printerr("Water mesh or WaveCascadeParameters are missing or reference is broken.")
		return

	# Shift water mesh whenever player moves into a new tile.
	var tile := (Vector3(camera.global_position.x, 0.0, camera.global_position.z) / clipmap_tile_size).ceil()
	if not tile.is_equal_approx(previous_tile):
		water.global_position = tile * clipmap_tile_size
		previous_tile = tile

	# Vary audio samples based on total wind speed across all cascades.
	var total_wind_speed := 0.0
	for params in water.parameters:
		total_wind_speed += params.wind_speed
	ocean_audio_player.volume_db = lerpf(-30.0, 15.0, minf(total_wind_speed/15.0, 1.0))
	wind_audio_player.volume_db = lerpf(5.0, -30.0, minf(total_wind_speed/15.0, 1.0))
