require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:height) }
  it { should validate_presence_of(:weight) }
  it { should validate_presence_of(:width) }
  it { should validate_presence_of(:length) }
end
