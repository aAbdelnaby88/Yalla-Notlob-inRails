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


    def addNewOrder
        @u1=session[:logged_in_user]
        @order=Order.create(:meal=>params['meal'],:from=>params['from'],:user_id=>@u1['id'],:status =>"waiting")    
        @usersData=JSON.parse(params['users'])
        @usersData.each do |u|
            user= User.find(u['id'])
            @order.users << user
        end
        redirect_to '/orders'
    end


    def order
        @u1=session[:logged_in_user]
        @orders=Order.where(:user=>@u1['id'])
        
        p @orders
    end

    def show_order
        @order = Order.where(id: params[:id]).first
        @user = session[:logged_in_user]

        unless @order
            return render_404
        end
        
    end

    def render_404
        respond_to do |format|
          format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
          format.xml  { head :not_found }
          format.any  { head :not_found }
        end
    end

    def create_item
        
        @order = Order.find(params[:id])
        @user = session[:logged_in_user]
        item = Item.create(:name => params[:name], :price => params[:price],
            :amount => params[:amount], :comment => params[:comment],
            :order_user => User.find(@user["id"]).order_user.where(:order_id => @order.id).first)
        p "item=>",item
        redirect_to action: 'show_order', id: @order.id
    end

    def delete_item
        
        @order = Order.find(params[:id])
        Item.find(params[:item_id]).delete

        redirect_to action: 'show_order', id: @order.id
    end

    def delete_order
        order_id=params[:order_id]
        @users=OrderUser.where(:order_id=>order_id)
        @users.each do |u|
            OrderUser.where(:order_id=>order_id,:user_id =>u.id).delete
        end
        p Order.find(order_id).delete
        redirect_to '/orders'
    end

    def change_status_order
        order_id=params[:order_id]
        Order.find(order_id).update_attribute(:status,"finished")
        redirect_to '/orders'
    end
end
