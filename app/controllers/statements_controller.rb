
class StatementsController < ApplicationController
  def index
    @statements = Statement.all
  end

  def show
    @statement = Statement.find(params[:id])
  end

  def new
    @statement = Statement.new
  end

  def create
    puts params.inspect
    puts "----------------"
    puts statement_params.inspect
    @statement = Statement.new(statement_params)
    if @statement.save
      redirect_to @statement, notice: 'Statement created successfully'
    else
      puts @statement.errors.full_messages
      # render json: { success: false, errors: @statement.errors.full_messages }, 
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @statement = Statement.find(params[:id])
  end
  def update
    @statement = Statement.find(params[:id])

    if @statement.update(statement_params)
      redirect_to @statement
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @statement = Statement.find(params[:id])
    @statement.destroy

    redirect_to statements_path, status: :see_other
  end

  private

  def statement_params
    params.require(:statement).permit(:title)
  end
  
end