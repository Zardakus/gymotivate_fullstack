class Workout < ApplicationRecord
  belongs_to :trainer, class_name: 'User'
  belongs_to :member, class_name: 'User'
end
