class ChangeNameOfTAndC < ActiveRecord::Migration
  def up
  rename_column :users, :accepted_t_and_c, :terms
  end

  def down
  rename_column :users, :terms, :accepted_t_and_c
  end
end
