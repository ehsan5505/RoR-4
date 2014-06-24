class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string		"first_name",	:limit => 40
      t.string		"last_name",	:limit => 40
      t.string		"email",		:default => "",	:null =>false,	:limit =>100
      t.string		"password",		:limit => 40
      t.timestamps
    end
  end

  def down
  	drop_table :users
  end

end
