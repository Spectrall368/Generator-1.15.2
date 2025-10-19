<#include "mcitems.ftl">
new BlockClusterFeatureConfig.Builder(${mappedBlockToBlockStateProvider(input$block)}, new SimpleBlockPlacer())
.tries(${field$tries}).xSpread(${field$xzSpread}).zSpread(${field$xzSpread}).ySpread(${field$ySpread}).build()
$
if(!(${input$condition})) return false;
$