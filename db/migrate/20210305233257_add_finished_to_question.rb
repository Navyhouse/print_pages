class AddFinishedToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :finished, :boolean, default: false, null: false
  end
end
