private static boolean hasEntityRecipe(Entity entity, ResourceLocation recipe) {
	if (entity instanceof ServerPlayerEntity)
		return ((ServerPlayerEntity) entity).getRecipeBook().func_226144_b_(recipe);
	else if (entity instanceof ClientPlayerEntity && ((ClientPlayerEntity) entity).world.isRemote())
		return ((ClientPlayerEntity) entity).getRecipeBook().func_226144_b_(recipe);
	return false;
}