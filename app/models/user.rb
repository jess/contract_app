class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  PROVIDERS = {
    google_oauth2: "googleid",
    facebook: "facebookid",

  }

  def self.from_omniauth(auth)
    provider_column = PROVIDERS[auth.provider.to_sym]
    user = User.find_by(provider_column => auth.uid)
    if user.blank?
      user = User.find_by(email: auth.info.email)
      user.update(provider_column => auth.uid) if user.present?
    end
    if user.blank?
      user = User.new
      user.email = auth.info.email
      user[provider_column] = auth.uid
      user.password = Devise.friendly_token[0,20]
      user.save
      #user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
    user
  end
end
