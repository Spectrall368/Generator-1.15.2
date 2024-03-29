<#include "mcelements.ftl">
<#-- @formatter:off -->
{
	TileEntity _ent = world.getTileEntity(${toBlockPos(input$x,input$y,input$z)});
	int _amount = ${opt.toInt(input$amount)};
	if (_ent != null)
		_ent.getCapability(CapabilityEnergy.ENERGY, ${input$direction}).ifPresent(capability ->
			capability.receiveEnergy(_amount, false));
}
<#-- @formatter:on -->
