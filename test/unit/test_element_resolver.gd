extends GutTest

var resolver

func before_each():
	resolver = ElementResolver.new();

func test_evaluation_order():
	assert_eq(resolver.evaluation_order, ["null", "fire", "water", "air", "earth", "ice", "mud", "lightning", "lava", "steam", "clay", "poison", "healing"])
	
func test_generate_combo_map():
	var result = resolver.generate_combomap(resolver.elements_definition)
	gut.p(result)
	assert_eq("null", result["water"]["fire"])
	assert_eq("null", result["fire"]["water"])
	assert_eq("ice", result["water"]["air"])
	assert_eq("ice", result["air"]["water"])
	assert_eq("mud", result["water"]["earth"])
	assert_eq("mud", result["earth"]["water"])
	assert_eq("lightning", result["fire"]["air"])
	assert_eq("lightning", result["air"]["fire"])
	assert_eq("lava", result["fire"]["earth"])
	assert_eq("lava", result["earth"]["fire"])

func test_simple_resolve_single():
	var element_quantities = {"fire": 1, "earth": 1}
	var expected = {"lava": 1}
	
	var result = resolver.resolve_element("fire", element_quantities)
	assert_eq(true, result)
	assert_eq(expected, element_quantities)

func test_nullify_single():
	var element_quantities = {"fire": 1, "water": 1}
	var expected = {}
	
	var result = resolver.resolve_element("fire", element_quantities)
	assert_eq(true, result)
	assert_eq(expected, element_quantities)
	
	
func test_multiple_potential_combos():
	var element_quantities = {"fire": 1, "air": 1, "water": 1}
	var expected = {"air": 1}
	
	var result = resolver.resolve_element("fire", element_quantities)
	assert_eq(true, result)
	assert_eq(expected, element_quantities)
	
func test_complex_resolve():
	var element_quantities = {"fire": 3, "air": 1, "water": 2, "earth": 3}
	var expected = {"lava": 1, "earth": 1}
	var result = resolver.resolve_elements(element_quantities)
	assert_eq(expected, result)
	
func test_complex_resolve_with_respect_to_elements():
	var element_quantities = {"fire": 3, "air": 1, "water": 2, "earth": 3}
	var order = ["earth", "air", "water", "fire"]
	var expected = {"mud": 2, "fire": 3}
	var result = resolver.resolve_elements(element_quantities, order)
	assert_eq(expected, result)

func test_merge_elements():
	var existing_pool = {"mud": 2, "fire": 3}
	var additional_stuff = {"air": 2}
	var expected = {"lightning": 2, "clay": 1, "mud": 1}
	var result = resolver.merge_elements(additional_stuff, existing_pool, ["air", "water"])
	assert_eq(result, expected)
