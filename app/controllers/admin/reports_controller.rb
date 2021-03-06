class Admin::ReportsController < Admin::BaseController
  def provider
    @menu = current_user.menus.find_by_date(params[:id])
    @report = ::Report::ProviderReport.new(@menu)
  end
end

