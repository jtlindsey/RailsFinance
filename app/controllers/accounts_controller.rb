class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]


  def financial_summary
    @accounts = Account.all
    @assets_list = Account.order('LOWER(name)').where(type: Asset.types.values)
    @liabilities_list = Account.order('LOWER(name)').where(type: Liability.types.values)

    @assets_total = 0
    @assets_list.each {|asset| @assets_total += asset.balance }

    @liabilities_total = 0
    @liabilities_list.each {|liability| @liabilities_total += liability.balance }
    
  end
  # GET /accounts
  # GET /accounts.json
  def index
    # Assets
    @checkings = Account.order('LOWER(name)').where(type: 'Checking')
    @savings = Account.order('LOWER(name)').where(type: 'Saving')
    @escrows = Account.order('LOWER(name)').where(type: 'Escrow')
    @cashs = Account.order('LOWER(name)').where(type: 'Cash')
    @other_assets = Account.order('LOWER(name)').where(type: 'OtherAsset')

    # Liabilities
    @credit_cards = Account.order('LOWER(name)').where(type: 'CreditCard')
    @other_liabilitys = Account.order('LOWER(name)').where(type: 'OtherLiability')
    @student_loans = Account.order('LOWER(name)').where(type: 'StudentLoan')
    @personal_loans = Account.order('LOWER(name)').where(type: 'PersonalLoan')
    @mortgage = Account.order('LOWER(name)').where(type: 'Mortgage')

    #Account.pluck('distinct type')
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to account_path(@account), notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to account_path(@account), notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    account = Account.find(params[:id])

    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def list
    @accounts = Account.all
    @assets_list = Account.order('LOWER(name)').where(type: Asset.types.values)
    @liabilities_list = Account.order('LOWER(name)').where(type: Liability.types.values)

    @assets_total = 0
    @assets_list.each {|asset| @assets_total += asset.balance }

    @liabilities_total = 0
    @liabilities_list.each {|liability| @liabilities_total += liability.balance }
  end

  def options
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      account_params = params.require(:account)
      account_params.permit(:type, :name, :last4, :status, :balance)
    end
end
