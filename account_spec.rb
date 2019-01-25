require "rspec"

require_relative "account"


describe Account do  
  let(:acct_number) { "1234567898" }
  let(:starting_balance) { 100 }
  let(:account) { Account.new(acct_number, starting_balance)}
  let(:transactions) { [starting_balance] }
  
  describe "#initialize" do
    it 'should initialize with a correct type' do
      expect(account).to be_kind_of(Account)
    end

    it "throw error when no argument" do 
      expect{ Account.new() }.to raise_error(ArgumentError)
    end

    it "throw an error when back account is less than 10" do 
      expect{ Account.new("12345") }.to raise_error(InvalidAccountNumberError)
    end
  end

  describe "#transactions" do
    it "should have the same transactions" do 
      expect(account.transactions).to eq(transactions)
    end
  end

  describe "#balance" do
    it "to check the balance of the bank account" do 
      expect(account.balance).to eq(starting_balance)
    end
  end

  describe "#account_number" do
    it "to show only the a few digit of the account number" do 
      expect(account.acct_number).to_not eq(acct_number)
    end
  end

  describe "deposit!" do
    it "to check the balance of the account after deposit" do 
      expect{ account.deposit!(-12) }.to raise_error(NegativeDepositError)
    end
  end

  describe "#withdraw!" do
    it "check the balance of the account after withdrawal" do 
      expect{ account.withdraw!(50) }.to change(account, :balance).from(100).to(50)
    end

    it "tries to withdraw more than the balance" do 
      expect{ account.withdraw!(101) }.to raise_error(OverdraftError)
    end
  end
end