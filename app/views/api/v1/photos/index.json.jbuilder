#json.data 在回傳的資料外再包覆一層data
#json.array!取出一筆筆@photots的內容依照個人指定方式排列
json.data do
  json.array! @photos do |photo|
    json.partial! "photo", photo: photo
  end
end