class Url < ActiveRecord::Base
    scope :recent, -> { order(created_at: :desc) }

    attr_accessor :email

    validates :long, presence: true, uniqueness: { case_sensitive: true }, url: true
    validate :validate_blank_email

    def self.has_url(url)
        return where(long: url).present?
    end

    def self.get_from_long(long)
        where(long: long).first
    end

    def self.get_from_short(short)
        id = Bijective::Encoder.decode(short)
        find(id)
    end

    def validate_blank_email
        errors.add(:email, 'must be blank') unless @email.blank?
    end

    def short
        Bijective::Encoder.encode(id)
    end

    def duplicate?
        return false unless new_record?
        return true if Url.has_url(long)
    end

    def to_param
        short
    end
end
