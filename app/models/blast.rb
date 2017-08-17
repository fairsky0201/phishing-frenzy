# == Schema Information
#
# Table name: blasts
#
#  id                :integer          not null, primary key
#  campaign_id       :integer
#  test              :boolean          default(FALSE)
#  number_of_targets :integer
#  emails_sent       :integer          default(0)
#  message           :string(255)      default("Started  ")
#  created_at        :datetime
#  updated_at        :datetime
#  baits_count       :integer          default(0)
#

class Blast < ActiveRecord::Base
  attr_accessible :campaign_id, :emails_sent, :message, :number_of_targets, :test
  belongs_to :campaign
  has_many :baits, dependent: :destroy

  def email_delivered!
    Blast.increment_counter(:emails_sent, self.id)
  end

  def smtp_failures
    baits.select{|b| b.status.blank?}.size
  end
end

