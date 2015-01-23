require 'carrierwave'
require 'rmagick'

class MyUploader < Carrierwave::Uploader::Base
	include CarrierWave::RMagick
	version :thumb do
		process :resize_to_fill => [200, 200]
	end
	storage :file
end

file = File.open('d:/Gamla*/pics/diverse')
uploader = MyUploader.new
uploader.store!(file)

CarrierWave.configure do |config|
	config.fog_credentials = {
		:provider => 'AWS',
		:aws_secret_key_id => 'xxx',
		:aws_secret_access_key => 'yyy'
	}
	config.fog_directory = 'zzz'
end

class MyUploader < Carrierwave::Uploader::Base
	storage :fog
end