## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name GameSaveData
extends SaveData

var coins: int


func clear(_index: int = -1) -> void:
	coins = 0
