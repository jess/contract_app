class ContractsController < ProtectedController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = policy_scope(Contract)
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
  end

  # GET /contracts/new
  def new
    if params[:contract_id].present?
      dup_contract = Contract.find params[:contract_id]
      authorize dup_contract, :manage?
      @contract = dup_contract.dup
      @contract.save
      @contract.users << current_user
    else
      authorize Contract, :new?
      @contract = Contract.create(name: "New name...", users: [current_user])
    end
    redirect_to @contract
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)
    authorize @contract

    respond_to do |format|
      if @contract.save
        @contract.users << current_user
        format.html { redirect_to @contract, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
      authorize @contract, :manage?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      load_params = params.require(:contract).permit(:content, :name, :is_sharing)
      load_params[:custom_fields] = params[:contract][:custom_fields] if params[:contract][:custom_fields].present?
      load_params.permit!
    end
end
