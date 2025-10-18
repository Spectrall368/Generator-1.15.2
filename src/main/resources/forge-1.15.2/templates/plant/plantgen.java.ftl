<#--
 # MCreator (https://mcreator.net/)
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
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
<#include "../procedures.java.ftl">
<#include "../mcitems.ftl">
package ${package}.world.features.plants;
<#assign cond = false>
<#if data.restrictionBiomes?has_content>
	<#list w.filterBrokenReferences(data.restrictionBiomes) as restrictionBiome>
	    <#assign biomeName = fixNamespace(restrictionBiome)>
        <#if biomeName == "#minecraft:is_overworld" || biomeName == "#minecraft:is_nether" || biomeName == "#minecraft:is_end">
			<#assign cond = true>
			 <#break>
		</#if>
	</#list>
</#if>

public class ${name}Feature extends <#if data.plantType == "normal" && data.generationType == "Flower">DefaultFlowers<#else>RandomPatch</#if>Feature {
    private static ${name}Feature INSTANCE = null;
  	private static ConfiguredFeature<?, ?> CONFIGURED_FEATURE = null;

	public ${name}Feature() {
		super(BlockClusterFeatureConfig::deserialize);
	}

	public static Feature<?> feature() {
		INSTANCE = new ${name}Feature();
		CONFIGURED_FEATURE = INSTANCE.withConfiguration(
                new BlockClusterFeatureConfig.Builder(new SimpleBlockStateProvider(${JavaModName}Blocks.${REGISTRYNAME}.get().getDefaultState()),
                    <#if data.plantType == "double">new DoublePlantBlockPlacer()
                    <#elseif data.plantType == "normal">new SimpleBlockPlacer()
                    <#else>new ColumnBlockPlacer(2, 2)</#if>)
                    <#if data.plantType == "growapable">.xSpread(4).ySpread(0).zSpread(4).func_227317_b_()</#if>
                    <#if data.plantType == "double" && data.generationType == "Flower">.func_227317_b_()</#if>
                    .tries(${data.patchSize}).build())
                    <#if data.generateAtAnyHeight>
                    .withPlacement(Placement.COUNT_RANGE.configure(new CountRangeConfig(${data.frequencyOnChunks}, 0, 0, 128)))
                    <#else>
                    .withPlacement(<#if !(data.generationType == "Grass" || data.plantType == "growapable")>HEIGHTMAP_WORLD_SURFACE<#else>Placement.COUNT_HEIGHTMAP</#if>.configure(new FrequencyConfig(${data.frequencyOnChunks})))</#if>;

		return INSTANCE;
	}

	public static ConfiguredFeature<?, ?> configuredFeature() {
	    if (CONFIGURED_FEATURE == null)
	        feature();

		return CONFIGURED_FEATURE;
	}

    <#if !(data.generationType == "Grass" || data.plantType == "growapable")>
    private static final Placement<FrequencyConfig> HEIGHTMAP_WORLD_SURFACE = new HeightmapWorldSurfacePlacement(FrequencyConfig::deserialize);

    private static class HeightmapWorldSurfacePlacement extends AtSurface {
       public HeightmapWorldSurfacePlacement(Function<com.mojang.datafixers.Dynamic<?>, ? extends FrequencyConfig> dynamic) {
          super(dynamic);
       }

       @Override public Stream<BlockPos> getPositions(IWorld worldIn, ChunkGenerator<? extends GenerationSettings> generatorIn, Random random, FrequencyConfig configIn, BlockPos pos) {
          return IntStream.range(0, configIn.count).mapToObj((object) -> {
             int i = random.nextInt(16) + pos.getX();
             int j = random.nextInt(16) + pos.getZ();
             int k = worldIn.getHeight(Heightmap.Type.WORLD_SURFACE_WG, i, j);
             return new BlockPos(i, k, j);
          });
       }
    }
	</#if>

	<#if data.generationType == "Flower" || data.plantType == "growapable" || (data.restrictionBiomes?has_content && cond)>
	@Override public boolean place(IWorld world, ChunkGenerator generator, Random random, BlockPos pos, BlockClusterFeatureConfig config) {
	    <#if data.restrictionBiomes?has_content && cond>
		if (!generate_dimensions.contains(world.getDimension().getType()))
			return false;
	    </#if>

        <#if data.generationType == "Flower" || data.plantType == "growapable">
         if(!(random.nextFloat() < 1.0F / (float) 32)) return false;
         </#if>

		return super.place(world, generator, random, pos, config);
	}
	</#if>

	public static final Set<ResourceLocation> GENERATE_BIOMES =
	<#if data.restrictionBiomes?has_content && !cond>
	ImmutableSet.of(
		<#list w.filterBrokenReferences(data.restrictionBiomes) as restrictionBiome>
		    <#assign expandedBiomes = expandBiomeTag(restrictionBiome)>
		    <#list expandedBiomes as expandedBiome>
			new ResourceLocation("${expandedBiome}")<#sep>,
		    </#list><#sep>,
        </#list>
	)
	<#else>
	null
	</#if>;

	<#if data.restrictionBiomes?has_content && cond>
	private final Set<DimensionType> generate_dimensions = ImmutableSet.of(
			<#list w.filterBrokenReferences(data.restrictionBiomes) as restrictionBiome>
	        <#assign biomeName = fixNamespace(restrictionBiome)>
			<#if biomeName == "#minecraft:is_overworld">
				DimensionType.OVERWORLD
			<#elseif biomeName == "#minecraft:is_nether">
				DimensionType.THE_NETHER
			<#else>
				DimensionType.THE_END
			</#if><#sep>,
		</#list>
	);
	</#if>
}
<#-- @formatter:on -->
<#function expandBiomeTag biomeTag>
    <#local result = []>

    <#if biomeTag?contains("#")>
        <#local biomeName = fixNamespace(biomeTag)>
        <#local tagKey = "BIOMES:" + biomeName?substring(1)>

        <#local tagFound = false>
        <#list w.getWorkspace().getTagElements()?keys as tagElement>
            <#if tagElement.toString().replace("mod:", modid + ":") == tagKey>
                <#local tagFound = true>
                <#local biomeValues = w.getWorkspace().getTagElements().get(tagElement)>
                <#list biomeValues as biomeValue>
                    <#if biomeValue?starts_with("#")>
                        <#local expandedSubValues = expandBiomeTag(biomeValue?replace("mod:", modid + ":"))>
                        <#list expandedSubValues as expandedSubValue>
                            <#local result = result + [expandedSubValue]>
                        </#list>
                    <#else>
                        <#local result = result + [generator.map(biomeValue, "biomes")]>
                    </#if>
                </#list>
                <#break>
            </#if>
        </#list>

        <#if !tagFound>
            <#local result = result + [biomeName?substring(1)]>
        </#if>
    <#else>
        <#local result = result + [biomeTag]>
    </#if>

    <#return result>
</#function>
<#function fixNamespace input>
    <#assign noHash = input?starts_with("#")?then(input?substring(1), input)/>

    <#if noHash?contains(":")>
        <#return input>
    <#else>
        <#assign result = "minecraft:" + noHash />
        <#return input?starts_with("#")?then("#" + result, result)/>
    </#if>
</#function>