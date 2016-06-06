class CartController < ApplicationController

  include CartItems

  before_action -> { session[:cart] ||= Hash.new; session[:coupon] ||= Hash.new }

  def show
    redirect_to checkout_path(:address) and return if get_order
    @cart = get_items_hash(session: session)
  end

  def add
    unless session[:cart][params[:id]].nil?
      session[:cart][params[:id]] = session[:cart][params[:id]].to_i + params[:quantity].to_i
      redirect_to cart_path and return
    end
    session[:cart][params[:id]] = params[:quantity].to_i

    redirect_to cart_path
  end

  def update
    if params[:coupon] =~ /^\d+$/
      coupon = Coupon.find_by(number: params[:coupon])
      session[:coupon]['id']       = coupon&.id
      session[:coupon]['number']   = coupon&.number
      session[:coupon]['discount'] = coupon&.discount
    else
      session[:coupon]['id']       = nil
      session[:coupon]['number']   = nil
      session[:coupon]['discount'] = nil
    end
    params[:cart]&.keys&.each do |book_id|
      session[:cart].delete(book_id) and next if params[:cart][book_id] == ''
      session[:cart][book_id] = params[:cart][book_id]
    end

    redirect_to cart_path
  end

  def destroy
    if params[:stat] == "0"
      session[:cart].delete(params[:id]) if session[:cart].key? params[:id]
    elsif params[:stat] == "1"
      session[:cart].clear
      session[:coupon]&.clear
    end

    redirect_to cart_path
  end

end