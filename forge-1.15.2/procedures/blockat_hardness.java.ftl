<#include "mcelements.ftl">
/*@float*/(world.getBlockState(${toBlockPos(input$x,input$y,input$z)}).getBlockHardness(world, ${toBlockPos(input$x,input$y,input$z)}))
