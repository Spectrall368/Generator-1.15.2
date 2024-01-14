<#--
 # MCreator (https://mcreator.net/)
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2023, Pylo, opensource contributors
 #
 # This program is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <https://www.gnu.org/licenses/>.
 #
 # Additional permission for code generator templates (*.ftl files)
 #
 # As a special exception, you may create a larger work that contains part or
 # all of the MCreator code generator templates (*.ftl files) and distribute
 # that work under terms of your choice, so long as that work isn't itself a
 # template for code generation. Alternatively, if you modify or redistribute
 # the template itself, you may (at your option) remove this special exception,
 # which will cause the template and the resulting code generator output files
 # to be licensed under the GNU General Public License without this special
 # exception.
-->

<#-- @formatter:off -->
<#include "../mcitems.ftl">
package ${package}.world.biome;

public class ${name}Biome extends Biome {

	<#if data.spawnBiome>
	public static void init() {
	BiomeManager.addSpawnBiome(${JavaModName}Biomes.${data.getModElement().getRegistryNameUpper()}.get());
		BiomeManager.addBiome(BiomeManager.BiomeType.
		<#if (data.temperature < -0.25)>
		ICY
		<#elseif (data.temperature > -0.25) && (data.temperature <= 0.15)>
		COOL
		<#elseif (data.temperature > 0.15) && (data.temperature <= 1.0)>
		WARM
		<#elseif (data.temperature > 1.0)>
		DESERT
		</#if>, new BiomeManager.BiomeEntry(${JavaModName}Biomes.${data.getModElement().getRegistryNameUpper()}.get(), ${data.biomeWeight}));
	}
	</#if>

	public ${name}Biome() {
		super(new Biome.Builder()
			.downfall(${data.rainingPossibility}f)
			.depth(${data.baseHeight}f)
			.scale(${data.heightVariation}f)
			.temperature(${data.temperature}f)
			.precipitation(Biome.RainType.<#if (data.rainingPossibility > 0)><#if (data.temperature > 0.15)>RAIN<#else>SNOW</#if><#else>NONE</#if>)
			.category(Biome.Category.NONE)
			.waterColor(${data.waterColor?has_content?then(data.waterColor.getRGB(), 4159204)})
			.waterFogColor(${data.waterFogColor?has_content?then(data.waterFogColor.getRGB(), 329011)})
			.surfaceBuilder(SurfaceBuilder.DEFAULT, new SurfaceBuilderConfig(${mappedBlockToBlockStateCode(data.groundBlock)}, ${mappedBlockToBlockStateCode(data.undergroundBlock)}, ${mappedBlockToBlockStateCode(data.getUnderwaterBlock())})));

        	<#list data.defaultFeatures as defaultFeature>
        	<#assign mfeat = generator.map(defaultFeature, "defaultfeatures")>
        		<#if mfeat != "null">
			DefaultBiomeFeatures.add${mfeat}(this);
			</#if>
		</#list>

		<#if data.spawnStronghold>
		this.addStructure(Feature.STRONGHOLD.withConfiguration(IFeatureConfig.NO_FEATURE_CONFIG));
		</#if>

		<#if data.spawnMineshaft>
		this.addStructure(Feature.MINESHAFT.withConfiguration(new MineshaftConfig(0.004D, MineshaftStructure.Type.NORMAL)));
		</#if>

		<#if data.spawnMineshaftMesa>
		this.addStructure(Feature.MINESHAFT.withConfiguration(new MineshaftConfig(0.004D, MineshaftStructure.Type.MESA)));
		</#if>

		<#if data.spawnPillagerOutpost>
		this.addStructure(Feature.PILLAGER_OUTPOST.withConfiguration(IFeatureConfig.NO_FEATURE_CONFIG));
		</#if>

		<#if data.villageType != "none">
		this.addStructure(Feature.VILLAGE.withConfiguration(new VillageConfig("village/${data.villageType}/town_centers", 6)));
		</#if>

		<#if data.spawnWoodlandMansion>
		this.addStructure(Feature.WOODLAND_MANSION.withConfiguration(IFeatureConfig.NO_FEATURE_CONFIG));
		</#if>

		<#if data.spawnJungleTemple>
		this.addStructure(Feature.JUNGLE_TEMPLE.withConfiguration(IFeatureConfig.NO_FEATURE_CONFIG));
		</#if>

		<#if data.spawnDesertPyramid>
		this.addStructure(Feature.DESERT_PYRAMID.withConfiguration(IFeatureConfig.NO_FEATURE_CONFIG));
		</#if>

		<#if data.spawnSwampHut>
		this.addStructure(Feature.SWAMP_HUT.withConfiguration(IFeatureConfig.NO_FEATURE_CONFIG));
		</#if>

		<#if data.spawnIgloo>
		this.addStructure(Feature.IGLOO.withConfiguration(IFeatureConfig.NO_FEATURE_CONFIG));
		</#if>

		<#if data.spawnOceanMonument>
		this.addStructure(Feature.OCEAN_MONUMENT.withConfiguration(IFeatureConfig.NO_FEATURE_CONFIG));
		</#if>

		<#if data.spawnShipwreck>
		this.addStructure(Feature.SHIPWRECK.withConfiguration(new ShipwreckConfig(false)));
		</#if>

		<#if data.spawnShipwreckBeached>
		this.addStructure(Feature.SHIPWRECK.withConfiguration(new ShipwreckConfig(true)));
		</#if>

		<#if data.spawnBuriedTreasure>
		this.addStructure(Feature.BURIED_TREASURE.withConfiguration(new BuriedTreasureConfig(0.01F)));
		</#if>

		<#if data.oceanRuinType != "NONE">
		this.addStructure(Feature.OCEAN_RUIN.withConfiguration(new OceanRuinConfig(OceanRuinStructure.Type.${data.oceanRuinType}, 0.3F, 0.9F)));
		</#if>

		<#if data.spawnNetherBridge>
		this.addStructure(Feature.NETHER_BRIDGE.withConfiguration(IFeatureConfig.NO_FEATURE_CONFIG));
		</#if>

		<#if data.spawnEndCity>
		this.addStructure(Feature.END_CITY.withConfiguration(IFeatureConfig.NO_FEATURE_CONFIG));
		</#if>

		<#if (data.flowersPerChunk > 0)>
		this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.FLOWER.withConfiguration(DefaultBiomeFeatures.DEFAULT_FLOWER_CONFIG).withPlacement(Placement.COUNT_HEIGHTMAP_32.configure(new FrequencyConfig(${data.flowersPerChunk}))));
		</#if>

		<#if (data.grassPerChunk > 0)>
		this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.RANDOM_PATCH.withConfiguration(DefaultBiomeFeatures.GRASS_CONFIG).withPlacement(Placement.COUNT_HEIGHTMAP_DOUBLE.configure(new FrequencyConfig(${data.grassPerChunk}))));
		</#if>

		<#if (data.seagrassPerChunk > 0)>
		this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.SEAGRASS.withConfiguration(new SeaGrassConfig(${data.seagrassPerChunk}, 0.3D)).withPlacement(Placement.TOP_SOLID_HEIGHTMAP.configure(IPlacementConfig.NO_PLACEMENT_CONFIG)));
		</#if>

		<#if (data.mushroomsPerChunk > 0)>
		this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.RANDOM_PATCH.withConfiguration(DefaultBiomeFeatures.BROWN_MUSHROOM_CONFIG).withPlacement(Placement.CHANCE_HEIGHTMAP_DOUBLE.configure(new ChanceConfig(${data.mushroomsPerChunk}))));
		this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.RANDOM_PATCH.withConfiguration(DefaultBiomeFeatures.RED_MUSHROOM_CONFIG).withPlacement(Placement.CHANCE_HEIGHTMAP_DOUBLE.configure(new ChanceConfig(${data.mushroomsPerChunk}))));
		</#if>

		<#if (data.treesPerChunk > 0)>
			<#if data.treeType == data.TREES_CUSTOM>
			this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, new ${name}TreeFeature().withConfiguration((new BaseTreeFeatureConfig.Builder(new SimpleBlockStateProvider(${mappedBlockToBlockStateCode(data.treeStem)}), new SimpleBlockStateProvider(${mappedBlockToBlockStateCode(data.treeBranch)}))).baseHeight(${data.minHeight}).setSapling((net.minecraftforge.common.IPlantable)Blocks.OAK_SAPLING).build()).withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
            		<#elseif data.vanillaTreeType == "Big trees">
			this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.RANDOM_SELECTOR.withConfiguration(new MultipleRandomFeatureConfig(ImmutableList.of(Feature.FANCY_TREE.withConfiguration(DefaultBiomeFeatures.FANCY_TREE_CONFIG).withChance(0.1F)), Feature.NORMAL_TREE.withConfiguration(DefaultBiomeFeatures.JUNGLE_TREE_CONFIG))).withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
            		<#elseif data.vanillaTreeType == "Savanna trees">
			this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.RANDOM_SELECTOR.withConfiguration(new MultipleRandomFeatureConfig(ImmutableList.of(Feature.ACACIA_TREE.withConfiguration(DefaultBiomeFeatures.ACACIA_TREE_CONFIG).withChance(0.8F)), Feature.NORMAL_TREE.withConfiguration(DefaultBiomeFeatures.OAK_TREE_CONFIG))).withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
            		<#elseif data.vanillaTreeType == "Mega pine trees">
			this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.RANDOM_SELECTOR.withConfiguration(new MultipleRandomFeatureConfig(ImmutableList.of(Feature.MEGA_SPRUCE_TREE.withConfiguration(DefaultBiomeFeatures.MEGA_PINE_TREE_CONFIG).withChance(0.30769232F)), Feature.NORMAL_TREE.withConfiguration(DefaultBiomeFeatures.SPRUCE_TREE_CONFIG))).withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
            		<#elseif data.vanillaTreeType == "Mega spruce trees">
			this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.RANDOM_SELECTOR.withConfiguration(new MultipleRandomFeatureConfig(ImmutableList.of(Feature.MEGA_SPRUCE_TREE.withConfiguration(DefaultBiomeFeatures.MEGA_SPRUCE_TREE_CONFIG).withChance(0.33333334F)), Feature.NORMAL_TREE.withConfiguration(DefaultBiomeFeatures.SPRUCE_TREE_CONFIG))).withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
            		<#elseif data.vanillaTreeType == "Birch trees">
			this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.NORMAL_TREE.withConfiguration(DefaultBiomeFeatures.field_230129_h_).withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
            		<#else>
			this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.RANDOM_SELECTOR.withConfiguration(new MultipleRandomFeatureConfig(ImmutableList.of(Feature.NORMAL_TREE.withConfiguration(DefaultBiomeFeatures.field_230129_h_).withChance(0.2F), Feature.FANCY_TREE.withConfiguration(DefaultBiomeFeatures.field_230131_m_).withChance(0.1F)), Feature.NORMAL_TREE.withConfiguration(DefaultBiomeFeatures.field_230132_o_))).withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
			</#if>
		</#if>

		<#if (data.bigMushroomsChunk > 0)>
		this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.RANDOM_BOOLEAN_SELECTOR.withConfiguration(new TwoFeatureChoiceConfig(Feature.HUGE_RED_MUSHROOM.withConfiguration(DefaultBiomeFeatures.BIG_RED_MUSHROOM), Feature.HUGE_BROWN_MUSHROOM.withConfiguration(DefaultBiomeFeatures.BIG_BROWN_MUSHROOM))).withPlacement(Placement.COUNT_HEIGHTMAP.configure(new FrequencyConfig(${data.bigMushroomsChunk}))));
		</#if>

		<#if (data.reedsPerChunk > 0)>
		this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.RANDOM_PATCH.withConfiguration(DefaultBiomeFeatures.SUGAR_CANE_CONFIG).withPlacement(Placement.COUNT_HEIGHTMAP_DOUBLE.configure(new FrequencyConfig(${data.reedsPerChunk}))));
		</#if>

		<#if (data.cactiPerChunk > 0)>
		this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION, Feature.RANDOM_PATCH.withConfiguration(DefaultBiomeFeatures.CACTUS_CONFIG).withPlacement(Placement.COUNT_HEIGHTMAP_DOUBLE.configure(new FrequencyConfig(${data.cactiPerChunk}))));
		</#if>

		<#if (data.sandPatchesPerChunk > 0)>
		this.addFeature(GenerationStage.Decoration.UNDERGROUND_ORES, Feature.DISK.withConfiguration(new SphereReplaceConfig(Blocks.SAND.getDefaultState(), 7, 2, Lists.newArrayList(${mappedBlockToBlockStateCode(data.groundBlock)}, ${mappedBlockToBlockStateCode(data.undergroundBlock)}))).withPlacement(Placement.COUNT_TOP_SOLID.configure(new FrequencyConfig(${data.sandPatchesPerChunk}))));
		</#if>

		<#if (data.gravelPatchesPerChunk > 0)>
		this.addFeature(GenerationStage.Decoration.UNDERGROUND_ORES, Feature.DISK.withConfiguration(new SphereReplaceConfig(Blocks.GRAVEL.getDefaultState(), 6, 2, Lists.newArrayList(${mappedBlockToBlockStateCode(data.groundBlock)}, ${mappedBlockToBlockStateCode(data.undergroundBlock)}))).withPlacement(Placement.COUNT_TOP_SOLID.configure(new FrequencyConfig(${data.gravelPatchesPerChunk}))));
		</#if>

		<#list data.spawnEntries as spawnEntry>
			<#assign entity = generator.map(spawnEntry.entity.getUnmappedValue(), "entities", 1)!"null">
			<#if entity != "null">
			this.addSpawn(${generator.map(spawnEntry.spawnType, "mobspawntypes")}, new Biome.SpawnListEntry(${entity}, ${spawnEntry.weight}, ${spawnEntry.minGroup}, ${spawnEntry.maxGroup}));
			</#if>
		</#list>
		}

	@OnlyIn(Dist.CLIENT) @Override public int getGrassColor(double posX, double posZ) {
		return ${data.grassColor?has_content?then(data.grassColor.getRGB(), 9470285)};
	}

        @OnlyIn(Dist.CLIENT) @Override public int getFoliageColor() {
        	return ${data.foliageColor?has_content?then(data.foliageColor.getRGB(), 10387789)};
       	 }

	@OnlyIn(Dist.CLIENT) @Override public int getSkyColor() {
		return ${data.airColor?has_content?then(data.airColor.getRGB(), 7972607)};
	}
}
<#-- @formatter:on -->
