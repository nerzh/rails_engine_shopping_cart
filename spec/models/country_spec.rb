require 'rails_helper'

describe ShoppingCart::Country, type: :model do



  it {is_expected.to have_one :shipping_address}
end