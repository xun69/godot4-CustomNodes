# ========================================================
# 名称：ImageDice6
# 类型：元件场景
# 简介：图片化的六面骰子，点击后可以生成1-6之间的随机数
# 作者：巽星石
# Godot版本：4.0.3-stable (official)
# 创建时间：2023-07-02 03:28:00
# 最后修改时间：2023年7月2日04:15:55
# ========================================================
@tool
extends TextureRect
class_name ImageDice6

# =================================== XXX ===================================
var can_shook = false # 摇骰子的冷却时间
var _max_num:int = 6  # 最大数字 6面骰子
# =================================== 对象引用 ===================================
# 动态创建
var timer:Timer   # 实现一次摇色子
var timer2:Timer  # 实现摇色子中间的随机显示
var audio_player:AudioStreamPlayer  # 用于播放摇色子音效


# =================================== 参数 ===================================
## 六面骰子的图片
@export var dice_image:Texture2D = preload("res://骰子.png")

## 当前显示的值
@export var value:int = 1:
	set(val):
		value = val
		var img = dice_image.get_image()
		var cell_size = Vector2.ONE * img.get_size().y
		print(cell_size)
		var rect = Rect2(Vector2((val - 1) * cell_size.x,0),cell_size)
		var region = img.get_region(rect)
		texture = ImageTexture.create_from_image(region)

## 骰子显示数字的间隔时间
@export var interval_time:float = 3.0:
	set(val):
		interval_time = val
		if !is_node_ready():
			await ready
		timer.wait_time = val

## 摇骰子音效
@export var voice:AudioStream = preload("res://摇色子.mp3"):
	set(val):
		voice = val
		if !is_node_ready():
			await ready
		audio_player.stream = val

# =================================== 节点引用 ===================================


func _ready():
	randomize()
	
	# Timer - 实现一次摇骰子
	timer = Timer.new()
	timer.wait_time = interval_time
	timer.one_shot = true
	timer.timeout.connect(func():
		timer2.stop()
		audio_player.stop()
		can_shook = false
	)
	add_child(timer,true,Node.INTERNAL_MODE_FRONT)
	# Timer2 - 摇骰子时随机显示数字
	timer2 = Timer.new()
	timer2.wait_time = 0.1
	timer2.timeout.connect(func():
		value = randi_range(1,_max_num)
	)
	add_child(timer2,true,Node.INTERNAL_MODE_FRONT)
	# 摇色子音效播放器
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = voice
	add_child(audio_player,true,Node.INTERNAL_MODE_FRONT)
	
	# 点击骰子
	gui_input.connect(func(event):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed():
					shook_dice(6)
	)

# 摇骰子
func shook_dice(max_num:int) -> void:
	_max_num = max_num
	if !can_shook:
		can_shook = true
		timer.start()
		timer2.start()
		audio_player.play()
