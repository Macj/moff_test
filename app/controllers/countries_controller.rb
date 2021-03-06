class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]

  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.all
    @collected = {}
    @not_collected = {}
    @countries.each do |c|
      @collected[c.id] = c.currencies.count#CountriesCurrencies.collected_in(c.id)
      @not_collected[c.id] = CountriesCurrencies.not_collected_in(c.id)
    end
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
  end

  # GET /countries/new
  def new
    @country = Country.new
  end

  # GET /countries/1/edit
  def edit
  end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.new(country_params)

    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'Country was successfully created.' }
        format.json { render action: 'show', status: :created, location: @country }
      else
        format.html { render action: 'new' }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /countries/1
  # PATCH/PUT /countries/1.json
  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to @country, notice: 'Country was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_url }
      format.json { head :no_content }
    end
  end

  def set_visited
    countries = params[:countries]
    currency = Currency.find( params[:currency] )
    # clear visits
    visits = CountriesCurrencies.find_all_by_currency_id(currency.id)
    visits.each do |v|
      v.visited = false
      v.save
    end

    # setup new visited countries
    if countries
      countries.each do |pair|
        if pair[1] == 'on'
          country = currency.countries.find(pair[0])
          visited = CountriesCurrencies.find_by_country_id_and_currency_id(country.id,  currency.id)
          visited.visited = true
          visited.collected = true
          visited.save
        end
        #currency.update_attribute(:collected, true)
      end
    end

    redirect_to currencies_path
  end

  def visit
    country = Country.find(params[:id])
    # setup visits
    visits = CountriesCurrencies.find_all_by_country_id(country.id)
    visits.each do |v|
      v.collected = true
      v.visited = true
      v.save
    end
    redirect_to countries_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_params
      params.require(:country).permit(:name, :vesited)
    end
end
