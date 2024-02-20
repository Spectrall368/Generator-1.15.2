<#include "mcitems.ftl">
{
	ItemStack _isc = ${mappedMCItemToItemStackCode(input$item, 1)}.copy();
	final ItemStack _setstack = ${mappedMCItemToItemStackCode(input$slotitem, 1)};
	final int _sltid = ${opt.toInt(input$slotid)};
	_setstack.setCount(${opt.toInt(input$amount)});
	_isc.getCapability(CapabilityItemHandler.ITEM_HANDLER_CAPABILITY, null).ifPresent(capability -> {
		if (capability instanceof IItemHandlerModifiable) {
            ((IItemHandlerModifiable) capability).setStackInSlot(_sltid, _setstack);
        }
	});
}
