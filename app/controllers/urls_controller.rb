class UrlsController < ApplicationController
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  before_action :set_url, only: [:show, :edit, :update, :destroy]

  # GET /urls
  # GET /urls.json
  def index
    @url = Url.new
    @urls = Url.recent.page(params[:page]).per(25)
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # GET /urls/1/edit
  def edit
  end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(url_params)
    @url = Url.get_from_long(@url.long) if @url.duplicate?

    respond_to do |format|
      if not @url.new_record?
        format.html { redirect_to root_path, notice: 'URL already existed.' }
        format.json { render action: 'show', status: :ok, location: @url }
      elsif @url.save
        format.html { redirect_to root_path, notice: 'Url was successfully created.' }
        format.json { render action: 'show', status: :created, location: @url }
      else
        format.html do
          @urls = Url.recent.page(params[:page]).per(25)
          render action: 'index'
        end
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to @url, notice: 'Url was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url }
      format.json { head :no_content }
    end
  end

  # GET /urls/abcABC123
  def goto
    @url = Url.get_from_short(params[:short])
    if @url
      redirect_to @url.long, status: 301
    else
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.get_from_short(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:long)
    end
end