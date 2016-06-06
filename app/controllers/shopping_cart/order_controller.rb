class OrderController < ApplicationController
  before_action :define_order, only: [:show]
  authorize_resource

  include CartItems

  def index
    @orders      = current_user&.orders
    @order       = @orders.find_by(aasm_state: 'in_progress')
    @order_items = get_items_hash(order: @order) or get_items_hash(session: session)
    @shipping    = @orders.where(aasm_state: 'shipping')
    @completed   = @orders.where(aasm_state: 'completed')
  end

  def new
    @book = Book.find(params[:book])
    @user = current_user
  end

  def create
    review = ReviewForm.new(params: params_review)
    review.submit
    review.save ? (render json: {status: 200}) : (render json: review.errors, status: :unprocessable_entity)
  end

  private

  def define_order
    @order = Order.find(params[:id])
  end

  def params_order
    params.require(:order).permit(:rating_points, :rating_book_id, :rating_user_id, :review_theme,
                                   :review_text, :review_user_id, :review_book_id)
  end
end
