# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string(:name)
      t.integer(:plevel)
      t.datetime(:deadline)
      t.boolean(:done, default: false)

      t.timestamps
    end
  end
end
