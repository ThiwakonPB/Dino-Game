extends AudioStreamPlayer

onready var audio = get_node(".")

var sound_list = {
	"jump":"res://Media/Sound/jump-small.ogg",
	"dead":"res://Media/Sound/life-lost.ogg",
}

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS # work in pause mode
	pass # Replace with function body.

func _process(delta):
	pass






func _on_Dino_dino_jump():
	_play_Sound(sound_list["jump"])
	pass

func _on_Dino_dino_dead():
	_play_Sound(sound_list["dead"])
	pass # Replace with function body.

func _play_Sound(path_to_file):
	audio.stream = load(path_to_file)
	audio.play()