if (world.getWorld() instanceof ServerWorld)
	((ServerWorld) world.getWorld()).getServer().getCommandManager().handleCommand(
	new CommandSource(ICommandSource.DUMMY, new Vec3d(${input$x}, ${input$y}, ${input$z}), Vec2f.ZERO,
	((ServerWorld) world.getWorld()), 4, "", new StringTextComponent(""), ((ServerWorld) world.getWorld()).getServer(), null).withFeedbackDisabled(), ${input$command});
