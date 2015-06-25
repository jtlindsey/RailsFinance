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
    @account_transfer_list = Account.order('LOWER(name)').where.not(id: @account.id).map do |account| 
      "#{account.name} #{account.last4} $#{account.balance} #{account.type}"
    end   
  end

  # GET /transactions/1/edit
  def edit
    @account = Account.find(params[:account_id])
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @account = Account.find(params[:account_id])
    @transaction = @account.transactions.build(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to account_transaction_path(@account, @transaction), notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: account_transaction_path(@transaction) }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
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
    @transaction.destroy
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
      params.require(:transaction).permit(:transaction_type, :date, :payee, :category, :comment, :amount, :account_id)
    end
end
