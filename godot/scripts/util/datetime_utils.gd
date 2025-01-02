## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name DatetimeUtils


## Some OS will return weird symbols in the name field, we want to avoid unexpected parsing errors.
static func get_time_zone_from_system() -> Dictionary:
	var timezone: Dictionary = Time.get_time_zone_from_system()
	timezone["bias"] = int(timezone.get("bias", 0))
	timezone["name"] = StringUtils.sanitize_text(timezone.get("name", "unknown"))
	return timezone


static func difference_seconds(start: Dictionary, end: Dictionary) -> int:
	var start_unix: int = Time.get_unix_time_from_datetime_dict(start) if start != {} else 0
	var end_unix: int = Time.get_unix_time_from_datetime_dict(end) if end != {} else 0
	return end_unix - start_unix
