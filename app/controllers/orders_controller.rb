class OrdersController < ApplicationController
  before_filter :require_user
  before_filter :assign_menu
  before_filter :protect_locked_menu, :only => [:create, :update, :destroy]

  def show
    @order = current_user.orders.find_or_initialize_by_menu_id @menu.id
    render :action => :new unless @menu.locked?
  end

  def create
    @order = current_user.orders.new params[:order]
    @order.menu = @menu

    if @order.save
      flash[:notice] = 'Ваш заказ принят.'
      redirect_to :action => :show
    else
      render :action => :new
    end
  end

  def update
    @order = current_user.orders.find_by_menu_id @menu.id

    if @order.update_attributes(params[:order])
      flash[:notice] = 'Ваш заказ обновлен.'
      redirect_to :action => :show
    else
      render :action => :new
    end
  end

  def destroy
    @order = current_user.orders.find_by_menu_id @menu.id
    @order.destroy
    flash[:notice] = "Заказ на \"#{@menu}\" отменен успешно."
    redirect_to :back
  end

  private

  def assign_menu
    params[:date] = Time.now.to_date.to_s(:db) if params[:date] == 'today'
    scope = is_admin? ? Menu : Menu.published
    @menu = scope.find_by_date params[:date]
    render :action => :no_menu unless @menu
  end

  def protect_locked_menu
    flash[:error] = 'Извините, но меню уже заблокировано.' and redirect_to(:action => :show) if @menu.locked?
  end
end

