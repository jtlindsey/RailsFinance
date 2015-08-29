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
  end

  # GET /transactions/1/edit
  def edit
    @account = current_user.accounts.find(params[:account_id])
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.json
  def create
    #refactor to seperate transfer_controller?
    @account = current_user.accounts.find(params[:account_id])
    @transaction = @account.transactions.build(transaction_params)

    if transaction_params[:transaction_type] == "Transfer"

      actual_transaction_date = DateTime.new(
                                  transaction_params["date(1i)"].to_i,
                                  transaction_params["date(2i)"].to_i,
                                  transaction_params["date(3i)"].to_i,
                                  transaction_params["date(4i)"].to_i,
                                  transaction_params["date(5i)"].to_i,
                                  transaction_params["date(6i)"].to_i
                                  )

      withdrawal, deposit = Transaction.transfer(
                              transaction_params[:amount], 
                              actual_transaction_date,
                              transaction_params[:from_account_id],
                              transaction_params[:to_account_id],
                              transaction_params[:comment], 
                              transaction_params[:category],
                              transaction_params[:payee]
                              )

      deposit.transfer_ref = withdrawal.id

      if deposit.save
        redirect_to account_transactions_path(withdrawal.account, withdrawal), notice: 'Transaction was successfully created.' 
      else
        @transaction = deposit
        render :new
      end



    elsif transaction_params[:transaction_type] == "Payment"
      actual_transaction_date = DateTime.new(
                                  transaction_params["date(1i)"].to_i,
                                  transaction_params["date(2i)"].to_i,
                                  transaction_params["date(3i)"].to_i,
                                  transaction_params["date(4i)"].to_i,
                                  transaction_params["date(5i)"].to_i,
                                  transaction_params["date(6i)"].to_i
                                  )

      withdrawal, withdrawal_to = Transaction.payment(
                                    transaction_params[:amount], 
                                    actual_transaction_date,
                                    transaction_params[:from_account_id],
                                    transaction_params[:to_account_id],
                                    transaction_params[:comment], 
                                    transaction_params[:category],
                                    transaction_params[:payee],
                                    transaction_params[:interest_payment],
                                    transaction_params[:principal_payment],
                                    transaction_params[:payment_amount],
                                    transaction_params[:transfer_ref]
                                    )

      withdrawal_to.transfer_ref = withdrawal.id

      if withdrawal_to.save
        redirect_to account_transactions_path(withdrawal.account, withdrawal), notice: 'Transaction was successfully created.' 
      else
        @transaction = withdrawal_to
        render :new
      end



    else
      if @transaction.save
        redirect_to account_transactions_path(@account, @transaction), notice: 'Transaction was successfully created.'  
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
        :payment_amount,
        :transfer_ref,
        :check_number
      )
    end

end
