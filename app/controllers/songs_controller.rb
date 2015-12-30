class SongsController < ApplicationController
  before_filter :authorize
  include MarkingFavorites

  def model
    validate_parameters { return }
    @song
  end

  # GET /records/1/songs/1
  # GET /records/1/songs/1.json
  def show
    validate_parameters { return }
  end

  # GET /records/1/songs/new
  def new
    @song = Song.new(record_id: params[:record_id])
  end

  # GET /records/1/songs/1/edit
  def edit
    validate_parameters { return }
  end

  # POST /records/1/songs
  # POST /records/1/songs.json
  def create
    @song = Song.new(song_params)

    begin
      respond_to do |format|
        if @song.save
          format.html { redirect_to @song.record, notice: 'Song was successfully created.' }
          format.json { render :show, status: :created }
        else
          format.html { render :new }
          format.json { render json: @song.errors, status: :unprocessable_entity }
        end
      end
    rescue ActiveRecord::RecordNotUnique
      @song.errors[:title] << "not unique for record"
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1/songs/1
  # PATCH/PUT /records/1/songs/1.json
  def update
    validate_parameters { return }
    begin
      respond_to do |format|
        if @song.update(song_params)
          format.html { redirect_to [@song.record, @song], notice: 'Song was successfully updated.' }
          format.json { render :show, status: :ok, location: @song }
        else
          format.html { render :edit }
          format.json { render json: @song.errors, status: :unprocessable_entity }
        end
      end
    rescue ActiveRecord::RecordNotUnique
      @song.errors[:title] << "not unique for record"
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1/songs/1
  # DELETE /records/1/songs/1.json
  def destroy
    validate_parameters { return }
    binding.pry
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:title, :ordinal).tap do |p|
        p[:record_id] = params[:record_id].to_i
      end
    end

    def validate_parameters
      @song = Song.find(params[:id])
      if @song.record_id != params[:record_id].to_i
        render_bad_request { yield }
      end
    rescue ActiveRecord::RecordNotFound
      if json_request?
        render_bad_request { yield }
      end
    end
end
