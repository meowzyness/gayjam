extends Node

var amount_of_banning_lists = 1

var ban = {
	"banned_ages": [],
	"banned_citizenship": [],
	"banned_names": [],
	"banned_surnames": [],
	"banned_textures": [],
	"banned_baggage": []
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


func add_ban(p_name, key):
	for k in ban:
		if k == key:
			ban[k].append(p_name)
	update_ban_lists()


func del_ban(p_name, key):
	var _deleting_item
	for i in range(len(key)):
		if key[i] == p_name:
			_deleting_item = key[i]
	key.remove_at(_deleting_item)
	update_ban_lists()
