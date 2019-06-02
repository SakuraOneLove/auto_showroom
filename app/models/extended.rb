class String
  def to_l
    return 0 if self.downcase == "false"
    return 1 if self.downcase == "true"
  end
end

class Extended < ApplicationRecord
    has_many :product

    def self.get_row_id(abs, heat, mult, sens, nav)
        id = Extended.find_by_sql("SELECT id FROM extendeds WHERE abs=#{abs.to_l} and heating=#{heat.to_l} and 
        multim=#{mult.to_l} and p_sens=#{sens.to_l} and nav=#{nav.to_l}")[0]
        id.id
    end

    def self.get_price(id)
      sum = 0
      ex = ActiveRecord::Base.connection.execute("SELECT * FROM extendeds WHERE id = #{id}")[0]
      sum += ex[1] * 20_000 + ex[2] * 30_000 + ex[3] * 50_000 + ex[4] * 40_000 + ex[5] * 10_000
    end
end
