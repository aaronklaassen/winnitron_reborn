class User < ActiveRecord::Base
  include Gravtastic
  gravtastic secure: true, size: 200

  CUSTOM_LINK_TYPES = ["Itch.io"]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github, :facebook]

  validates :name, presence: true

  has_many :machine_ownerships, dependent: :destroy
  has_many :arcade_machines, through: :machine_ownerships

  has_many :game_ownerships, dependent: :destroy
  has_many :games, through: :game_ownerships

  has_many :playlists
  has_many :links, as: :parent, dependent: :destroy

  accepts_nested_attributes_for :links, allow_destroy: true,
                                        reject_if: proc { |attrs| attrs["url"].blank? }


  def owns?(item)
    ownable = [ArcadeMachine, Playlist, Game]
    raise ArgumentError, "#{item.class} is not ownable" if !ownable.include?(item.class)

    assoc = item.class.to_s.underscore.pluralize # eff you, demeter
    self.public_send(assoc.to_sym).include?(item)
  end

  def self.from_omniauth(auth)
    where('(provider = ? AND uid = ?) OR (email = ?)',
          auth.provider,
          auth.uid,
          auth.info.email).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

end
