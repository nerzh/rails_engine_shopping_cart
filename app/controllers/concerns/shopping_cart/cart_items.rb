module CartItems
  extend ActiveSupport::Concern

  def get_items_hash(order: nil, session: nil)
    return nil if order.nil? and session.nil?
    order ? items = order.order_items.pluck(:book_id, :quantity) : items = session[:cart].map{ |k,v| [k,v] }
    books_ids = items.map{ |arr| arr[0] }
    @cart = []
    books = Book.where(id: books_ids)
    items.each do |item|
      book = books.find(item[0])

      value               = {}
      value[:id]          = book.id
      value[:title]       = book.title
      value[:description] = book.description
      value[:price]       = book.show_price
      value[:image]       = book.cover.small
      value[:amount]      = item[1].to_i
      order ? value[:total] = show_price(order.total_price) : value[:total] = book.show_price * value[:amount]
      value[:coupon] = session[:coupon]['discount'] if session and session[:coupon]&.present?

      @cart << value
    end
    @cart
  end

  def show_price(price)
    return 0.0 if price.nil?
    (price.to_d/1000).round 2
  end

  def set_price(price)
    return 0 if price.nil?
    (price*1000).to_i
  end

end