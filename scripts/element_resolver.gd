class_name ElementResolver

var elements_definition = {
	"null": Element.new("null"),
	"fire": Element.new("fire"), 
	"water": Element.new("water"), 
	"air": Element.new("air"), 
	"earth": Element.new("earth"),
	"ice": Element.new("ice", [["water", "air"]]), 
	"mud": Element.new("mud", [["water", "earth"]]), 
	"lightning": Element.new("lightning", [["fire", "air"]]), 
	"lava": Element.new("lava", [["fire", "earth"]])
}

var combomap = generate_combomap(elements_definition)

func generate_combomap(definition):
	var combomap = {}
	
	for element in definition.keys():
		for pair in definition[element].created_by:
			append_key(pair[0], pair[1], element, combomap)
			append_key(pair[1], pair[0], element, combomap)
			
	return combomap

func append_key(key, innerkey, value, dict):
	var newkey
	if dict.has(key):
		newkey = dict[key]
	else:
		newkey = {}
		
	newkey[innerkey] = value
	dict[key] = newkey
		
		
# TODO FIX THIS
func resolve_elements(element_quantities: Dictionary):
	var names = element_quantities.keys()
	for name in names:
		var possible_combinations = combomap[name]
		for combo in possible_combinations.keys():
			if combo in names:
				var new_element = possible_combinations[combo]
				if element_quantities.has(new_element):
					element_quantities[new_element] += 1;
				else:
					element_quantities[new_element] = 1;
				
		
