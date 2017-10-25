class Attachments3Uploader < CarrierWave::Uploader::Base

  storage :fog

  def storeDir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
