class ProductsController < ApplicationController
  # Use before_action to set up an instance variable for an action, 
  # in this case, call set_product before calling show, edit, update and destroy
  # before_action :set_product, only: [:edit, :update, :show, :destroy]
  before_action :set_product, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction


# run 'rails routes' then add '_path' to the Prefix to get the url


#       Prefix Verb   URI Pattern                   Controller#Action
# ----------------------------------------------------------------
#     products GET    /products(.:format)           products#index
#              POST   /products(.:format)           products#create
#  new_product GET    /products/new(.:format)       products#new
# edit_product GET    /products/:id/edit(.:format)  products#edit
#      product GET    /products/:id(.:format)       products#show
#              PATCH  /products/:id(.:format)       products#update
#              PUT    /products/:id(.:format)       products#update
#              DELETE /products/:id(.:format)       products#destroy

# The purpose of the controller is to manage the incoming request and session

# GET '/'
  def index
    # Product.where accesses model layer and stores result in an instance variable
    # which is passed to the view, in this case it is all the products created by current user
    products = Product.where("user_id = ?", current_user)
    @products = products.order("#{sort_column} #{sort_direction}")

    # render 'products/index' happens by default at end of method
  end

  # GET '/products/new'
  def new
    # set up a new instance variable which is an active record object
    # and pass it to the 'new' template in "new.html.erb" 
    @product = Product.new
    # render 'products/new' happens by default at end of method
  end

  # GET '/products/:id/edit'
  def edit # url will be something like /products/3/edit, edit form will be rendered
    # @product = Product.find(params[:id])... this is now done by set_product
    # render 'products/edit by default
  end

  # POST '/product'
  # the general pattern used in the action create that handles
  # submission of model-backed forms 
  def create 
  # the form displayed in "new.html.erb" is submitted to action='/products' 
  # using verb method="post" which is routed to products#create.
  # @product, is populated with values (params) submitted from the form
    @product = Product.new(product_params)
    @product.creator = current_user
    # check for allergens and populate reactions db when you save product
    if @product.save # @product.save returns "false" if it can't save
      flash[:success] = "Product was successfully created"
      # redirect must be a url, can't render a view template
      # (add '_path' to the prefix to get the url)
      redirect_to product_path(@product) # show
    else
      # validation error occured. We must render to have access to 
      # "products.error.full_messages" array to display generated errors 
      render 'new'
    end
  end

  # PATCH '/products/:id'
  #the general pattern used in the action create that handles
  #submission of model-backed forms 
  def update # this is where the form displayed in 'edit' is submitted using verb "patch"
    if @product.update(product_params)
      flash[:success] = "Product was successfully updated"
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end

  # GET '/products/:id'
  def show
    #already have @product at this point because 'set_product' was invoked
    #render 'products/show' (show.html.erb) automatically called before exiting this method
  end

  # DELETE '/products/:id'
  def destroy
    # already have @product at this point because 'set_product' was invoked
    @product.destroy
    flash[:success] = "Product was successfully deleted"
    redirect_to products_path # show.html.erb
  end

  private

  def set_product
    # ask ActiveRecord to find the Product object in the db using the id from params
    #@product = Product.find_by(params[:id])
    @product = Product.find_by id: params[:id], user_id: current_user.id

  end

  def product_params
    # use strong parameters to expose the fields we're interested in
    # require top level key be product and allow changes to name, ingredients
    params.require(:product).permit(:name, :ingredients)
    # To permit all attributes params.require(:post).permit!
  end

  def sortable_columns
    ["name"]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end