describe EmailValidator do
  before(:all) do
    class Validatable
      include ActiveModel::Validations
      attr_accessor  :field
      validates :field, email: true
    end
  end

  after(:all) do
    Object.send(:remove_const, :Validatable)
  end

  let(:obj) { Validatable.new }

  it 'has a valid email' do
    obj.field = generate(:email)

    expect(obj).to be_valid
  end

  it 'has an invalid email' do
    obj.field = 'abc'

    expect(obj).to be_invalid
  end
end