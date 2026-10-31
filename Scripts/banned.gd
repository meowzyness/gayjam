extends Node

var amount_of_banning_lists = 1

var ban = {
	"banned_ages": [10, 999],
	"banned_citizenship": ["ЫЫЫЫЫЫЫЫЫ"],
	"banned_names": [],
	"banned_surnames": [],
	"banned_textures": []
}


func update_ban_lists():
	var amount = 0
	for k in ban.keys():
		if len(ban[k]) > 0:
			amount += 1
	amount_of_banning_lists = amount


func get_ban_lists():
	var ban_list = []
	for k in ban.keys():
		if len(ban[k]) > 0:
			ban_list.append(k)
	return ban_list


func add_ban(p_name, massive: Array):
	massive.append(p_name)
	update_ban_lists()


func del_ban(p_name, massive: Array):
	var _deleting_item
	for i in range(len(massive)):
		if massive[i] == p_name:
			_deleting_item = massive[i]
	massive.remove_at(_deleting_item)
	update_ban_lists()
