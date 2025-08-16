private static Item getRandomItem(String name) {
		Tag<Item> tag = ItemTags.getCollection().getOrCreate(new ResourceLocation(name));
		return tag.getAllElements().isEmpty() ? Items.AIR : tag.getRandomElement(new Random());
}