require Carrierwave

class MyUploader < Carrierwave::Uploader::Base
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