@tool
extends Container
class_name myTabContainer

@export var current:int  = 0: # 当前显示的子节点索引
	set(val):
		current = clamp(val,0,get_child_count()-1)
		queue_sort()


func _notification(what):
	match what:
		NOTIFICATION_SORT_CHILDREN:
			for child in get_children():
				if child.get_index() == current:
					fit_child_in_rect(child,get_rect())
					child.show()
				else:
					child.hide()
