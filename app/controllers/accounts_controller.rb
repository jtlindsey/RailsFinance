class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]


  def financial_summary
    @accounts = current_user.accounts
    @assets_list = current_user.accounts.order('LOWER(name)').where(type: Asset.types.values)
    @liabilities_list = current_user.accounts.order('LOWER(name)').where(type: Liability.types.values)

    @assets_total = 0
    @assets_list.each {|asset| @assets_total += asset.balance }

    @liabilities_total = 0
    @liabilities_list.each {|liability| @liabilities_total += liability.balance }

  end

  # GET /accounts
  # GET /accounts.json
  def index
    @favorite_accounts = current_user.accounts.order('LOWER(name)').where(status: 'Open').where(favorite: true)
    @budget_watching = BudgetItem.watch_items(current_user)

    # @testing = Gchart.pie_3d(:title => 'ruby_fu', :size => '400x200',
              # :data => [10, 45, 45], :labels => ["DHH", "Rob", "Matt"] )

    @accounts = current_user.accounts

    # Budget message...move to model
    if current_user.budget_items.count >= 1 && current_user.budget_items.where(watch: true).count < 1
      @budget_tracking_message = "Click Here to add Budget Items to Watch List." 
    elsif current_user.budget_items.count < 1
      @budget_tracking_message = "Click Here To Create a Budget."
    end
    # END Budget message...move to model
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = current_user.accounts.build
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = current_user.accounts.build(account_params)

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
    # @accounts = Account.all
    @assets_list = Account.order(:type).order('LOWER(name)').where(type: Asset.types.values, user_id: current_user.id)

    @assets_total = 0
    @assets_list.each {|asset| @assets_total += asset.balance }
  end

  def options    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = current_user.accounts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      account_params = params.require(:account)
      account_params.permit(:type, :name, :last4, :status, :balance, :credit_limit, :interest_rate, :favorite, )
    end
end
