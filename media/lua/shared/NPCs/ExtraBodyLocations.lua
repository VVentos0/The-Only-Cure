--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

-- Locations must be declared in render-order.
-- Location IDs must match BodyLocation= and CanBeEquipped= values in items.txt.
local group = BodyLocations.getGroup("Human")


-- TODO Change these names too, jesus they suck so bad
group:getOrCreateLocation("ArmRight")
group:getOrCreateLocation("ArmLeft")
group:getOrCreateLocation("LegRight")
group:getOrCreateLocation("LegLeft")
group:getOrCreateLocation("ArmRight_Prot")
group:getOrCreateLocation("ArmLeft_Prot")