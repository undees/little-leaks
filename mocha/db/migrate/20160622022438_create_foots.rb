class CreateFoots < ActiveRecord::Migration
  def change
    create_table :foots do |t|
      t.integer :size

      t.timestamps null: false
    end
  end
end
