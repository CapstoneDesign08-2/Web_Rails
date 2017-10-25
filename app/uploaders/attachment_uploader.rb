class AttachmentUploader < CarrierWave::Uploader::Base

  storage :file

  def storeDir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
