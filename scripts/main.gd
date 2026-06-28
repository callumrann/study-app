extends Control

@onready var label: Label = $"ClockLabel"
@onready var timer: Timer = $"ClockTimer"
@onready var input_box: SpinBox = $"ClockInput" # not used currently (dont through signals)

const save_path: String = "user://study_data.cfg"

var time_left: int = 60
var clock_paused: bool = true

func _ready() -> void:
	_update_timer_text()

func _on_timer_timeout() -> void:
	if time_left > 0:
		time_left -= 1
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
	timer.start() # to reset second

func _update_timer_text() -> void:
	label.text = str(time_left)

func _save_data() -> void:
	pass
# think about making it button to enter, smth with apply() I think
# also add save data
