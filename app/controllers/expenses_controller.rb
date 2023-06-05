class ExpensesController < ApplicationController
  def index
    @expenses = Expense.where(groups_id: params[:group_id]).order(created_at: :desc)
    @group = Group.where(id: params[:group_id]).take
  end

  def new; end

  def create
    @expense = current_user.expenses.new(expense_params)
    if @expense.save
      redirect_to group_expenses_path(group_id: expense_params[:groups_id]), notice: 'Expense created successfully'
    else
      redirect_to new_group_expense_path, alert: 'Oops something went wrong'
    end
  end

  private

  def expense_params
    params.required(:expense).permit(:name, :amount, :groups_id)
  end
end
