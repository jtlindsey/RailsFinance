class CheckingAccountsController < ApplicationController
  before_action :set_checking_account, only: [:show, :edit, :update, :destroy]

  # GET /checking_accounts
  # GET /checking_accounts.json
  def index
    @checking_accounts = CheckingAccount.all
  end

  # GET /checking_accounts/1
  # GET /checking_accounts/1.json
  def show
  end

  # GET /checking_accounts/new
  def new
    @checking_account = CheckingAccount.new
  end

  # GET /checking_accounts/1/edit
  def edit
  end

  # POST /checking_accounts
  # POST /checking_accounts.json
  def create
    @checking_account = CheckingAccount.new(checking_account_params)

    respond_to do |format|
      if @checking_account.save
        format.html { redirect_to @checking_account, notice: 'Checking account was successfully created.' }
        format.json { render :show, status: :created, location: @checking_account }
      else
        format.html { render :new }
        format.json { render json: @checking_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checking_accounts/1
  # PATCH/PUT /checking_accounts/1.json
  def update
    respond_to do |format|
      if @checking_account.update(checking_account_params)
        format.html { redirect_to @checking_account, notice: 'Checking account was successfully updated.' }
        format.json { render :show, status: :ok, location: @checking_account }
      else
        format.html { render :edit }
        format.json { render json: @checking_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checking_accounts/1
  # DELETE /checking_accounts/1.json
  def destroy
    @checking_account.destroy
    respond_to do |format|
      format.html { redirect_to checking_accounts_url, notice: 'Checking account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checking_account
      @checking_account = CheckingAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checking_account_params
      params.require(:checking_account).permit(:name, :last4, :status, :balance)
    end
end
