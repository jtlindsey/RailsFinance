class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  def index
    # @account = current_user.accounts.find(params[:account_id])
    # @transactions = @account.transactions.order(date: :desc)
    # @documents = Document.where(:transaction_id => params[:transaction_id])
  end

  def show
  end

  def new
    @transaction = Transaction.find(params[:transaction_id])
    @document = @transaction.documents.build
    @documents_list = Document.where(:transaction_id => params[:transaction_id])
  end

  def edit
    # @transaction = Transaction.find(params[:transaction_id])
    # @document = Document.find(params[:id])
  end

  def create
    @account = current_user.accounts.find(params[:account_id])
    @transaction = Transaction.find(params[:transaction_id])
    @document = @transaction.documents.build(document_params)
    @document.user_id = current_user.id
    
    respond_to do |format|
      if @document.save
        format.html { redirect_to account_transaction_path(@account, @transaction), notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: account_transaction_document_path(@document) }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   @transaction = Transaction.find(params[:transaction_id])

  #   respond_to do |format|
  #     if @document.update(document_params)
  #       format.html { redirect_to account_transaction_document_path(@transaction, @document), notice: 'Document was successfully updated.' }
  #       format.json { render :show, status: :ok, location: account_transaction_document_path(@document) }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @document.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    @account = current_user.accounts.find(params[:account_id])
    @transaction = Transaction.find(params[:transaction_id])

    @document.destroy
    respond_to do |format|
      format.html { redirect_to account_transaction_path(@account, @transaction), notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:efile, :efile_cache, :transaction_id)
    end
end