require 'aws-sdk-s3' 
require 'securerandom'

class OrdersController < ApplicationController

    def upload_image_to_s3
        file_name = SecureRandom.urlsafe_base64
        upload_file = '/home/muhammad/Downloads/32.png'

        s3 = Aws::S3::Resource.new
        obj = s3.bucket('yalla-notlob').object(file_name)
        obj.upload_file(upload_file)

        url = obj.public_url
    end

    def addorder
    end
end
