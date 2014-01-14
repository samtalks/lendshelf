require 'spec_helper'

describe User do
  context 'doing things' do
    it 'can be requested by other users' do
      james = User.create(name: "James")
      james.ask(@item)
      @josh.lend(@item)
      expect(james.borrowed_items).to include(@item)
    end

    it 'can be returned to its owner' do
      james = User.create(name: "James")
      james.ask(@item)
      @josh.lend(@item)
      expect(james.borrowed_items).to include(@item)
    end
  end
end
