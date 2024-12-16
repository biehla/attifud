## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name MathUtils


## integer power (edge cases in order: 0^x = 0, 1^x = 1, x^0 = 1)
static func pow_int(base: int, exponent: int) -> int:
	if base == 0 or exponent < 0:
		return 0
	if base == 1 or exponent == 0:
		return 1

	var result: int = 1
	for i: int in range(exponent):
		result *= base
	return result
