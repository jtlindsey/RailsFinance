class TransactionsController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @account = current_user.accounts.find(params[:account_id])
    @transactions = @account.transactions.order(date: :desc)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @account = current_user.accounts.find(params[:account_id])
    @transaction = @account.transactions.build
# byebug
    #move to model and view
    #list all accounts except current for account transfer
    # @account_transfer_list = current_user.accounts.order('LOWER(name)').where.not(id: @account.id, status: 'Closed') 
    @asset_account_transfer_list = current_user.accounts.where(type: Asset.types.values).where.not(id: @account.id, status: 'Closed').order('LOWER(name)')
    @liability_account_payment_list = current_user.accounts.where(type: Liability.types.values).where.not(id: @account.id, status: 'Closed').order('LOWER(name)')
  end

  # GET /transactions/1/edit
  def edit
    @account = current_user.accounts.find(params[:account_id])
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.json
  def create
    #refactor to seperate transfer_controller
    if transaction_params[:transaction_type] == "Transfer"

      ocurred_on = DateTime.new(
                          transaction_params["date(1i)"].to_i,
                          transaction_params["date(2i)"].to_i,
                          transaction_params["date(3i)"].to_i,
                          transaction_params["date(4i)"].to_i,
                          transaction_params["date(5i)"].to_i,
                          transaction_params["date(6i)"].to_i
                          )

      withdrawal, deposit = Transaction.transfer(
                                      transaction_params[:amount], 
                                      ocurred_on,
                                      transaction_params[:from_account_id],
                                      transaction_params[:to_account_id],
                                      transaction_params[:comment], 
                                      transaction_params[:category],
                                      transaction_params[:payee]
                                      )#withdrawl misspelling to look out for
      #byebug
      # refactor this. not sure if could be problem during simultaneous transactions
      #finds last deposit transaction and links it to withdrawal transaction via transfer_ref

      redirect_to account_transaction_path(withdrawal.account, withdrawal), notice: 'Transaction was successfully created.' 
      # probably should be a new route ie..
      #redirect_to account_transfers_path(withdrawl.account, withdrawl), notice: 'Transaction was successfully created.'
    
    elsif transaction_params[:transaction_type] == "Payment"
      ocurred_on = DateTime.new(
                                transaction_params["date(1i)"].to_i,
                                transaction_params["date(2i)"].to_i,
                                transaction_params["date(3i)"].to_i,
                                transaction_params["date(4i)"].to_i,
                                transaction_params["date(5i)"].to_i,
                                transaction_params["date(6i)"].to_i
                                )

      withdrawal, withdrawal_two = Transaction.payment(
                                      transaction_params[:amount], 
                                      ocurred_on,
                                      transaction_params[:from_account_id],
                                      transaction_params[:to_account_id],
                                      transaction_params[:comment], 
                                      transaction_params[:category],
                                      transaction_params[:payee],

                                      transaction_params[:interest_payment],
                                      transaction_params[:principal_payment],
                                      transaction_params[:payment_amount]
                                      )

      redirect_to account_transaction_path(withdrawal.account, withdrawal), notice: 'Transaction was successfully created.' 

    else
      @account = current_user.accounts.find(params[:account_id])
      @transaction = @account.transactions.build(transaction_params)
      if @transaction.save
        redirect_to account_transaction_path(@account, @transaction), notice: 'Transaction was successfully created.'  
      else
        render :new
      end
    end    
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    @account = current_user.accounts.find(params[:account_id])
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to account_transaction_path(@account, @transaction), notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: account_transaction_path(@account, @transaction) }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @account = current_user.accounts.find(params[:account_id])
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    #byebug

    respond_to do |format|
      format.html { redirect_to account_transactions_path(@account, @transaction), notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @account = current_user.accounts.find(params[:account_id])
      @transaction = @account.transactions.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(
        :transaction_type, 
        :date, 
        :payee, 
        :category, 
        :comment, 
        :amount, 
        :from_account_id, 
        :to_account_id,
        :interest_payment,
        :principal_payment,
        :payment_amount
      )
    end

end
