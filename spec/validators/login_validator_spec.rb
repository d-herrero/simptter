describe LoginValidator do
  before(:all) do
    class Validatable
      include ActiveModel::Validations
      attr_accessor  :field
      validates :field, login: true
    end
  end

  after(:all) do
    Object.send(:remove_const, :Validatable)
  end

  let(:obj) { Validatable.new }

  it 'has a valid login (max 16 regular and lower case characters)' do
    obj.field = generate(:login)

    expect(obj).to be_valid
  end

  it 'has an invalid login' do
    obj.field = 'ÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ'

    expect(obj).to be_invalid
  end
end