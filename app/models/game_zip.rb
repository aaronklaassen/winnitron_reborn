require "open-uri"
require "zip"

class GameZip < ActiveRecord::Base
  after_create -> { ProcessGameZipJob.perform_later(self.id) }

  belongs_to :game
  belongs_to :user

  validates :user_id, :game_id, :file_key, :file_last_modified, presence: true
  validate :is_a_zip

  def humanized_filename
    file_key.sub("games/", "")
  end

  def expiring_url
    object = Aws::S3::Object.new(bucket_name: ENV["AWS_BUCKET"], key: file_key)
    object.presigned_url(:get, expires_in: 1.hour)
  end

  def likely_executable
    exes = root_files.select { |file| file.split(".").last == "exe" }
    html = root_files.select { |file| file.split(".").last == "html" }

    exes.first || html.first
  end

  def candidates
    root_files.select do |file|
      ext = file.split(".").last
      ext == "exe" || ext == "html"
    end
  end

  private

  def is_a_zip
    if file_key && file_key[-4..-1].downcase != ".zip"
      errors.add(:file_key, "must be a .zip file")
    end
  end
end