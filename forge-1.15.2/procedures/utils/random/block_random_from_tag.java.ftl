private static Block getRandomBlock(String name) {
		Tag<Block> tag = BlockTags.getCollection().getOrCreate(new ResourceLocation(name));
		return tag.getAllElements().isEmpty() ? Blocks.AIR : tag.getRandomElement(new Random());
}