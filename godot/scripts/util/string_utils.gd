## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name StringUtils


## Adds suffix and prefix as padding to given text.
static func add_padding(text: String, n: int, padding: String = " ") -> String:
	for i: int in range(n):
		text = padding + text + padding
	return text
