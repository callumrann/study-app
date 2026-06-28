extends Control

@onready var timer_label: Label = $"TimerText"
@onready var timer: Timer = $"Timer"
@onready var timer_input: SpinBox = $"TimerInput"

const save_path: String = "user://study_data.cfg"

var time: int = 60
var time_paused: bool = true

func _ready() -> void:
	_update_timer_text()

func _on_timer_timeout() -> void:
	if time > 0:
		time -= 1
		_update_timer_text()
	else:
		print("timer finished")
		timer.stop()

func _update_timer_text() -> void:
	timer_label.text = str(time)

func _on_button_button_up() -> void:
	time_paused = !time_paused
	if time_paused:
		timer.stop()
	else:
		timer.start()

func _on_timer_input_value_changed(value: float) -> void:
	time = value
	_update_timer_text()
	timer.start() # to reset second


# think about making it button to enter, smth with apply() I think
# also add save data
# potentially move this script to a new timer scene
