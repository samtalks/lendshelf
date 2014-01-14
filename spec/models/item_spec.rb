require 'spec_helper'

describe Item do
  context "accessing attributes" do
    it "should have a name, url, and description" do
      item = Item.create(name:"PS2", url: "sony.com", description: "a very very old system")

      expect(item.name).to eq("PS2")
      expect(item.url).to eq("sony.com")
      expect(item.description).to eq("a very very old system")
    end
  end

  
  context "testing relations" do
    before do
      @owner = User.create(name: "Josh")
      @item = @owner.items.create(name: "PS4")
    end

    it 'is properly associated with its owner' do
      expect(@item.user).to eq(@owner)
    end

    it 'can be borrowed by another user' do
      borrower = User.new
      loan = Loan.create(item: @item, user: borrower)
      expect(@item.borrowers.first).to eq(borrower)
    end


  end

  # let(:item) {Item.create(name:"RAILS 4 WaY", description:"A very good book?", url: "www.hi.com")}
  # context "Loading from Active Record DB" do

  #   it "lets you find an item by its name" do
  #     item
  #     .find_by(name: "RAILS 4 WaY")
  #   end

  # end

  context 'states' do 
    it 'should mark when it has been requested'
    it 'should mark when it is loaned out'
    it 'should mark when it is returned'
    it 'should mark when it has been archived'
  end

  context 'testing tags' do
  end
end

# describe Vehicle do

#   before :each do
#     @vehicle = Factory(:vehicle)
#   end

#   describe 'states' do
#     describe ':parked' do
#       it 'should be an initial state' do
#         # Check for @vehicle.parked? to be true
#         @vehicle.should be_parked
#       end

#       it 'should change to :idling on :ignite' do
#         @vehicle.ignite!
#         @vehicle.should be_idling
#       end

#       ['shift_up!', 'shift_down!'].each do |action|
#         it "should raise an error for #{action}" do
#           lambda {@job_offer.send(action)}.should raise_error
#         end
#       end
#     end
#   end
# end
