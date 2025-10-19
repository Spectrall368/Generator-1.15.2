<#include "mcelements.ftl">
(world.getWorld() instanceof ServerWorld && ((ServerWorld) world.getWorld()).isVillage(${toBlockPos(input$x,input$y,input$z)}))