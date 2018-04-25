class Api::V1::PhotosController < ApiController
  def index
    @photos = Photo.all
    #當有多筆資料時習慣在資料外包覆一層json: { data: @varrible }
    #使用map方法使映射出另一個新的array
    # render json: {
    #   data: @photos.map do |photo|
    #     {
    #       title: photo.title,
    #       date: photo.date,
    #       description: photo.description
    #     }
    #   end
    # }
  end

  def show
    #使用find_by方法，拋出物件內容為nil，避免拋出error
    @photo = Photo.find_by(id: params[:id])
    # 若無此id照片，回傳HTTP狀態碼400
    if !@photo  
      render json: {
        message: "Can't find the photo!",
        status: 400
      }
    else
      # render json: {
      #   title: @photo.title,
      #   date: @photo.date,
      #   description: @photo.description
      # }
      render "api/v1/photos/show"
    end
  end

  #利用postman 使用POST http://localhost:3000/api/v1/photos 帶入參數
  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      render json: {
        message: "Photo created successfully!",
        result: @photo
      }
    else
      render json: {
        errors: @photo.errors
      }
    end
  end

  #利用postman 使用PATCH  http://localhost:3000/api/v1/photos/:id 帶入參數
  def update
    @photo = Photo.find_by(id: params[:id])
    if @photo.update(photo_params)
      render json: {
        message: "Photo updated successfully!",
        result: @photo
      }
    else
      render json: {
        errors: @photo.errors
      }
    end
  end

  #利用postman 使用DELETE  http://localhost:3000/api/v1/photos/:id 帶入參數
  def destroy
    @photo = Photo.find_by(id: params[:id])
    @photo.destroy
    render json: {
      message: "Photo destroy successfully!"
    }    
  end

  private

  #沒有特別寫入require(:photo)，直接以parameters包覆，回傳的格式是json
  def photo_params
    params.permit(:title, :date, :description, :file_location)
  end
end
