class RankingController < ApplicationController
  def have
     @have_count=Ownership.where(type: "Have").group(:item_id).order('count_item_id desc').count('item_id').keys
  end
  def want
  end
end
