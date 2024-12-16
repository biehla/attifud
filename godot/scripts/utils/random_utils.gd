## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name RandomUtils


## Given a dictionary, return random string key weighted by corresponding int values.
## Example: {"gold": 10, "silver": 20, "copper": 70} has 20% chance to return "silver"
## If weight_sum is not provided, it will be calculated.
static func random_weighted_item(item_weight_dict: Dictionary, weight_sum: int = 0) -> String:
	if weight_sum <= 0:
		weight_sum = get_weights_sum(item_weight_dict)
	var roll: int = randi() % weight_sum
	for item: String in item_weight_dict:
		var weight: int = item_weight_dict[item]
		if roll < weight:
			return item
		roll -= weight
	return item_weight_dict[item_weight_dict.size() - 1]


## Use this to (re)calculate weight_sum only after dictionary is modified to optimize performance.
static func get_weights_sum(item_weight_dict: Dictionary) -> int:
	return item_weight_dict.values().reduce(func(x: int, n: int) -> int: return x + n, 0)


## Generate random string of given length and charset. (Default charset is ASCII.)
func random_string(length: int, charset: String = CharsetConsts.ASCII) -> String:
	var result: String = ""
	for i: int in range(length):
		result += charset[randi() % charset.length()]
	return result
