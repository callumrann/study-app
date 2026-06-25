extends Label

@onready var timer: Timer = $"../Timer"

var time: int = 60

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
