Spree::Variant.class_eval do

  has_and_belongs_to_many  :assemblies, :class_name => "Spree::Product",
        :join_table => "spree_assemblies_parts",
        :foreign_key => "part_id", :association_foreign_key => "assembly_id"

  delegate :assembly?, :to => :product

  # returns the number of inventory units "on_hand" for this variant
  def on_hand_with_assembly(reload = false)
    if Spree::Config[:track_inventory_levels] && self.assembly?
      self.product.on_hand
    else
      on_hand_without_assembly
    end
  end
  alias_method_chain :on_hand, :assembly unless method_defined?(:on_hand_without_assembly)

end
