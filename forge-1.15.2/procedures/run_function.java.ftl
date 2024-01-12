<#include "mcelements.ftl">
if(world.getWorld() instanceof ServerWorld && ((ServerWorld) world.getWorld()).getServer() != null) {
	Optional<FunctionObject> _fopt = ((ServerWorld) world.getWorld()).getServer().getFunctionManager().get(${toResourceLocation(input$function)});
	if(_fopt.isPresent())
		((ServerWorld) world.getWorld()).getServer().getFunctionManager().execute(_fopt.get(),
			new CommandSource(ICommandSource.DUMMY, new Vec3d(${input$x}, ${input$y}, ${input$z}), Vec2f.ZERO,
				((ServerWorld) world.getWorld()), 4, "", new StringTextComponent(""), ((ServerWorld) world.getWorld()).getServer(), null));
}
