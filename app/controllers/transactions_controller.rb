class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @account = Account.find(params[:account_id])
    @transactions = Transaction.order(date: :desc).where(:account_id => params[:account_id])
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @account = Account.find(params[:account_id])
    @transaction = @account.transactions.build

    #move to model and view
    #list all accounts except current for account transfer
    @account_transfer_list = Account.order('LOWER(name)').where.not(id: @account.id, status: 'Closed')  
  end

  # GET /transactions/1/edit
  def edit
    @account = Account.find(params[:account_id])
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.json
  def create
    #refactor to seperate transfer_controller
    if transaction_params[:transaction_type] == "Transfer"
                  # helper method in application controller (date_part_to_date)
      ocurred_on = date_part_to_date(
                                    transaction_params["date(1i)"],
                                    transaction_params["date(2i)"],
                                    transaction_params["date(3i)"]
                                    )
      withdrawal = Transaction.transfer(
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
      a = Transaction.where(transaction_type: 'Deposit').last
      a.transfer_ref = withdrawal.id
      a.save
      # refactor this. end

      redirect_to account_transaction_path(withdrawal.account, withdrawal), notice: 'Transaction was successfully created.' 
      # probably should be a new route ie..
      #redirect_to account_transfers_path(withdrawl.account, withdrawl), notice: 'Transaction was successfully created.'

    else
      @account = Account.find(params[:account_id])
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
    @account = Account.find(params[:account_id])
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
    @account = Account.find(params[:account_id])
    @transaction = Transaction.find(params[:id])

    #byebug
    #destroy corresponding transactions
    if @transaction.transfer_ref != nil
      linked_transaction = Transaction.find_by(id: @transaction.transfer_ref)
      linked_transaction.destroy
      @transaction.destroy
    else
      @transaction.destroy
    end 
    #end destroy corresponding transactions

    respond_to do |format|
      format.html { redirect_to account_transactions_path(@account, @transaction), notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
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
        :to_account_id
        #:transfer_ref
      )
    end

end
