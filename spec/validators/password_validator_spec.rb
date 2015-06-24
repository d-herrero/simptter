describe PasswordValidator do
  before(:all) do
    class Validatable
      include ActiveModel::Validations
      attr_accessor  :field
      validates :field, password: true
    end
  end

  after(:all) do
    Object.send(:remove_const, :Validatable)
  end

  let(:obj) { Validatable.new }

  it 'with a valid password (6-32 regular characters including at least one capital letter, one lower case and one number)' do
    obj.field = generate(:password)

    expect(obj).to be_valid
  end

  it 'with an invalid password' do
    obj.field = 'abc'

    expect(obj).to be_invalid
  end
end