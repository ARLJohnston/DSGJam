extends Node

class_name ElementResolver

signal element_merged(first,second,result)
signal element_added(element)

var elements_definition = {
	"null": Element.new("null", [["fire", "water"], ["air", "earth"]], "#FFFFFF"),
	"fire": Element.new("fire", [["lightning", "earth"]], "#ff0000"), 
	"water": Element.new("water", [["ice", "fire"]], "#00ffff"), 
	"air": Element.new("air", [["steam", "ice"]], "#cccccc"), 
	"earth": Element.new("earth", [["ice", "mud"]], "#00ff00"),
	"ice": Element.new("ice", [["water", "air"]], "#00ccff"), 
	"mud": Element.new("mud", [["water", "earth"]], "#a05a2c"), 
	"lightning": Element.new("lightning", [["fire", "air"]], "#a05a2c"), 
	"lava": Element.new("lava", [["fire", "earth"]], "#800000"),
	"steam": Element.new("steam", [["lava", "ice"]], "#4d4d4d"),
	"clay": Element.new("clay", [["fire", "mud"]], "#803300"),
	"poison": Element.new("poison", [["mud", "steam"]], "#660080"),
	"healing": Element.new("healing", [["lightning", "poison"]], "#00d455")
}

var combomap = generate_combomap(elements_definition)
var evaluation_order = elements_definition.keys()

func generate_combomap(definition):
	var _combomap = {}

	for element in definition.keys():
		for pair in definition[element].created_by:
			append_key(pair[0], pair[1], element, _combomap)
			append_key(pair[1], pair[0], element, _combomap)

	return _combomap

func append_key(key, innerkey, value, dict):
	var newkey
	if dict.has(key):
		newkey = dict[key]
	else:
		newkey = {}

	newkey[innerkey] = value
	dict[key] = newkey

# These should be two dicts of the form {"element": quantity, ...}
# Used to "add flowers to the cauldron"
func merge_elements(to_add, element_pool, to_add_order=to_add.keys()):
	var new_pool = element_pool.duplicate()
	for new_element in to_add.keys():
		if new_element == "null":
			continue
			
		if new_pool.has(new_element):
			new_pool[new_element] += 1;
		else:
			new_pool[new_element] = 1;
			
		element_added.emit(new_element)
	print(new_pool)
	var order = to_add_order.duplicate()
	new_pool = resolve_elements(new_pool, order)
	return resolve_elements(new_pool)

func resolve_elements(element_quantities: Dictionary, evaluation_keys=evaluation_order):
	var intermediate_copy = element_quantities.duplicate()
	var combination_found = true
	while combination_found:
		combination_found = do_resolve_elements(intermediate_copy, evaluation_keys)
	return intermediate_copy

func do_resolve_elements(intermediate_copy, evaluation_keys):
	for name in evaluation_keys:
		if !intermediate_copy.has(name):
			continue

		if(resolve_element(name, intermediate_copy, evaluation_keys)):
			return true
	return false

func resolve_element(name, intermediate_copy, evaluation_keys=evaluation_order):
	if !combomap.has(name):
		return false

	var possible_combinations = combomap[name]
	for combo in evaluation_keys:
		if possible_combinations.has(combo) and intermediate_copy.has(combo):
			var new_element = possible_combinations[combo]

			deduct_element(name, intermediate_copy)
			deduct_element(combo, intermediate_copy)
			element_merged.emit(name, combo, new_element)

			if new_element == "null":
				return true

			if intermediate_copy.has(new_element):
				intermediate_copy[new_element] += 1;
			else:
				intermediate_copy[new_element] = 1;

			return true
	return false

func deduct_element(name, intermediate_copy):
	intermediate_copy[name] -= 1
	if intermediate_copy[name] <= 0:
		intermediate_copy.erase(name)
