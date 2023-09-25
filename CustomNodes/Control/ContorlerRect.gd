# ========================================================
## 矩形控制点，用于返回位置信息
##
## 名称：ControlerRect
## [br]类型：自定义控件
## [br]作者：巽星石
## [br]Godot版本：4.1-stable (official)
## [br]---------------------------------------------------
## [br]创建时间：2023-07-14 21:54:30
## [br]最后修改时间：2023-07-14 21:54:30
## 
## @tutorial(课程标题): 网址
# ========================================================
@tool
extends Control
class_name ControlerRect
# =================================== 信号 ===================================
signal pos_changed(new_pos)  # 位置发生改变时触发
# =================================== 私有成员 ===================================
var _fllowing = false
var _drag_start_pos:Vector2


func _set(property, value):
	print(property)
	if property == "position":
		print(value)

# 初始化
func _init():
	resized.connect(func():
		size = Vector2(10,10)
	)
	item_rect_changed.connect(func():
		emit_signal("pos_changed",position - Vector2(10,10)/2) # 坐标修正
	)

func _draw():
	# 绘制内部颜色
	draw_rect(get_rect() * get_transform(),Color.ORANGE_RED,true)
	# 绘制外部边框
	draw_rect(get_rect() * get_transform(),Color.WHITE,false,1)


