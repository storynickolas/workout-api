class CreateWorkoutDays < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_days do |t|
      t.belongs_to :schedule
      t.belongs_to :workout
      t.string :day

      t.timestamps
    end
  end
end
