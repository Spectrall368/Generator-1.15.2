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

import net.minecraftforge.common.BiomeManager;

public class ${name}Biome extends Biome {

	<#if data.spawnBiome>
	public static void init() {
	BiomeManager.addSpawnBiome(${JavaModName}Biomes.${REGISTRYNAME}.get());
		BiomeManager.addBiome(BiomeManager.BiomeType.
		<#if (data.temperature < -0.25)>
		ICY
		<#elseif (data.temperature > -0.25) && (data.temperature <= 0.15)>
		COOL
		<#elseif (data.temperature > 0.15) && (data.temperature <= 1.0)>
		WARM
		<#elseif (data.temperature > 1.0)>
		DESERT
		</#if>, new BiomeManager.BiomeEntry(${JavaModName}Biomes.${REGISTRYNAME}.get(), ${data.biomeWeight}));
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

        <#if (data.treesPerChunk > 0)>
        	<#assign ct = data.treeType == data.TREES_CUSTOM>

        	<#if data.vanillaTreeType == "Big trees">
        	this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION,
				Feature.MEGA_JUNGLE_TREE.withConfiguration((new HugeTreeFeatureConfig.Builder(
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.JUNGLE_LOG.getDefaultState()")}),
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.JUNGLE_LEAVES.getDefaultState()")}))
                    .baseHeight(${ct?then([data.minHeight, 32]?min, 10)}).heightInterval(20)
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    </#if>)
            	.build())
            	.withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
        	<#elseif data.vanillaTreeType == "Savanna trees">
        	this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION,
                Feature.ACACIA_TREE.withConfiguration((new TreeFeatureConfig.Builder(
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.ACACIA_LOG.getDefaultState()")}),
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.ACACIA_LEAVES.getDefaultState()")}),
                    new AcaciaFoliagePlacer(2, 0))
                    .baseHeight(${ct?then([data.minHeight, 32]?min, 5)}).heightRandA(2).heightRandB(2)
                    .trunkHeight(0)
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    <#else>
                    	.ignoreVines()
                    </#if>)
            	.build())
            	.withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
        	<#elseif data.vanillaTreeType == "Mega pine trees">
        	this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION,
				Feature.MEGA_SPRUCE_TREE.withConfiguration((new HugeTreeFeatureConfig.Builder(
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.SPRUCE_LOG.getDefaultState()")}),
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.SPRUCE_LEAVES.getDefaultState()")}))
                    .baseHeight(${ct?then([data.minHeight, 32]?min, 13)}).heightInterval(15).crownHeight(3)
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    </#if>)
            	.build())
            	.withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
        	<#elseif data.vanillaTreeType == "Mega spruce trees">
        	this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION,
				Feature.MEGA_SPRUCE_TREE.withConfiguration((new HugeTreeFeatureConfig.Builder(
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.SPRUCE_LOG.getDefaultState()")}),
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.SPRUCE_LEAVES.getDefaultState()")}))
		            .baseHeight(${ct?then([data.minHeight, 32]?min, 13)}).heightInterval(15).crownHeight(13)
                    .decorators(ImmutableList.of(new AlterGroundTreeDecorator(new SimpleBlockStateProvider(Blocks.PODZOL.getDefaultState()))))
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    </#if>)
            	.build())
            	.withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
        	<#elseif data.vanillaTreeType == "Birch trees">
        	this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION,
				Feature.NORMAL_TREE.withConfiguration((new TreeFeatureConfig.Builder(
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.BIRCH_LOG.getDefaultState()")}),
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.BIRCH_LEAVES.getDefaultState()")}),
                    new BlobFoliagePlacer(2, 0))
                    .baseHeight(${ct?then([data.minHeight, 32]?min, 5)}).heightRandA(2).foliageHeight(3)
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    <#else>
                    	.ignoreVines()
                    </#if>)
            	.build())
            	.withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
        	<#else>
        	this.addFeature(GenerationStage.Decoration.VEGETAL_DECORATION,
				Feature.NORMAL_TREE.withConfiguration((new TreeFeatureConfig.Builder(
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.OAK_LOG.getDefaultState()")}),
                    new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.OAK_LEAVES.getDefaultState()")}),
                    new BlobFoliagePlacer(2, 0))
		            .baseHeight(${ct?then([data.minHeight, 32]?min, 4)}).heightRandA(2).foliageHeight(3)
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    <#else>
                    	.ignoreVines()
                    </#if>)
            	.build())
            	.withPlacement(Placement.COUNT_EXTRA_HEIGHTMAP.configure(new AtSurfaceWithExtraConfig(${data.treesPerChunk}, 0.1F, 1))));
        	</#if>
        </#if>

		<#list data.spawnEntries as spawnEntry>
			<#assign entity = spawnEntry.entity.getMappedValue(1)!"null">
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
<#macro vinesAndFruits>
.decorators(ImmutableList.of(
	<#if data.hasVines()>
		${name}LeaveDecorator.INSTANCE,
		${name}TrunkDecorator.INSTANCE
	</#if>

	<#if data.hasFruits()>
	    <#if data.hasVines()>,</#if>
        ${name}FruitDecorator.INSTANCE
	</#if>
))
</#macro>
<#-- @formatter:on -->