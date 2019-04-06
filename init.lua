local bamboo_forest = {}
local ground_node = "bamboo_forest:dirt_with_bamboo_leaf_litter" 

minetest.register_node("bamboo_forest:dirt_with_bamboo_leaf_litter", {
    description = "Dirt with Bamboo Leaf Litter",
    tiles = {
        "bamboo_forest_leaf_litter.png", "default_dirt.png",
        "default_dirt.png^bamboo_forest_leaf_litter_side.png", "default_dirt.png^bamboo_forest_leaf_litter_side.png", 
        "default_dirt.png^bamboo_forest_leaf_litter_side.png",  "default_dirt.png^bamboo_forest_leaf_litter_side.png", 
    },
    is_ground_content = true,
    groups = {crumbly=3, soil=1, spreading_dirt_type=1, grass=1},
    sounds = default.node_sound_leaves_defaults(),
    drop = {
        items = {
            {items={"default:dirt"}}
        }
    }
})

minetest.register_node("bamboo_forest:veiled_lady", {
    description = "Veiled Lady Mushroom",
    drawtype = "plantlike",
    tiles = {"bamboo_forest_veiled_lady.png"},
    inventory_image = "bamboo_forest_veiled_lady.png",
    paramtype = "light",
    sunlight_propagates = "true",
    walkable = false,
    buildable_to = "true",
    groups = {snappy=3, attached_node=1, oddly_breakable_by_hand=3, flammable = 1, food_mushroom=1, dig_immediate=1},
    on_use = minetest.item_eat(1),
    selection_box = {
        type = "fixed",
        fixed = {-1/4, -1/2, -1/4, 1/4, 1/4, 1/4}
    }
})

minetest.register_entity("bamboo_forest:sprigs", {
	physical = false,
	visual = "upright_sprite",
	textures = {"bamboo_forest_shoot.png"},
	pointable = false,
    collisionbox = {0,0,0,0,0,0},
})

minetest.register_node("bamboo_forest:sprout", {
	description = "Bamboo Sprout",
	drawtype = "plantlike",
    waving = 1,
	tiles = {"bamboo_forest_sprout.png"},
    inventory_image = "bamboo_forest_sprout.png",
	walkable = false,
	climable = false,
    paramtype = "light",
    sunlight_propagates = true,
    selection_box = {
        type = "fixed",
        fixed = {-1/8, -1/2, -1/8, 1/8, 0, 1/8},
    },
    groups = {snappy=2, attached_node=1, oddly_breakable_by_hand=2,},
    sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("bamboo_forest:shoot", {
	description = "Bamboo Shoot",
	drawtype = "nodebox",
	tiles = {
		"bamboo_forest_shoot.png","bamboo_forest_shoot.png",
		"bamboo_forest_shoot.png", "bamboo_forest_shoot.png",
		"bamboo_forest_shoot.png", "bamboo_forest_shoot.png",
	},
	walkable = true,
	climbable = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, snappy=2, oddly_breakable_by_hand = 1, flammable = 2, stick = 1},
    sounds = default.node_sound_wood_defaults(),
    on_place = minetest.rotate_node,
    on_construct = function(pos)
        local pos_above = {x=pos.x, y=pos.y+1, z=pos.z}
        if minetest.get_node(pos_above).name == "bamboo_forest:sprout" then
            local rot = 3/5
            if math.random() < 0.5 then
                rot= 12/5
            end
            local leaf = minetest.add_entity(pos, "bamboo_forest:sprigs")
            leaf:set_yaw(rot)
        end
    end,
    on_destruct = function(pos)
        local obj = minetest.get_objects_inside_radius(pos, 0.5)
        for _, ob in pairs(obj) do
           ob:remove()
        end
    end,
	node_box = {
		type = "fixed",
		fixed = {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
	},
})

minetest.register_node("bamboo_forest:leaves", {
	description = "Bamboo Leaves",
	drawtype = "allfaces",
	tiles = {"bamboo_forest_leaves.png"},
	walkable = true,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay = 3, flammable = 2, leaves = 1},
    sounds = default.node_sound_leaves_defaults(),
    after_place_node = default.after_place_leaves,
    drop = {
        max_items = 1,
        items = {
            {items = {"bamboo_forest:sprout"}, rarity = 20},
            {items = {"bamboo_forest:leaves"}},
        },
    },
})

minetest.register_node("bamboo_forest:trunk", {
	description = "Bamboo Trunk",
	drawtype = "nodebox",
	tiles = {
		"bamboo_forest_trunk_top.png","bamboo_forest_trunk_top.png",
		"bamboo_forest_trunk.png", "bamboo_forest_trunk.png",
		"bamboo_forest_trunk.png", "bamboo_forest_trunk.png",
	},
	walkable = true,
	climbable = true,
	paramtype = "light",
	sunlight_propgates = true,
	paramtype2 = "facedir",
	groups = {choppy=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
	},
    on_place = minetest.rotate_node,
})
---------------------
--Craftable nodes
---------------------

        
minetest.register_node("bamboo_forest:planks", {
    description = "Bamboo Planks",
    tiles = {
        "bamboo_forest_planks_top.png", "bamboo_forest_planks_top.png",
        "bamboo_forest_planks.png", "bamboo_forest_planks.png",
        "bamboo_forest_planks.png", "bamboo_forest_planks.png",
    },
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {choppy=2, cracky=3},
    on_place = minetest.rotate_node,
    sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bamboo_forest:dried_planks", {
    description = "Dried Bamboo Planks",
    tiles = {
        "bamboo_forest_dried_planks_top.png", "bamboo_forest_dried_planks_top.png",
        "bamboo_forest_dried_planks.png", "bamboo_forest_dried_planks.png",
        "bamboo_forest_dried_planks.png", "bamboo_forest_dried_planks.png",
    },
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {choppy=2, cracky=3},
    on_place = minetest.rotate_node,
    sounds = default.node_sound_wood_defaults(),
})


function bamboo_forest.register_bamboo_brick(dried_, desc)
    
    minetest.register_node("bamboo_forest:"..dried_.."brick", {
        description = desc,
        tiles = {"bamboo_forest_"..dried_.."brick.png"},
        paramtype2 = "facedir",
        is_ground_content = false,
        groups = {choppy = 1},
        sounds = default.node_sound_wood_defaults(),
    })

    minetest.register_craft({
        output = "bamboo_forest:"..dried_.."brick 4",
        recipe = {
            {"bamboo_forest:"..dried_.."planks", "bamboo_forest:"..dried_.."planks"},
            {"bamboo_forest:"..dried_.."planks","bamboo_forest:"..dried_.."planks"},
        }
    })
    
end

bamboo_forest.register_bamboo_brick("", "Bamboo Brick")
bamboo_forest.register_bamboo_brick("dried_", "Dried Bamboo Brick")



bamboo_forest.grow = function(pos, node)
    local pos_above = {x=pos.x, y=pos.y, z=pos.z}
    if minetest.get_node_light(pos_above) > 12 then
        for h = 1, 5 do
            local check_pos = {x=pos.x, y=pos.y-h, z=pos.z}
            local node_under = minetest.get_node(check_pos).name
            if minetest.get_item_group(node_under, "soil") > 0 then
                if h < 5 then
                    minetest.set_node({x=pos.x, y=pos.y + 1, z=pos.z}, {name=node.name})
                    local obj = minetest.get_objects_inside_radius(pos, 1)
                    for _, ob in pairs(obj) do
                        ob:remove()
                    end
                    minetest.set_node(pos, {name="bamboo_forest:shoot"})
                    return
                elseif h == 5 then
                     local obj = minetest.get_objects_inside_radius(pos, 1)
                    for _, ob in pairs(obj) do
                        ob:remove()
                    end
                    minetest.remove_node(pos)
                    for n = 1, 4 do
                        local remove_pos = {x=pos.x, y=pos.y-n, z=pos.z}
                        minetest.remove_node(remove_pos)
                        if n == 4 then
                            local place_pos = {x=remove_pos.x-1, y=remove_pos.y, z=remove_pos.z-1}
                            minetest.place_schematic(place_pos, minetest.get_modpath("bamboo_forest").."/schems/bamboo.mts", "0", {}, false)
                        end
                    end
                end
            end
        end
    end
end

----------------
-- Forest Stuff
----------------
minetest.register_abm({
    label = "bamboo_forest:grow",
    nodenames = "bamboo_forest:sprout",
    neighbors = {"group:soil", "bamboo_forest:shoot"},
    interval = 31,
    chance = 37,
    catch_up = true,
    action = function(pos, node)
        bamboo_forest.grow(pos, node)
    end
})

minetest.register_abm({
    label = "bamboo_forest:spread",
    nodenames = "bamboo_forest:trunk",
    interval = 79,
    chance = 960,
    catchup = false,
    action = function(pos, node)
        local num = minetest.find_nodes_in_area(
            {x=pos.x-2, y=pos.y, z=pos.z-2},
            {x=pos.x+2, y=pos.y, z=pos.z+2},
            {"bamboo_forest:trunk"}
        )
        
        if #num > 3 then
            return
        end
        
        local empty_pos = minetest.find_nodes_in_area_under_air(
            {x=pos.x-2, y=pos.y-1, z=pos.z-2},
            {x=pos.x+2, y=pos.y+1, z=pos.z+2},
            {"bamboo_forest:dirt_with_bamboo_leaf_litter"}
        )
        
        if #empty_pos > 1 then
            local pos_to_spread = empty_pos[math.random(1, #empty_pos)]
            pos_to_spread.y = pos_to_spread.y + 1
            minetest.set_node(pos_to_spread, {name="bamboo_forest:sprout"})
        end
    end
})

minetest.register_abm({
	label = "bamboo_forest:mushroom_spread",
	nodenames = "bamboo_forest:veiled_lady",
	interval = 53,
	chance = 128,
	catch_up = false,
	action = function(pos, node)
		local empty_places = minetest.find_nodes_in_area_under_air(
			{x=pos.x-2, y=pos.y-2, z=pos.z-2},
			{x=pos.x+2, y=pos.y, z=pos.z+2},
			{"bamboo_forest:dirt_with_bamboo_leaf_litter"}
		)
		if #empty_places > 0 then
			local below_shroom_pos = empty_places[math.random(1, #empty_places)]
			local shroom_pos = below_shroom_pos
			shroom_pos.y = shroom_pos.y + 1
			local light_level = minetest.get_node_light(shroom_pos)

			if light_level <=12 then
				minetest.set_node(shroom_pos, {name="bamboo_forest:veiled_lady"})
			end
		end
	end
})

minetest.register_abm({
	label = "bamboo_forest:mushroom_death",
	nodenames = "bamboo_forest:veiled_lady",
	interval = 73,
	chance = 27,
	catch_up = false,
	action = function(pos, node)
		local light_level = minetest.get_node_light(pos)
		if light_level > 12 then
			minetest.remove_node(pos)
		end
	end
})

minetest.register_biome({
    name = "bamboo_forest",
    node_dust = "",
    node_top = ground_node,
    depth_top = 1,
    node_filler = "default:dirt",
    depth_filler = 2,
    node_stone = "default:stone",
    node_riverbed = "default:sand",
    depth_riverbed = 2,
    y_min = 2,
    y_max =31000,
    heat_point = 40,
    humidity_point = 50,
})

minetest.register_biome({
    name = "snowy_bamboo_forest",
    node_dust = "default:snow",
    node_top = ground_node,
    depth_top = 1,
    node_filler = "default:dirt",
    depth_filler = 2,
    node_riverbed = "default:sand",
    depth_riverbed = 2,
    y_min = 20,
    y_max = 31000,
    heat_point = 30,
    humidity_point = 60,
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = ground_node,
    sidelen = 16,
    fill_ratio = 0.1,
    biomes = {"bamboo_forest", "snowy_bamboo_forest"},
    schematic = "schems/bamboo.mts",
    flags = {
        place_center_x = true, 
        place_center_y=false, 
        place_center_z=true
    },
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = ground_node,
    sidelen = 16,
    fill_ratio = 0.04,
    biomes = {"bamboo_forest"},
    decoration = "default:grass_3",
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = ground_node,
    sidelen = 16,
    fill_ratio = 0.03,
    biomes = {"snowy_bamboo_forest"},
    decoration = "default:dry_shrub",
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = ground_node,
    sidelen = 16,
    fill_ration = 0.0095,
    biomes = {"bamboo_forest", "snowy_bamboo_forest"},
    decoration = "bamboo_forest:veiled_lady",
})

default.register_leafdecay({
    trunks = {"bamboo_forest:trunk"},
    leaves = {"bamboo_forest:leaves"},
    radius = 1.5,
})
--------------------------------
-- Items and other mod support
--------------------------------
default.register_fence("bamboo_forest:fence", {
    description = "Bamboo Fence,",
    texture = "bamboo_forest_fence.png",
    inventory_image = "default_fence_overlay.png^bamboo_forest_planks.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^bamboo_forest_planks.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "bamboo_forest:planks",
    groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
    sounds = default.node_sound_wood_defaults(),
})


default.register_fence("bamboo_forest:dried_fence", {
    description = "Dried Bamboo Fence",
    texture = "bamboo_forest_dried_fence.png",
     inventory_image = "default_fence_overlay.png^bamboo_forest_dried_planks.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^bamboo_forest_dried_planks.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "bamboo_forest:dried_planks",
    groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
    sounds = default.node_sound_wood_defaults(),
})

   local textures= {"bamboo_forest_planks_top.png", "bamboo_forest_planks_top.png", "bamboo_forest_planks.png", "bamboo_forest_planks.png", "bamboo_forest_planks.png", "bamboo_forest_planks.png"}

if minetest.get_modpath("walls") then
    walls.register("bamboo_forest:wall", "Bamboo Wall", textures, "bamboo_forest:planks", default.node_sound_wood_defaults())
    walls.register("bamboo_forest:dried_wall", "Dried Bamboo Wall", {"bamboo_forest_dried_planks_top.png", "bamboo_forest_dried_planks_top.png", "bamboo_forest_dried_planks.png", "bamboo_forest_dried_planks.png", "bamboo_forest_dried_planks.png", "bamboo_forest_dried_planks.png",}, "bamboo_forest:dried_planks", default.node_sound_wood_defaults())
end

if minetest.get_modpath("doors") then
    doors.register_fencegate("bamboo_forest:gate", {
        description = "Bamboo Gate",
        texture = "bamboo_forest_planks.png^[transform1",
        material = "bamboo_forest:planks",
        groups = {choppy=3, oddly_breakable_by_hand=2, flammable=3},
    })
    
    doors.register_fencegate("bamboo_forest:dried_gate", {
        description = "dried Bamboo Gate",
        texture = "bamboo_forest_dried_planks.png^[transform1",
        material = "bamboo_forest:dried_planks",
        groups = {choppy=3, oddly_breakable_by_hand=2, flammable=3},
    })
    
    doors.register("door_dried_bamboo", {
        tiles = {{ name = "bamboo_forest_dried_door.png", backface_culling = true }},
        description = "Dried Bamboo Door",
        inventory_image = "bamboo_forest_dried_door_item.png",
        groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2,},
        recipe = {
            {"bamboo_forest:dried_planks", "bamboo_forest:dried_planks"},
            {"bamboo_forest:dried_planks", "bamboo_forest:dried_planks"},
            {"bamboo_forest:dried_planks", "bamboo_forest:dried_planks"},
        },
    })
    
    doors.register("door_bamboo", {
        tiles = {{ name = "bamboo_forest_door.png", backface_culling = true }},
        description = "Bamboo Door",
        inventory_image = "bamboo_forest_door_item.png",
        groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2,},
        recipe = {
            {"bamboo_forest:planks", "bamboo_forest:planks"},
            {"bamboo_forest:planks", "bamboo_forest:planks"},
            {"bamboo_forest:planks", "bamboo_forest:planks"},
        },
    })
end


local stairnodes = {
		{"planks",
			{
				"bamboo_forest_planks_top.png", "bamboo_forest_planks_top.png",
				"bamboo_forest_planks.png", "bamboo_forest_planks.png",
				"bamboo_forest_planks.png", "bamboo_forest_planks.png",
			},
		"Planks",
		}, 
		{"dried_planks",
			{
				"bamboo_forest_dried_planks_top.png", "bamboo_forest_dried_planks_top.png",
				"bamboo_forest_dried_planks.png", "bamboo_forest_dried_planks.png",
				"bamboo_forest_dried_planks.png", "bamboo_forest_dried_planks.png",
			},
			"Dried Planks"
		
		}, 
		{"brick", {"bamboo_forest_brick.png"}, "Brick"}, 
		{"dried_brick", {"bamboo_forest_dried_brick.png"}, "Dried Brick"}
	}

if stairs or stairsplus then
    for i = 1, #stairnodes do
        local nodename = stairnodes[i][1]
        local textures = stairnodes[i][2]
        local desc = stairnodes[i][3]
        if stairsplus then
                
            stairsplus:register_all("bamboo_forest", nodename, "bamboo_forest:"..nodename, {
                    description = "Bamboo " .. desc,
                    tiles = textures,
                    groups = {choppy=3, flammable=2},
                    sounds = default.node_sound_wood_defaults(),
            })
            minetest.log(nodename .. " registered with Stairsplus") 
        
        elseif minetest.get_modpath("stairs") then    
                stairs.register_stair_and_slab(
                    nodename,
                    "bamboo_forest:"..nodename,
                    {choppy=3, flammable = 2},
                    textures,
                    desc .. " Stair",
                    desc .. " Slab",
                    default.node_sound_wood_defaults()
                )
        end
    end
end
-----------
-- Crafts
-----------
        
minetest.register_craft({
    output = "bamboo_forest:dirt_with_bamboo_leaf_litter",
    recipe = {
        {"bamboo_forest:leaves"},
        {"default:dirt"},
    }
})

minetest.register_craft({
    output = "bamboo_forest:planks",
    recipe = {
        {"bamboo_forest:trunk", "bamboo_forest:trunk"},
        {"bamboo_forest:trunk", "bamboo_forest:trunk"},
    }
})

minetest.register_craft({
    output = "bamboo_forest:planks",
    recipe = {
        {"bamboo_forest:shoot", "bamboo_forest:shoot", "bamboo_forest:shoot"},
        {"bamboo_forest:shoot", "bamboo_forest:shoot", "bamboo_forest:shoot"},
        {"bamboo_forest:shoot", "bamboo_forest:shoot", "bamboo_forest:shoot"},
    }
})

minetest.register_craft({
    type = "cooking",
    output = "bamboo_forest:dried_planks",
    recipe = "bamboo_forest:planks",
    cooktime = 2,
})

----------
-- Fuels
----------

function bamboo_forest.register_fuel_craft(item, burn_t)
    minetest.register_craft({
        type = "fuel",
        recipe = item,
        burntime = burn_t,
    })
end

local fuel_items = {
    {"bamboo_forest:sprout", 4},
    {"bamboo_forest:shoot", 2},
    {"bamboo_forest:truck", 5},
    {"bamboo_forest:planks", 20},
    {"bamboo_forest:brick", 25},
    {"bamboo_forest:dried_planks", 25},
    {"bamboo_forest:dried_brick", 30},
    {"bamboo_forest:fence", 8},
    {"bamboo_forest:dried_fence", 12},
    {"bamboo_forest:wall", 12},
    {"bamboo_forest:dried_wall", 16},
    {"doors:door_bamboo", 40},
    {"doors:door_dried_bamboo", 40},
}

for _, item in ipairs(fuel_items) do
    bamboo_forest.register_fuel_craft(item[1], item[2])
end
