class NestMenusInStores < ActiveRecord::Migration
  def change
    change_table :menus do |t|
      t.belongs_to :store
    end
  end
end
