class TermsController < ApplicationController
  before_action :set_term, only: %i[show edit update destroy]

  def index
    @terms = Term.all
  end

  def show; end

  def new 
    @term = Term.new
  end

  def create
    @term = Term.new(term_params)
    if @term.save
      redirect_to @term, notice: 'Term created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @term.update(term_params)
      redirect_to @term, notice: 'Term updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @term.destroy
    redirect_to terms_path, notice: 'Term deleted successfully.'
  end

  private

  def set_term
    @term = Term.find(params[:id])
  end

  def term_params
    params.require(:term).permit(:name)
  end
end
