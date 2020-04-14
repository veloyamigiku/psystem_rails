class PointOperator < ActiveRecord::Base
    validates :name, uniqueness: true
end
