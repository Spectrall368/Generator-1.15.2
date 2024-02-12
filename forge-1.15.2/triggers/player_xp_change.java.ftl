<#include "procedures.java.ftl">
@Mod.EventBusSubscriber public class ${name}Procedure {
	@SubscribeEvent public static void onPlayerXPChange(PlayerXpEvent.XpChange event) {
		if (event != null && event.getEntity() != null) {
			<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
				"x": "event.getEntity().posX",
				"y": "event.getEntity().posY",
				"z": "event.getEntity().posZ",
				"world": "event.getEntity().world",
				"entity": "event.getEntity()",
				"amount": "event.getAmount()",
				"event": "event"
				}/>
			</#compress></#assign>
			execute(event<#if dependenciesCode?has_content>,</#if>${dependenciesCode});
		}
	}
