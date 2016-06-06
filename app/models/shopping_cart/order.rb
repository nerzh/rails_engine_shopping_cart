class Order < ActiveRecord::Base

  include AASM

  belongs_to :user
  belongs_to :credit_card
  belongs_to :coupon
  belongs_to :delivery
  has_many   :order_items, dependent: :delete_all
  has_many   :books,       through:   :order_items
  has_one    :order_shipping_address
  has_one    :order_billing_address

  validates :total_price, :aasm_state, presence: true

  after_initialize -> { self.delivery_id = Delivery.first&.id if self.delivery_id == nil }
  after_initialize :get_address_and_credit_card, :if => :new_record?

  aasm do
    state :in_progress, :initial => true
    state :completed
    state :shipping

    event :complete do
      after do
        self.update(completed_date: Time.now)
      end
      transitions :from => :in_progress, :to => :complete
    end

    event :shipping do
      after do
        self.update(completed_date: Time.now)
      end
      transitions :from => [:in_progress, :complete], :to => :shipping
    end

    event :in_progress do
      after do
        self.update(completed_date: nil)
      end
      transitions :from => [:complete, :shipping], :to => :in_progress
    end
  end

  def get_address_and_credit_card
    if self.user&.billing_address != nil
      billing_attr = self.user.billing_address.attributes.slice('first_name', 'last_name', 'street',
                                                                'city', 'country_id', 'zip', 'phone')
      self.order_billing_address = OrderBillingAddress.new( billing_attr )
    end

    if self.user&.shipping_address != nil
      shipping_attr = self.user.shipping_address.attributes.slice('first_name', 'last_name', 'street',
                                                                  'city', 'country_id', 'zip', 'phone')
      self.order_shipping_address = OrderShippingAddress.new( shipping_attr )
    end

    if self.user&.credit_card != nil
      self.credit_card = self.user.credit_card
    end
  end
end