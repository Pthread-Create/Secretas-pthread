require ("util")

function make_rotated_animation_variations_from_sheet(variation_count, sheet) --makes remnants work with more than 1 variation
  local result = {}

  local function set_y_offset(variation, i)
    local frame_count = variation.frame_count or 1
    local line_length = variation.line_length or frame_count
    if (line_length < 1) then
      line_length = frame_count
    end

    local height_in_frames = math.floor((frame_count * variation.direction_count + line_length - 1) / line_length)
    -- if (height_in_frames ~= 1) then
    --   log("maybe broken sheet: h=" .. height_in_frames .. ", vc=" .. variation_count .. ", " .. variation.filename)
    -- end
    variation.y = variation.height * (i - 1) * height_in_frames
  end

  for i = 1,variation_count do
    local variation = util.table.deepcopy(sheet)

    if variation.layers then
      for _, layer in pairs(variation.layers) do
        set_y_offset(layer, i)
      end
    else
      set_y_offset(variation, i)
    end

    table.insert(result, variation)
  end
 return result
end

local remnants =
{

  {
    type = "corpse",
    name = "hyper-inserter-remnants",
    icon = "__secretas__/graphics/icons/hyper-inserter.png",
    flags = {"placeable-neutral", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "inserter-remnants",
    order = "a-h-a",
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    tile_width = 1,
    tile_height = 1,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = make_rotated_animation_variations_from_sheet (4,
    {
      filename = "__secretas__/graphics/entity/remnants/hyper-inserter-remnants.png",
      line_length = 1,
      width = 134,
      height = 94,
      direction_count = 1,
      shift = util.by_pixel(3.5, -2),
      scale = 0.5
    })
  },
}


for k, remnant in pairs (remnants) do
    if not remnant.localised_name then
      local name = remnant.name
      if name:find("%-remnants") then
        remnant.localised_name = {"remnant-name", {"entity-name."..name:gsub("%-remnants", "")}}
      end
    end
  end
  
data:extend(remnants)