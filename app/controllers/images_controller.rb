class ImagesController < ApplicationController
  # GET /images
  # GET /images.xml
  def index
    @images = Image.find(:all, :conditions => ['parent_id is null'])
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @images.to_xml }
      format.js
    end
  end

  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @image.to_xml }
    end
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1;edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.xml
  def create    
    @image = Image.new params[:image]

    respond_to do |format|
      if @image.save
        
        format.html do
          flash[:notice] = 'Image was successfully created.'
          redirect_to my_image_url(@image)
        end
        format.xml  { head :created, :location => my_image_url(@image) }
         format.js do
           responds_to_parent do
             render :update do |page|
               page << "ts_insert_image('#{@image.public_filename()}', '#{@image.public_filename()}');"
             end
           end
         end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors.to_xml }
        format.js do
          responds_to_parent do
            render :update do |page|
              page.alert('sorry, error uploading image')
            end
          end
        end
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        flash[:notice] = 'Image was successfully updated.'
        format.html { redirect_to my_images_url }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors.to_xml }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:notice] = 'Image was successfully destroyed.'
    respond_to do |format|
      format.html { redirect_to my_images_url }
      format.xml  { head :ok }
    end
  end
end
