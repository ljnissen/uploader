require 'carrierwave'
require 'sinatra'
require 'sqlite3'
require 'sequel'
require 'carrierwave/sequel'

DB = Sequel.sqlite
DB.create_table :uploads do 
	String :file 	
end

# uploader
class MyUploader < CarrierWave::Uploader::Base
	storage :file
end

# model
class Upload < Sequel::Model
	mount_uploader :file, MyUploader
end

# sinatra app
get '/' do
	@uploads = Upload.all
	erb :index
end

post '/' do
	upload = Upload.new
	upload.file = params[:image]
	upload.save
	redirect to('/')
end

__END__

@@ index
<!DOCTYPE html>
<html>
	<body>
		<div>
			<form action="/" method="post" enctype="multipart/form-data">
				<input type="file" name="image" />
				<input type="submit" name="submit" value="Upload" />
			</form>
				<% @uploads.each do |upload| %>
					<img src="<%= upload.file.url %>" />
				<% end %>
		</div>
	</body>
</html>


