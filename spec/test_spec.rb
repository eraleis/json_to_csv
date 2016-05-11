require 'json'
require_relative '../json2csv/lib/parser'

RSpec.describe Parser do
  let(:json) { JSON.parse(IO.read('fixtures/users.json')) }
  subject { Parser.new(json[0]) }

  describe '#initialize' do
    context "when trying to Initialize with a valid hash" do
      it 'should be an instance of Parser' do
        parser = Parser.new(json)
        expect(parser).to be_an_instance_of(Parser)
      end
    end

    context "when trying to Initialize with an invalid argument" do
      it 'should raise NoMethodError' do
        expect{Parser.new('test')}.to raise_error(NoMethodError)
        expect{Parser.new(21)}.to raise_error(NoMethodError)
      end
    end
  end

  describe '#get_keys' do
    context "when trying to get the keys with a valid json" do
      it 'should return an array' do
        keys = subject.get_keys
        expect(keys).to be_an(Array)
      end

      it 'should return all the keys' do
        keys = subject.get_keys
        expect(keys).to eq(["id", "email", "tags", "profiles.facebook.id", "profiles.facebook.picture", "profiles.twitter.id", "profiles.twitter.picture"])
      end
    end
  end

  describe '#get_values' do
    context 'when getting values of an hash' do
      it 'should return an Array of values' do
        values = subject.get_values

        expect(values).to be_an(Array)
      end

      it 'should group the values with the same key' do
        values = subject.get_values

        expect(values).to eq(["0", "colleengriffith@quintity.com", "consectetur,quis", "0", "//fbcdn.com/a2244bc1-b10c-4d91-9ce8-184337c6b898.jpg", "0", "//twcdn.com/ad9e8cd3-3133-423e-8bbf-0602e4048c22.jpg"])
      end
    end
  end


end
