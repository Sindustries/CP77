------------------------------------------------
--USER CONFIGURABLE VARIABLES
--The conversion rates and exp earned are based off of vanilla rates with only having the tune up perk

--How many to convert and how many of the next tier to return
compToConvert = 90
compToReturn = 10

--How many of each component tier to always have on hand (Components get upgraded after going higher than these values plus compToConvert)
commonLimit = 500
uncommonLimit = 400
rareLimit = 300
epicLimit = 200

--Upgrade Components
doUpgradeComp = false -- EXPERIMENTAL: The scipt will also upgrade Upgrade Components using the same conversion rate
rareUpLimit = 500
epicUpLimit = 500

--How much crafting experience to gain when auto upgrading to next tier
useVanillaExp = true --If true, custom exp rates will be ignored
--Vanilla values per 1 upgraded component: Uncommon - 18 exp : Rare - 36 exp : Epic - 54 exp : Legendary - 90 exp

--Custom experience rates per stack (ignored if useVanillaExp = true)
--These are defaulted to vanilla settings
uncommonExp = 180
rareExp = 360
epicExp = 540
legendaryExp = 900

--Show messages in console
useDebugPrint = false

------------------------------------------------

registerForEvent("onInit", function()

print("Auto Component Upgrade activated")

end)

updateTime = os.time() + 10

registerForEvent("onUpdate", function()

	if (updateTime < os.time()) then
	updateTime = os.time() + 60

	player = Game.GetPlayer()

------------------------------------------------
--COMMON UPGRADE

			ts = Game.GetTransactionSystem()
			itemid = GetSingleton("gameItemID"):FromTDBID(TweakDBID.new("Items.CommonMaterial1"))
			currentCount = ts:GetItemQuantity(player, itemid)

			if (currentCount >= commonLimit + compToConvert) then
				ts:RemoveItem(player, itemid, compToConvert)
				Game.AddToInventory("Items.UncommonMaterial1", compToReturn)

				if useVanillaExp then
					Game.AddExp("Crafting", 18*compToReturn)
				else
					Game.AddExp("Crafting", uncommonExp)
				end

				if useDebugPrint then
					print("Common Components removed: ", compToConvert)
					print("Uncommon Components added: ", compToReturn)
				end
			else
				if useDebugPrint then
					print("Not enough Common Components. Current count: ", currentCount)
				end
	    end

------------------------------------------------
--UNCOMMON UPGRADE

			ts = Game.GetTransactionSystem()
			itemid = GetSingleton("gameItemID"):FromTDBID(TweakDBID.new("Items.UncommonMaterial1"))
			currentCount = ts:GetItemQuantity(player, itemid)

			if (currentCount >= uncommonLimit + compToConvert) then
				ts:RemoveItem(player, itemid, compToConvert)
				Game.AddToInventory("Items.RareMaterial1", compToReturn)

				if useVanillaExp then
					Game.AddExp("Crafting", 36*compToReturn)
				else
					Game.AddExp("Crafting", rareExp)
				end

				if useDebugPrint then
					print("Uncommon Components removed: ", compToConvert)
					print("Rare Components added: ", compToReturn)
				end
			else
				if useDebugPrint then
					print("Not enough Uncommon Components. Current count: ", currentCount)
				end
	    end

------------------------------------------------
--RARE UPGRADE

			ts = Game.GetTransactionSystem()
			itemid = GetSingleton("gameItemID"):FromTDBID(TweakDBID.new("Items.RareMaterial1"))
			currentCount = ts:GetItemQuantity(player, itemid)

			if (currentCount >= rareLimit + compToConvert) then
				ts:RemoveItem(player, itemid, compToConvert)
				Game.AddToInventory("Items.EpicMaterial1", compToReturn)

				if useVanillaExp then
					Game.AddExp("Crafting", 54*compToReturn)
				else
					Game.AddExp("Crafting", epicExp)
				end

				if useDebugPrint then
					print("Rare Components removed: ", compToConvert)
					print("Epic Components added: ", compToReturn)
				end
			else
				if useDebugPrint then
					print("Not enough Rare Components. Current count: ", currentCount)
				end
	    end

			if doUpgradeComp then

				ts = Game.GetTransactionSystem()
				itemid = GetSingleton("gameItemID"):FromTDBID(TweakDBID.new("Items.RareMaterial2"))
				currentCount = ts:GetItemQuantity(player, itemid)

				if (currentCount >= rareUpLimit + compToConvert) then
					ts:RemoveItem(player, itemid, compToConvert)
					Game.AddToInventory("Items.EpicMaterial2", compToReturn)

					if useVanillaExp then
						Game.AddExp("Crafting", 54*compToReturn)
					else
						Game.AddExp("Crafting", epicExp)
					end

					if useDebugPrint then
						print("Rare Upgrade Components removed: ", compToConvert)
						print("Epic Upgrade Components added: ", compToReturn)
					end
				else
					if useDebugPrint then
						print("Not enough Rare Upgrade Components. Current count: ", currentCount)
					end
				end
			end


------------------------------------------------
--EPIC UPGRADE

			ts = Game.GetTransactionSystem()
			itemid = GetSingleton("gameItemID"):FromTDBID(TweakDBID.new("Items.EpicMaterial1"))
			currentCount = ts:GetItemQuantity(player, itemid)

			if (currentCount >= epicLimit + compToConvert) then
				ts:RemoveItem(player, itemid, compToConvert)
				Game.AddToInventory("Items.LegendaryMaterial1", compToReturn)

				if useVanillaExp then
					Game.AddExp("Crafting", 90*compToReturn)
				else
					Game.AddExp("Crafting", legendaryExp)
				end

				if useDebugPrint then
					print("Epic Components removed: ", compToConvert)
					print("Legendary Components added: ", compToReturn)
				end
			else
				if useDebugPrint then
					print("Not enough Epic Components. Current count: ", currentCount)
				end
	    end

			if doUpgradeComp then

				ts = Game.GetTransactionSystem()
				itemid = GetSingleton("gameItemID"):FromTDBID(TweakDBID.new("Items.EpicMaterial2"))
				currentCount = ts:GetItemQuantity(player, itemid)

				if (currentCount >= epicUpLimit + compToConvert) then
					ts:RemoveItem(player, itemid, compToConvert)
					Game.AddToInventory("Items.LegendaryMaterial2", compToReturn)

					if useVanillaExp then
						Game.AddExp("Crafting", 90*compToReturn)
					else
						Game.AddExp("Crafting", legendaryExp)
					end

					if useDebugPrint then
						print("Epic Upgrade Components removed: ", compToConvert)
						print("Legendary Upgrade Components added: ", compToReturn)
					end
				else
					if useDebugPrint then
						print("Not enough Epic Upgrade Components. Current count: ", currentCount)
					end
				end
			end

------------------------------------------------

		end
	end)
