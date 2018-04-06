class Product < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :value,
                        :height,
                        :weight,
                        :width,
                        :length
end
