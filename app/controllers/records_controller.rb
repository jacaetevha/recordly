class RecordsController < ApplicationController
  before_filter :authorize
  include MarkingFavorites

  def model
    set_record { return }
    @record
  end

  # GET /records
  # GET /records.json
  def index
    @records = current_user.
      records.
      order(:ordinal_letter, :title).
      includes(:artists).
      page(params[:page]).
      per(params[:per_page] || 5)
    respond_to do |format|
      format.html {}
      format.json {}
      format.js do
        render partial: 'records/records_list', formats: ['html'], handlers: ['erb'], layout: false
      end
    end
  end

  # GET /records/1
  # GET /records/1.json
  def show
    set_record { return }
  end

  # GET /records/new
  def new
    @record = Record.new
    if params[:artist_ids]
      @record.artist_ids = Array(params[:artist_ids].map &:to_i)
    end
  end

  # GET /records/1/edit
  def edit
    set_record { return }
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.json { render :show, status: :created, location: @record }
      else
        format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    set_record { return }
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    set_record { return }
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_url, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render nothing: true }
    end
  end

  private
    def set_record
      @record = Record.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      if json_request?
        render_bad_request { yield }
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:title, artist_ids: [])
    end
end
