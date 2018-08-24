class SharesController < ApplicationController
  def show
    @contract = Contract.find_by!(share_token: params[:id])
  end

  def update
    @contract = Contract.find_by!(share_token: params[:id])
    if @contract.update(contract_params)
      render :show, status: :ok, location: @contract
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  private

  def contract_params
    params.require(:contract).permit(:signature, :signer_name)
  end
end
