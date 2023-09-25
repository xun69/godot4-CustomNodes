# ========================================================
# 名称：GroupContainer
# 类型：自定义容器
# 简介：提供一个标题的分组容器，仅能容纳一个有效的子控件
# 作者：巽星石
# Godot版本：4.1-stable (official)
# 创建时间：2023-07-07 22:42:41
# 最后修改时间：2023年7月8日00:06:44
# ========================================================
@tool
extends Container
class_name GroupContainer
# =================================== 参数 ===================================
# 分组标题
@export var title:String  = "": 
	set(val):
		title = val
		var title_lab:Label = get_child(0)
		title_lab.text = val

# 标题和内容之间的间隔
@export var gap:int = 5:
	set(val):
		gap = clamp(val,0,100)
		queue_sort()

# 背景样式
@export var panel:StyleBox: 
	set(val):
		panel = val
		if val:
			val.changed.connect(func():
				queue_redraw()
				queue_sort()
			)
		queue_redraw()
		queue_sort()

# =================================== 虚函数 ===================================
# 初始化
func _init():
	clip_contents = true
	# 创建标题
	if get_child_count() == 0:
		var title_lab = Label.new()
		title_lab.text = ""
		add_child(title_lab)
	queue_redraw()
	queue_sort()

func _enter_tree():
	queue_redraw()
	queue_sort()

# 场景面板提示信息
func _get_configuration_warnings():
	if get_child_count() > 1:
		return "只接收一个有效的子节点"

# 通知处理
func _notification(what):
	match what:
		NOTIFICATION_SORT_CHILDREN:
			var rect:Rect2 = get_rect()
			# 样式盒子的内容边距
			var padding_top = panel.content_margin_top if panel else 0
			var padding_bottom = panel.content_margin_bottom if panel else 0
			var padding_left = panel.content_margin_left if panel else 0
			var padding_right = panel.content_margin_right if panel else 0
			# 标题区矩形
			var title_rect:Rect2 = Rect2(
					Vector2(padding_left,padding_top),
					Vector2(rect.size.x-padding_right - padding_left,30)
				)
			
			if get_child_count() == 1: # 只有内置的标签
				fit_child_in_rect(get_child(0),title_rect)
			
			if get_child_count() == 2: 
				fit_child_in_rect(get_child(0),title_rect)
				# 计算出除标题外的可用区域矩形
				var can_use_pos = Vector2(padding_left,padding_top + title_rect.size.y + gap)
				var can_use_size = Vector2(rect.size.x -padding_right - padding_left,rect.size.y-title_rect.size.y - padding_top - padding_bottom - gap)
				var can_use_rect = Rect2(can_use_pos,can_use_size)
				fit_child_in_rect(get_child(1),can_use_rect)
			elif get_child_count()>2:
				update_configuration_warnings()
# 绘制处理
func _draw():
	print(get_index(),":",get_rect())
	if panel:
		draw_style_box(panel,Rect2(Vector2(),get_rect().size)) # 绘制背景的StyleBox
	


