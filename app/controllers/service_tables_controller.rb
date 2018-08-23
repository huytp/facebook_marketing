class ServiceTablesController < ApplicationController
  before_action :set_service_table, only: [:show, :edit, :update, :destroy]

  # GET /service_tables
  # GET /service_tables.json
  def index
    @service_tables = ServiceTable.all
  end

  # GET /service_tables/1
  # GET /service_tables/1.json
  def show
  end

  # GET /service_tables/new
  def new
    @service_table = ServiceTable.new
  end

  # GET /service_tables/1/edit
  def edit
  end

  # POST /service_tables
  # POST /service_tables.json
  def create
    @service_table = ServiceTable.new(service_table_params)

    respond_to do |format|
      if @service_table.save
        format.html { redirect_to service_tables_path, notice: 'Gói dịch vụ mới được tạo!' }
        format.json { render :show, status: :created, location: @service_table }
      else
        format.html { render :new }
        format.json { render json: @service_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_tables/1
  # PATCH/PUT /service_tables/1.json
  def update
    respond_to do |format|
      if @service_table.update(service_table_params)
        format.html { redirect_to service_tables_path, notice: 'Đã cập nhật thành công!' }
        format.json { render :show, status: :ok, location: @service_table }
      else
        format.html { render :edit }
        format.json { render json: @service_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_tables/1
  # DELETE /service_tables/1.json
  def destroy
    @service_table.destroy
    respond_to do |format|
      format.html { redirect_to service_tables_url, notice: 'Đã xóa thành công!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_table
      @service_table = ServiceTable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_table_params
      params.require(:service_table).permit(:price, :day_of_use)
    end
end
