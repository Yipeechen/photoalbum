class Api::V1::PhotosController < ApiController
  def index
    @photos = Photo.all
    #當有多筆資料時習慣在資料外包覆一層json: { data: @varrible }
    #使用map方法使映射出另一個新的array
    render json: {
      data: @photos.map do |photo|
        {
          title: photo.title,
          date: photo.date,
          description: photo.description
        }
      end
    }
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
      render json: {
        title: @photo.title,
        date: @photo.date,
        description: @photo.description
      }
    end
  end
end
