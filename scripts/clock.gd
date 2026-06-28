extends Control

@onready var label: Label = $"ClockLabel"
@onready var timer: Timer = $"ClockTimer"
@onready var input_box: SpinBox = $"ClockInput" # not used currently (dont through signals)

const SAVE_PATH: String = "user://study_data.cfg"
var total_study_time: int

var time_left: int = 60
var clock_paused: bool = true

# debug
@onready var saved_label: Label = $"SavedTimeLabel"

func _ready() -> void:
	_load_study_time()
	_update_timer_text()

func _on_timer_timeout() -> void:
	if time_left > 0:
		time_left -= 1
		total_study_time += 1
		_update_timer_text()
	else:
		print("timer finished")
		timer.stop()

func _on_pause_button_up() -> void:
	clock_paused = !clock_paused
	if clock_paused:
		timer.stop()
	else:
		timer.start()

func _on_timer_input_value_changed(value: float) -> void:
	time_left = value
	_update_timer_text()
	if !timer.is_stopped():
		timer.start() # to reset second

func _update_timer_text() -> void:
	label.text = str(time_left)

func _save_study_time() -> void:
	var config: ConfigFile = ConfigFile.new()
	print("check")
	config.set_value("Stats", "total_study_time_seconds", total_study_time)
	config.save(SAVE_PATH)

func _load_study_time():
	var config: ConfigFile = ConfigFile.new()
	
	var error = config.load(SAVE_PATH)
	if error != OK:
		print("Error fetching file. Setting default values.")
		total_study_time = 0
		return
	
	total_study_time = config.get_value("Stats", "total_study_time_seconds")
	saved_label.text = "Saved Time: " + str(total_study_time)
	
func _notification(what: int) -> void:
	
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save_study_time()
		get_tree().quit()

# think about making it button to enter, smth with apply() ?
# add debug mode?
