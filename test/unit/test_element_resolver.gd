extends GutTest

func test_generate_combo_map():
	load("res://scripts/element.gd");
	var resolver = ElementResolver.new();
	var result = resolver.generate_combomap(resolver.elements_definition)
	gut.p(result)
	assert_eq("ice", result["water"]["air"])
	assert_eq("ice", result["air"]["water"])
	assert_eq("mud", result["water"]["earth"])
	assert_eq("mud", result["earth"]["water"])
	assert_eq("lightning", result["fire"]["air"])
	assert_eq("lightning", result["air"]["fire"])
	assert_eq("lava", result["fire"]["earth"])
	assert_eq("lava", result["earth"]["fire"])
