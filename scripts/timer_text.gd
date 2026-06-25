extends Label

@onready var timer: Timer = $"../Timer"

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
	self.text = str(time)

func _on_button_button_up() -> void:
	time_paused = !time_paused
	if time_paused:
		timer.stop()
	else:
		timer.start()
