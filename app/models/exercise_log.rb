class ExerciseLog < ApplicationRecord
  belongs_to :workout_log
  belongs_to :exercise
end
