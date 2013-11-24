class CurrenciesController < ApplicationController
  before_action :set_currency, only: [:show, :edit, :update, :destroy]

  # GET /currencies
  # GET /currencies.json
  def index
    @visited = {}
    @not_visited = {}
    @unfinished = params[:unfinished]
    if @unfinished
      @currencies = Currency.unfinished
    else
      @currencies = Currency.all
    end
    @currencies.each do |c|
      @visited[c.id] =  c.countries.count #CountriesCurrencies.visited_for(c.id)
      @not_visited[c.id] = CountriesCurrencies.not_visited_for(c.id)
    end
  end

  # GET /currencies/1
  # GET /currencies/1.json
  def show

  end

  # GET /currencies/new
  def new
    @currency = Currency.new
  end

  # GET /currencies/1/edit
  def edit
  end

  # POST /currencies
  # POST /currencies.json
  def create
    @currency = Currency.new(currency_params)

    respond_to do |format|
      if @currency.save
        format.html { redirect_to @currency, notice: 'Currency was successfully created.' }
        format.json { render action: 'show', status: :created, location: @currency }
      else
        format.html { render action: 'new' }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /currencies/1
  # PATCH/PUT /currencies/1.json
  def update
    respond_to do |format|
      if @currency.update(currency_params)
        format.html { redirect_to @currency, notice: 'Currency was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currencies/1
  # DELETE /currencies/1.json
  def destroy
    @currency.destroy
    respond_to do |format|
      format.html { redirect_to currencies_url }
      format.json { head :no_content }
    end
  end

  def set_collected
    country = Country.find(params[:country])
    currencies =  params[:currencies]
    # clear visits
    visits = CountriesCurrencies.find_all_by_country_id(country.id)
    visits.each do |v|
      v.collected = false
      v.save
    end
    
    # setup new visited countries
    if currencies
      currencies.each do |pair|
        if pair[1] == 'on'
          currency = country.currencies.find(pair[0])
          visited = CountriesCurrencies.find_by_country_id_and_currency_id(country.id,  currency.id)
          visited.collected = true
          visited.visited = true
          visited.save
        end
      end
    end

    redirect_to currencies_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency
      @currency = Currency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def currency_params
      params.require(:currency).permit(:name)
    end
end
