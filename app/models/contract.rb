class Contract < ApplicationRecord
  has_many :user_contracts, dependent: :destroy
  has_many :users, through: :user_contracts

  before_save :set_sharing

  def is_signed
    signature.present? && signer_name.present?
  end

  private

  def set_sharing
    return unless is_sharing_changed?
    if is_sharing?
      self.share_token = generate_token
    else
      self.share_token = nil
    end
  end

  def generate_token
    loop do
      token = SecureRandom.hex(16)
      break token unless Contract.where(share_token: token).exists?
    end
  end
end
