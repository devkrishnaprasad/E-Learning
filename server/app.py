import uuid
from flask import Flask, jsonify, request
from operations import DBOperations
import boto3
from dotenv import load_dotenv
import os
from flask_cors import CORS
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity, decode_token
from datetime import timedelta, datetime, timezone
import jwt
load_dotenv()

app = Flask(__name__)
app.config['JWT_SECRET_KEY'] = os.environ["TOKEN_SECRET_KEY"]
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(days=30)  
jwt = JWTManager(app)
CORS(app)

operations_obj = DBOperations()

jwt = JWTManager(app)

def create_user_token(payload):
   return create_access_token(identity=payload)

def generate_uuid():
    return str(uuid.uuid4())

def get_file_extension(file_name):
    _, file_extension = os.path.splitext(file_name)
    return file_extension

def get_file_url(file):
    file_extension = get_file_extension(file.filename)
    image_id = generate_uuid() + file_extension
    s3_base_url = f"https://{os.getenv('S3_BUCKET_NAME')}.s3.amazonaws.com/"
    image_url = f"{s3_base_url}"
    return image_id, image_url

def upload_image_s3(data,folder_name):
    try:
        image_id, image_url = get_file_url(data)
        s3 = boto3.client('s3', aws_access_key_id=os.getenv("S3_ACCESS_KEY"), aws_secret_access_key=os.getenv("S3_SECRET_KEY"))
        image_path = f"{folder_name}/{image_id}"
        s3.upload_fileobj(data, os.getenv("S3_BUCKET_NAME"), image_path)
       
        print(image_url + image_path)
        return image_url + image_path
    except Exception as e:
        return jsonify({"error": f"Error processing request: {e}"}), 500

def delete_image_from_s3(image_key):
    s3 = boto3.client('s3', aws_access_key_id=os.getenv("S3_ACCESS_KEY"), aws_secret_access_key=os.getenv("S3_SECRET_KEY"))
    filename = os.path.basename(image_key)
    try:
        # Delete the object
        s3.delete_object(Bucket=os.getenv("S3_BUCKET_NAME"), Key=filename)
        print(f"Image {filename} deleted successfully from {os.getenv("S3_BUCKET_NAME")}")
    except Exception as e:
        print(f"Error deleting image {filename} from {os.getenv("S3_BUCKET_NAME")}: {e}")

@app.route('/apis/auth/check-token/', methods=['POST'])
def check_token():
    token = request.json.get('token', None)
    if not token:
        return jsonify({"msg": "Missing token"}), 400
    return jsonify(validate_token(token=token))

def validate_token(token):    
    try:
        decoded_token = decode_token(token)
        exp_timestamp = decoded_token['exp']
        now = datetime.now(timezone.utc)
        exp_datetime = datetime.fromtimestamp(exp_timestamp, tz=timezone.utc)
        remaining_time = exp_datetime - now

        if remaining_time > timedelta(0):
            
            return {
                "status":True,
                "details":decoded_token['sub'],
                "msg": "Token is valid", "remaining_time": str(remaining_time)}
        else:
            return jsonify({
                "status":False,
                "msg": "Token has expired"}), 401

    except jwt.ExpiredSignatureError:
        return jsonify({
            "status":False,
            "msg": "Token has expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({
            "status":False,
            "msg": "Invalid token"}), 401

@app.route('/apis/users/register/', methods=['POST'])
def register_user():
    data = request.get_json()
    full_name = data.get('full_name')
    email = data.get('email')
    password = data.get('password')

    if not full_name:
        return jsonify({"error": "Full name is required"}), 400
    if not email:
        return jsonify({"error": "Email is required"}), 400
    if not password:
        return jsonify({"error": "Password is required"}), 400
    return operations_obj.register_user(full_name=full_name,password=password,email=email)

@app.route('/apis/users/login/', methods=['POST'])
def user_login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')
    
    if not email:
        return jsonify({"error": "Email is required"}), 400
    if not password:
        return jsonify({"error": "Password is required"}), 400

    response = operations_obj.login_user(email=email, password=password)
    print(response)
    if 'error' in response:
        return jsonify(response), 401

    payload = {"email": email, "full_name": response['response']['records'][0]['full_name']}
    user_token = create_user_token(payload)

    # Add user_token to the first record in the records list
    response_data = response.get('response', {})
    records = response_data.get('records', [])
    if records:
        records[0]['user_token'] = user_token
    return jsonify(response)

@app.route('/apis/users/get-profile/', methods=['GET'])
def get_profile():
    auth_header = request.headers.get('Authorization')
    if auth_header:
        token = auth_header.split(" ")[1]
        
        response =  validate_token(token)
        if response['status'] == True:
            response['details']['email']
            print(response['details']['email'])
            return operations_obj.get_user_details(response['details']['email'])
        return response, 200
    else:
        return jsonify({"message": "Authorization header missing"}), 401
    
@app.route('/apis/category/create-category/', methods=['POST'])
def add_category():
    category_name = request.form['category_name']
    username = request.form['username']
    status = request.form['status'].lower() == 'true'
    category_image = request.files['category_image']
    image_url =  upload_image_s3(category_image,'product_category')
    response = operations_obj.add_category(category_id=generate_uuid(),category_name=category_name,username=username,status=status,category_image=image_url)
    return response

@app.route('/apis/category/get-category-list/', methods=['GET'])
def get_all_category():
    response = operations_obj.get_all_category()
    return response

@app.route('/apis/product/create-product/', methods=['POST'])
def create_product():
    product_image = request.files['product_image']
    product_name = request.form['product_name']
    product_category = request.form['product_category']
    price = request.form['price']
    offer_price = request.form['offer_price']
    product_level = request.form['product_level']
    rating = request.form['rating']
    students_count = request.form['students_count']
    total_duration = request.form['total_duration']
    session_count = request.form['session_count']
    about = request.form['about']
    username = request.form['username']
    status = request.form['status']
    image_url =  upload_image_s3(product_image,'products_details')
    response =  operations_obj.add_product(
        producty_id = generate_uuid(),
        price=price,product_level=product_level,
    product_image=image_url,offer_price=offer_price,product_name=product_name,rating=rating,
    student_count=students_count,total_duration=total_duration,product_category=product_category,
    session_count=session_count,about=about,username=username,status=status)
    return response

@app.route('/apis/product/get-products-all/', methods=['GET'])
def get_all_products():
    response = operations_obj.get_all_products()
    return response

@app.route('/apis/product/add-popuplar-product/', methods=['POST'])
def add_popular_products():
    data = request.get_json()
    product_id = data.get('product_id')
    username = data.get('username')
    response = operations_obj.add_popular_product(item_id=generate_uuid(),product_id=product_id,username=username)
    return response

@app.route('/apis/product/get-popular-products/', methods=['GET'])
def get_popular_products():
    response = operations_obj.get_all_popular_product_details()
    return response

@app.route('/apis/banner/add-offer-banner/', methods=['POST'])
def add_banner():
    title = request.form['title']
    description = request.form['description']
    offer_price = request.form['offer_price']
    status = request.form['status'].lower() == 'true'
    username = request.form['username']
    banner_image = request.files['banner_image']
    image_url =  upload_image_s3(banner_image,'offer_banner')
    response = operations_obj.add_banners(title=title,description=description,price=offer_price,status=status,username=username,image_url=image_url,banner_id=generate_uuid())
    return response

@app.route('/apis/banner/get-banners/', methods=['GET'])
def get_banners():
    response = operations_obj.get_all_banners()
    return response

@app.route('/apis/session/create-session/', methods=['POST'])
def add_sessions():
    auth_header = request.headers.get('Authorization')
    if auth_header:
        token = auth_header.split(" ")[1]
        
        response =  validate_token(token)
        if response['status'] == True:
            
            print(response['details']['email'])
            data = request.get_json()
            product_id =  data.get('product_id')
            session_title =  data.get('session_title')
            session_duration =  data.get('session_duration')
            username = response['details']['email']
            status = data.get('status')
            return  operations_obj.create_session(product_id=product_id,session_id=generate_uuid(),
                                        title=session_title,duration=session_duration,
                                        status=status,username=username)
        return response, 200
    else:
        return jsonify({"message": "Authorization header missing"}), 401

@app.route('/apis/session/get-session-details/', methods=['POST'])
def get_session_details():
    data = request.get_json()
    product_id =  data.get('product_id')
    return operations_obj.get_sessions_details(product_id=product_id)

@app.route('/apis/session/create-level/', methods=['POST'])
def add_level():

    auth_header = request.headers.get('Authorization')
    if auth_header:
        token = auth_header.split(" ")[1]
        
        response =  validate_token(token)
        if response['status'] == True:
            
            print(response['details']['email'])
            session_id = request.form['session_id']
            video = request.files['video_url']
            resourses = request.files['resourses']
            level_title = request.form['level_title']
            duration = request.form['duration']
            username = response['details']['email']
            product_id = request.form['product_id']
            video_url =  upload_image_s3(video,f'{product_id}/{session_id}')
            resourses_url = upload_image_s3(resourses,f'{product_id}/{session_id}')

            return operations_obj.create_session_level(level_id=generate_uuid(),session_id=session_id,video_path=video_url,resourses=resourses_url,
                                        levle_title=level_title,duration=duration,last_modified_user=username)

@app.route('/apis/review/add-product-review/', methods=['POST'])
def add_product_review():
    data = request.get_json()
    product_id =  data.get('product_id')
    rating =  data.get('rating')
    review =  data.get('review')
    username =  data.get('username')
    return  operations_obj.add_product_review(review_id=generate_uuid(),product_id=product_id,rating=rating,
                                              review=review,username=username)

@app.route('/apis/review/get-product-review/', methods=['POST'])
def get_product_review():
    data = request.get_json()
    product_id =  data.get('product_id')
    return  operations_obj.get_product_reviews(product_id=product_id)

@app.route('/apis/product/purchase-product/', methods=['POST'])
def purchase_product():
    auth_header = request.headers.get('Authorization')
    data = request.get_json()
    product_id =  data.get('product_id')
    price =  data.get('price')
    if auth_header:
        token = auth_header.split(" ")[1]
        
        response =  validate_token(token)
        if response['status'] == True:
            username = response['details']['email']
            print(response['details']['email'])
            payment_mode = data.get('payment_method')
            return operations_obj.product_purchase(product_id=product_id,price=price,username=username,
                                                payment_mode=payment_mode,purchase_id=generate_uuid())

@app.route('/apis/product/get-purchase-details/', methods=['GET'])
def get_purchase_details():
    auth_header = request.headers.get('Authorization')
    if auth_header:
        token = auth_header.split(" ")[1]
        
        response =  validate_token(token)
        if response['status'] == True:
            response['details']['email']
            print(response['details']['email'])
            return operations_obj.get_purchase_details(username=response['details']['email'])
        return response, 200
    else:
        return jsonify({"message": "Authorization header missing"}), 401

@app.route('/apis/session/mark-session-completed/', methods=['POST'])
def mark_session_completed():
    auth_header = request.headers.get('Authorization')
    if auth_header:
        token = auth_header.split(" ")[1]
        
        response =  validate_token(token)
        if response['status'] == True:
            response['details']['email']
            data = request.get_json()
            product_id =  data.get('product_id')
            session_id = data.get('session_id')
            return operations_obj.mark_session_completed(
                session_id=session_id,product_id=product_id,
                username=response['details']['email'])
        return response, 200
    else:
        return jsonify({"message": "Authorization header missing"}), 401

@app.route('/apis/session/mark-level-completed/', methods=['POST'])
def mark_level_completed():
    auth_header = request.headers.get('Authorization')
    if auth_header:
        token = auth_header.split(" ")[1]
        
        response =  validate_token(token)
        if response['status'] == True:
            response['details']['email']
            data = request.get_json()
            product_id =  data.get('product_id')
            session_id = data.get('session_id')
            level_id = data.get('level_id')
            return operations_obj.mark_level_completed(
                level_id=level_id,
                session_id=session_id,product_id=product_id,
                username=response['details']['email'])
        return response, 200
    else:
        return jsonify({"message": "Authorization header missing"}), 401

@app.route('/apis/session/get-level-record/', methods=['POST'])
def get_level_record():
    auth_header = request.headers.get('Authorization')
    if auth_header:
        token = auth_header.split(" ")[1]
        
        response =  validate_token(token)
        if response['status'] == True:
            response['details']['email']
            data = request.get_json()
            product_id =  data.get('product_id')

            return operations_obj.get_level_record(username=response['details']['email'],product_id=product_id)

@app.route('/apis/session/get-session-record/', methods=['POST'])
def get_session_record():
    auth_header = request.headers.get('Authorization')
    if auth_header:
        token = auth_header.split(" ")[1]
        
        response =  validate_token(token)
        if response['status'] == True:
            response['details']['email']
            data = request.get_json()
            product_id =  data.get('product_id')
            return operations_obj.get_session_record(username=response['details']['email'],product_id=product_id)

@app.route('/apis/product/mark-completed/', methods=['POST'])
def mark_course_completed():
    auth_header = request.headers.get('Authorization')
    if auth_header:
        token = auth_header.split(" ")[1]
        response =  validate_token(token)
        if response['status'] == True:
            response['details']['email']
            data = request.get_json()
            product_id =  data.get('product_id')
            return operations_obj.mark_course_completed(username=response['details']['email'],product_id=product_id,item_id=generate_uuid())

@app.route('/apis/product/get-completed-courses/', methods=['GET'])
def get_completed_courses():
    auth_header = request.headers.get('Authorization')
    if auth_header:
        token = auth_header.split(" ")[1]
        
        response =  validate_token(token)
        if response['status'] == True:
            response['details']['email']
            return operations_obj.get_completed_courses(username=response['details']['email'])
if __name__ == '__main__':
    app.run(debug=True, port=4000)