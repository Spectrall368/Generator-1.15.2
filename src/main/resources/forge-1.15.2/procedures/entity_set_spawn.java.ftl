<#include "mcelements.ftl">
if(${input$entity} instanceof PlayerEntity) ((PlayerEntity) ${input$entity}).setSpawnPoint(${toBlockPos(input$x,input$y,input$z)}, true, false, ${input$entity}.dimension);