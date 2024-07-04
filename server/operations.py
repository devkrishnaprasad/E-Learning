from flask import jsonify
import psycopg2
from dotenv import load_dotenv
import os
from datetime import datetime
import pytz
from flask_bcrypt import Bcrypt


load_dotenv()
bcrypt = Bcrypt()
def hash_password(password):
    return bcrypt.generate_password_hash(password).decode('utf-8')

def hash_password_check(hash_password,password):
    return bcrypt.check_password_hash(hash_password,password)
class DBOperations:

    def get_current_date_time(self):
        utc_now = datetime.utcnow()
        utc_timezone = pytz.timezone('UTC')
        utc_now = utc_timezone.localize(utc_now)
        ist_timezone = pytz.timezone('Asia/Kolkata')
        ist_now = utc_now.astimezone(ist_timezone)
        return ist_now.strftime("%Y-%m-%d %H:%M:%S %Z")
    
    def create_connection(self):
        try:
            conn = psycopg2.connect(
                dbname=os.getenv("DB_NAME"),
                user=os.getenv("DB_USER"),
                password=os.getenv("DB_PASSWORD"),
                host=os.getenv("DB_HOST"),
                port=os.getenv("DB_PORT")
            )
            return conn
        except Exception as e:
            print(f"Error connecting to the database: {e}")
            return None
    
    def add_category(self,category_id, category_name, category_image, username, status):
        try:
            db_connect = self.create_connection()
            if db_connect:
                cur = db_connect.cursor()

                query = """
                    INSERT INTO product_category (category_id, category_name, category_image, username, last_modified, status)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """

                print("Modified Date Time ",self.get_current_date_time())
                data = (category_id, category_name, category_image, username, self.get_current_date_time(), status)

                cur.execute(query, data)
                db_connect.commit()

                cur.close()

                return jsonify({"message": "New Category added successfully."}), 200
        except Exception as e:
            print(f"Error adding category: {e}")
            return jsonify({"message": "Failed to add category."}), 200

    def get_all_category(self):
        try:
            query = '''
                SELECT * FROM product_category
            '''
            conn = self.create_connection()
            if conn:
                cur = conn.cursor()
                cur.execute(query)
                category_details = cur.fetchall()
                cur.close()
                conn.close()
                column_names = [desc[0] for desc in cur.description]
                category_list = {
                    "response": {
                        "msg": "We have successfully fetched category list",
                        "records": [
                            {column_names[i]: row[i] for i in range(len(row))} for row in category_details
                        ],
                        "status": True,
                    }
                }

                return jsonify(category_list)
        except Exception as e:
            print(f"Error retrieving category details from the database: {e}")
            return jsonify({"error": f"Error retrieving category details from the database: {e}"})
     
    def add_product(self,producty_id,product_name,product_image,product_category,price,offer_price,product_level,rating,student_count,total_duration,session_count,about,username,status):
        try:
            db_connect = self.create_connection()
            if db_connect:
                cur = db_connect.cursor()

                insert_query = """
                    INSERT INTO product_details (
                        product_id, 
                        product_name, 
                        product_image, 
                        product_category, 
                        price, 
                        offer_price, 
                        product_level, 
                        rating, 
                        students_count, 
                        total_duration, 
                        session_count, 
                        about, 
                        username, 
                        last_modified, 
                        status
                    ) VALUES (
                        %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                    );
                """
                data = (producty_id,product_name,product_image,product_category,price,offer_price,product_level,rating,student_count,
                        total_duration,session_count,about,username,self.get_current_date_time(),status
                        )

                cur.execute(insert_query, data)
                db_connect.commit()

                cur.close()

                return jsonify({"message": "New Product added successfully."}), 200
        except Exception as e:
            print(f"Error adding Product: {e}")
            return jsonify({"message": "Failed to add product."}), 200
    
    def get_all_products(self):
        try:
            query = '''
                SELECT * FROM product_details
            '''
            conn = self.create_connection()
            if conn:
                cur = conn.cursor()     
                cur.execute(query)
                product_details = cur.fetchall()
                cur.close()
                conn.close()
                column_names = [desc[0] for desc in cur.description]
                product_list = {
                    "response": {
                        "msg": "We have successfully fetched product list",
                        "records": [
                            {column_names[i]: row[i] for i in range(len(row))} for row in product_details
                        ],
                        "status": True,
                    }
                }

                return jsonify(product_list)
        except Exception as e:
            print(f"Error retrieving product details from the database: {e}")
            return jsonify({"error": f"Error retrieving product details from the database: {e}"})
    
    def add_popular_product(self,item_id,product_id,username):
        try:
            db_connect = self.create_connection()
            if db_connect:
                cur = db_connect.cursor()

                query = """
                    INSERT INTO popular_products (item_id, product_id, last_modified, last_modified_user)
                    VALUES (%s, %s, %s, %s)
                """

                print("Modified Date Time ",self.get_current_date_time())
                data = (item_id, product_id, self.get_current_date_time(), username)

                cur.execute(query, data)
                db_connect.commit()

                cur.close()

                return jsonify({"message": "New popular product added successfully."}), 200
        except Exception as e:
            print(f"Error adding category: {e}")
            return jsonify({"message": "Failed to add popular product."}), 200
    
    def get_all_popular_product_details(self):
        try:
            query = '''
                SELECT 
                    pd.*
                FROM 
                    popular_products pp
                JOIN 
                    product_details pd
                ON 
                    pp.product_id = pd.product_id
            '''
            conn = self.create_connection()
            if conn:
                cur = conn.cursor()
                cur.execute(query)
                product_details = cur.fetchall()
                cur.close()
                conn.close()
                
               
                column_names = [desc[0] for desc in cur.description]
                
                product_list = {
                    "response": {
                        "msg": "We have successfully fetched popular product details",
                        "records": [
                            {column_names[i]: row[i] for i in range(len(row))} for row in product_details
                        ],
                        "status": True,
                    }
                }

                return jsonify(product_list)
        except Exception as e:
            print(f"Error retrieving product details from the database: {e}")
            return jsonify({"error": f"Error retrieving product details from the database: {e}"})

    def add_banners(self, banner_id, title, description, image_url, price, status, username):
        try:
            db_connect = self.create_connection()
            if db_connect:
                cur = db_connect.cursor()

                query = """
                    INSERT INTO offer_banner_details (banner_id, amount, title, description, banner_image, modified_date, status, modified_user)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """

                modified_date_time = self.get_current_date_time()
                print("Modified Date Time ", modified_date_time)

                data = (banner_id, price, title, description, image_url, modified_date_time, status, username)

                cur.execute(query, data)
                db_connect.commit()

                cur.close()
                db_connect.close()

                return jsonify({"message": "New banner added successfully."}), 200
        except Exception as e:
            print(f"Error adding banner: {e}")
            return jsonify({"message": "Failed to add banner."}), 500
        
    def get_all_banners(self):
        try:
            query = '''
                SELECT * FROM offer_banner_details
            '''
            conn = self.create_connection()
            if conn:
                cur = conn.cursor()
                cur.execute(query)
                banner_details = cur.fetchall()
                cur.close()
                conn.close()
                column_names = [desc[0] for desc in cur.description]
                banner_list = {
                    "response": {
                        "msg": "We have successfully fetched banner list",
                        "records": [
                            {column_names[i]: row[i] for i in range(len(row))} for row in banner_details
                        ],
                        "status": True,
                    }
                }

                return jsonify(banner_list)
        except Exception as e:
            print(f"Error retrieving banner details from the database: {e}")
            return jsonify({"error": f"Error retrieving banner details from the database: {e}"})
     
    def create_session(self,session_id,product_id,title,duration,username,status):
        try:
            db_connect = self.create_connection()
            if db_connect:
                cur = db_connect.cursor()

                query = """
                    INSERT INTO session_details (session_id, product_id, session_title, session_duration, last_modified, last_modified_user, status)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                """

                modified_date_time = self.get_current_date_time()
                print("Modified Date Time ", modified_date_time)

                data = (session_id, product_id, title, duration, modified_date_time, username, status)

                cur.execute(query, data)
                db_connect.commit()

                cur.close()
                db_connect.close()

                return jsonify({"message": "New session added successfully.","session_id":session_id}), 200
        except Exception as e:
            print(f"Error create_session: {e}")
            return jsonify({"message": "Failed to add session."}), 500
    
    def get_sessions_details(self, product_id):
        try:
            if not product_id:
                return jsonify({"error": "Product ID is required."})

            query = f'''
                SELECT
                    pd.product_id,
                    pd.product_name,
                    pd.rating,
                    pd.price,
                    pd.offer_price,
                    pd.session_count,
                    pd.product_image,
                    pd.about,
                    pd.video_url,
                    pd.total_duration,
                    sd.session_id,
                    sd.session_title,
                    sd.session_duration,
                    sl.level_id,
                    sl.video_path,
                    sl.resourses,
                    sl.level_title,
                    sl.duration
                FROM
                    product_details pd
                JOIN
                    session_details sd ON pd.product_id = sd.product_id
                JOIN
                    session_levels sl ON sd.session_id = sl.session_id
                WHERE
                    pd.product_id = %s
            '''

            conn = self.create_connection()
            if not conn:
                return jsonify({"error": "Failed to create database connection."})

            cur = conn.cursor()
            cur.execute(query, (product_id,))
            category_details = cur.fetchall()
            column_names = [desc[0] for desc in cur.description]
            cur.close()
            conn.close()

            if not category_details:
                return jsonify({"response": {"msg": "No sessions found for the given product ID", "records": [], "status": True}})

            product_details = {
                "product_image":category_details[0][column_names.index("product_image")],
                "about": category_details[0][column_names.index("about")],
                "product_id": category_details[0][column_names.index("product_id")],
                "product_name": category_details[0][column_names.index("product_name")],
                "rating": category_details[0][column_names.index("rating")],
                "video_url":category_details[0][column_names.index("video_url")],
                "price":category_details[0][column_names.index("price")],
                "offer_price":category_details[0][column_names.index("offer_price")],
                "total_duration":category_details[0][column_names.index("total_duration")],
                "session_count":category_details[0][column_names.index("session_count")],
            }

            sessions_dict = {}
            for row in category_details:
                row_dict = {column_names[i]: row[i] for i in range(len(row))}
                session_id = row_dict['session_id']
                if session_id not in sessions_dict:
                    sessions_dict[session_id] = {
                        "session_id": session_id,
                        "session_title": row_dict['session_title'],
                        "session_duration": row_dict['session_duration'],
                        "levels": []
                    }
                level_details = {
                    "duration": row_dict["duration"],
                    "level_id": row_dict["level_id"],
                    "level_title": row_dict["level_title"],
                    "resourses": row_dict["resourses"],
                    "video_path": row_dict["video_path"]
                }
                sessions_dict[session_id]["levels"].append(level_details)

            sessions_list = list(sessions_dict.values())

            response = {
                "response": {
                    "msg": "We have successfully fetched session list",
                    "records": [{
                        "product_details": product_details,
                        "sessions": sessions_list
                    }],
                    "status": True,
                }
            }
            return jsonify(response)

        except Exception as e:
            print(f"Error retrieving category details from the database: {e}")
            return jsonify({"error": f"Error retrieving session details from the database: {e}"})

    def create_session_level(self,session_id,level_id,video_path,resourses,levle_title,duration,last_modified_user):
        try:
            db_connect = self.create_connection()
            if db_connect:
                cur = db_connect.cursor()

                query = """
                    INSERT INTO session_levels (session_id, level_id, video_path, resourses, level_title,duration,last_modified_date,last_modified_user)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """

                modified_date_time = self.get_current_date_time()
                print("Modified Date Time ", modified_date_time)

                data = (session_id, level_id, video_path, resourses, levle_title, duration,modified_date_time ,last_modified_user)

                cur.execute(query, data)
                db_connect.commit()

                cur.close()
                db_connect.close()
                return jsonify({"message": "New level added successfully.","level_id":level_id,"session_id":session_id}), 200
        except Exception as e:
            print(f"Error create_session_level: {e}")
            return jsonify({"message": "Failed to add level."}), 500
        
    def add_product_review(self,product_id,review,rating,review_id,username):
        try:
            db_connect = self.create_connection()
            if db_connect:
                cur = db_connect.cursor()

                query = """
                    INSERT INTO product_review (review_id, product_id, rating, review_description, username,last_modified)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """

                modified_date_time = self.get_current_date_time()
                print("Modified Date Time ", modified_date_time)

                data = (review_id, product_id, rating, review, username,modified_date_time)

                cur.execute(query, data)
                db_connect.commit()

                cur.close()
                db_connect.close()

                return jsonify({"message": "New review added successfully."}), 200
        except Exception as e:
            print(f"Error add_product_review: {e}")
            return jsonify({"message": "Failed to add review."}), 500
    
    def get_product_reviews(self,product_id):
        try:
            query = f'''
                SELECT * FROM product_review WHERE product_id = '{product_id}'
            '''
            conn = self.create_connection()
            if conn:
                cur = conn.cursor()
                cur.execute(query)
                banner_details = cur.fetchall()
                cur.close()
                conn.close()
                column_names = [desc[0] for desc in cur.description]
                banner_list = {
                    "response": {
                        "msg": "We have successfully fetched product review",
                        "records": [
                            {column_names[i]: row[i] for i in range(len(row))} for row in banner_details
                        ],
                        "status": True,
                    }
                }

                return jsonify(banner_list)
        except Exception as e:
            print(f"Error retrieving product review details from the database: {e}")
            return jsonify({"error": f"Error retrieving product review details from the database: {e}"})

    def product_purchase(self,product_id,purchase_id,username,price,payment_mode):
        try:
            db_connect = self.create_connection()
            if db_connect:
                cur = db_connect.cursor()

                query = """
                    INSERT INTO product_purchase_details (product_id, purchase_id, purchased_price, username, payment_method,purchased_date)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """

                modified_date_time = self.get_current_date_time()
                print("Modified Date Time ", modified_date_time)

                data = (product_id, purchase_id,price , username,payment_mode, modified_date_time)

                cur.execute(query, data)
                db_connect.commit()

                cur.close()
                db_connect.close()

                return jsonify(
                    {
                        "response": {
                            "msg": "Order successfull",
                            "status":"True",
                            "records": [
                                {
                                    "order_id":purchase_id,
                                    "product_id":product_id,
                                    "status":True,
                                }
                            ]
                        }
                    }
                ), 200
        except Exception as e:
            print(f"Errorproduct_purchase: {e}")
            return jsonify(
                 {
                        "response": {
                            "msg": "Order failed",
                            "status":"False",
                            "records": [
                                {
                                    "status":False,
                                }
                            ]
                        }
                    }
            ), 500
        
    def get_purchase_details(self,username):
        try:
            query = f'''
                SELECT 
                ppd.*, 
                pd.product_name,
                pd.product_image,
                pd.product_category,
                pd.rating,
                pd.total_duration,
                pd.session_count,
                pd.product_level,
                pd.about
                
            FROM 
                product_purchase_details ppd
            JOIN 
                product_details pd ON ppd.product_id = pd.product_id
            WHERE 
                ppd.username = '{username}';

            '''
            conn = self.create_connection()
            if conn:
                cur = conn.cursor()
                cur.execute(query)
                banner_details = cur.fetchall()
                cur.close()
                conn.close()
                column_names = [desc[0] for desc in cur.description]
                banner_list = {
                    "response": {
                        "msg": "We have successfully fetched purchase details",
                        "records": [
                            {column_names[i]: row[i] for i in range(len(row))} for row in banner_details
                        ],
                        "status": True,
                    }
                }

                return jsonify(banner_list)
        except Exception as e:
            print(f"Error retrieving product purchase details from the database: {e}")
            return jsonify({"error": f"Error retrieving product purchase details from the database: {e}"})
    
    def register_user(self, email, password, full_name):
        try:
            hashed_password = hash_password(password)
            db_connect = self.create_connection()
            if db_connect:
                cur = db_connect.cursor()
                query = """
                    INSERT INTO user_details (email, password_hash, full_name, created_at, updated_at)
                    VALUES (%s, %s, %s, %s, %s)
                """
                modified_date_time = self.get_current_date_time()
                print("Modified Date Time ", modified_date_time)
                data = (email, hashed_password, full_name, modified_date_time, modified_date_time)
                cur.execute(query, data)
                db_connect.commit()
                cur.close()
                db_connect.close()

                return jsonify({"message": "New user created successfully."}), 200

        except psycopg2.IntegrityError as integrity_error:
            db_connect.rollback()  
            print(f"IntegrityError: {integrity_error}")
            return jsonify({"error": "Email address already exists."}), 400

        except Exception as e:
            db_connect.rollback()
            print(f"Error register_user: {e}")
            return jsonify({"error": "Failed to create user."}), 500
    
    def login_user(self, email, password):
        try:
            query = f'''
                SELECT * FROM user_details WHERE email = '{email}'
            '''
            conn = self.create_connection()
            if conn:
                cur = conn.cursor()
                cur.execute(query)
                user_details_row = cur.fetchone()
                cur.close()
                conn.close()

                if not user_details_row:
                    return jsonify({"error": "User not found"}), 404
                
                password_hash = user_details_row[2]
            
                if not bcrypt.check_password_hash(password_hash, password):
                    return jsonify({"error": "Wrong password"}), 401
                
                user_details = {}
                column_names = [desc[0] for desc in cur.description]
                for i in range(len(user_details_row)):
                    if column_names[i] != 'password_hash': 
                        user_details[column_names[i]] = user_details_row[i]

                response = {
                    "response": {
                        "msg": "User logged in successfully",
                        "records": [user_details],
                        "status": True,
                    }
                }
                
                return response

        except Exception as e:
            print(f"Error retrieving user details from the database: {e}")
            return jsonify({"error": f"Error retrieving user details from the database: {e}"}), 500
        
    def get_user_details(self, email):
        try:
            query = f'''
                SELECT
                    full_name,
                    email,
                    phone_number,
                    gender,
                    user_type,
                    profile_image,
                    date_of_birth,
                    created_at,
                    updated_at,
                    last_login,
                    is_active
                FROM
                    user_details
                WHERE
                    email = '{email}';

            '''
            conn = self.create_connection()
            if conn:
                cur = conn.cursor()
                cur.execute(query)
                banner_details = cur.fetchall()
                cur.close()
                conn.close()
                column_names = [desc[0] for desc in cur.description]
                banner_list = {
                    "response": {
                        "msg": "We have successfully fetched user details",
                        "records": [
                            {column_names[i]: row[i] for i in range(len(row))} for row in banner_details
                        ],
                        "status": True,
                    }
                }

                return jsonify(banner_list)
        except Exception as e:
            print(f"Error retrieving user details from the database: {e}")
            return jsonify({"error": f"Error retrieving user details from the database: {e}"})
        
    def mark_session_completed(self,session_id,product_id,username):
        try:
            db_connect = self.create_connection()
            if db_connect:
                cur = db_connect.cursor()

                query = """
                    INSERT INTO session_progress (session_id, product_id, username, date_of_completion, status)
                    VALUES (%s, %s, %s, %s, %s);
                """

                modified_date_time = self.get_current_date_time()
                print("Modified Date Time ", modified_date_time)

                data = (session_id, product_id, username, modified_date_time,True)

                cur.execute(query, data)
                db_connect.commit()

                cur.close()
                db_connect.close()

                return jsonify({"message": "Session marked completed."}), 200
        except Exception as e:
            print(f"Error mark completed: {e}")
            return jsonify({"message": "Failed mark completed."}), 500
        
    def mark_level_completed(self, session_id, product_id, username, level_id):
        try:
            db_connect = self.create_connection()
            if db_connect:
                cur = db_connect.cursor()

                query = """
                    INSERT INTO level_progress (level_id, session_id, username, date_of_completion, status, product_id)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """

                modified_date_time = self.get_current_date_time()
                print("Modified Date Time", modified_date_time)

                data = (level_id, session_id, username, modified_date_time, True, product_id)

                cur.execute(query, data)
                db_connect.commit()

                cur.close()
                db_connect.close()

                return jsonify({"message": "Level marked completed."}), 200
        except Exception as e:
            print(f"Error mark_level_completed: {e}")
            return jsonify({"message": "Failed to mark completed."}), 500
        
    def get_level_record(self,username,product_id):
        try:
            query = f'''
                SELECT * FROM level_progress WHERE username = '{username}' AND product_id = '{product_id}'
            '''
            conn = self.create_connection()
            if conn:
                cur = conn.cursor()
                cur.execute(query)
                banner_details = cur.fetchall()
                cur.close()
                conn.close()
                column_names = [desc[0] for desc in cur.description]
                banner_list = {
                    "response": {
                        "msg": "We have successfully fetched level record",
                        "records": [
                            {column_names[i]: row[i] for i in range(len(row))} for row in banner_details
                        ],
                        "status": True,
                    }
                }

                return jsonify(banner_list)
        except Exception as e:
            print(f"Error retrieving level record from the database: {e}")
            return jsonify({"error": f"Error retrieving level record from the database: {e}"})
    
    def get_session_record(self,username,product_id):
        try:
            query = f'''
                SELECT * FROM session_progress WHERE username = '{username}' AND product_id = '{product_id}'
            '''
            conn = self.create_connection()
            if conn:
                cur = conn.cursor()
                cur.execute(query)
                banner_details = cur.fetchall()
                cur.close()
                conn.close()
                column_names = [desc[0] for desc in cur.description]
                banner_list = {
                    "response": {
                        "msg": "We have successfully fetched session record",
                        "records": [
                            {column_names[i]: row[i] for i in range(len(row))} for row in banner_details
                        ],
                        "status": True,
                    }
                }

                return jsonify(banner_list)
        except Exception as e:
            print(f"Error retrieving session record from the database: {e}")
            return jsonify({"error": f"Error retrieving session record from the database: {e}"})
