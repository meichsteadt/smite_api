class Item < ApplicationRecord
  has_many :item_stats

  def self.import_items
    api = Api.new()
    items = api.get_items
    items.each do |item|
      child_item_id = item["ChildItemId"]
      device_name = item["DeviceName"]
      icon_id = item["IconId"]
      item_id = item["ItemId"]
      item_tier = item["ItemTier"]
      price = item["Price"]
      restricted_roles = item["RestrictedRoles"]
      root_item_id = item["RootItemId"]
      short_desc = item["ShortDesc"]
      starting_item = item["StartingItem"]
      item_type = item["Type"]
      item_icon_url = item["itemIcon_URL"]
      active = false
      Item.create(
        child_item_id: child_item_id,
        device_name: device_name,
        icon_id: icon_id,
        item_id: item_id,
        item_tier: item_tier,
        price: price,
        restricted_roles: restricted_roles,
        root_item_id: root_item_id,
        short_desc: short_desc,
        starting_item: starting_item,
        item_type: item_type,
        item_icon_url: item_icon_url,
        active: active
      )
    end
  end
end
