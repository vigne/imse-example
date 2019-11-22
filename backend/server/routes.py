# didn't use mongoengine on purpose to better explain MongoDB interaction

import traceback
import init_db
import mongo_dao as db

from server import api, mongo

from datetime import datetime
from flask import redirect, jsonify, abort, request, make_response, json, url_for, g

from auth import token_auth, basic_auth

@api.route('/users', methods=['POST'])
def register_user():
    user_data = request.json
    try:
        new_user = db.register_user(user_data)
    except (Exception) as e:
        traceback.print_exc()
        abort(make_response(({"error": "Failed inserting user", "exception": str(e)}, 500)))
    return (url_for('user_details', user_id=str(new_user)), 201)

@api.route('/users', methods=['GET'])
@token_auth.login_required
def get_all_users():
    return jsonify(db.get_all_users())

@api.route("/users/<string:user_id>", methods=['GET', 'DELETE'])
@token_auth.login_required
def user_details(user_id):
    if g.current_user != user_id:  # only the user itself can see details or delete the profile
        return ("Unauthorized", 401)

    if request.method == 'GET':
        return jsonify(db.get_user(user_id))
    if request.method == 'DELETE':
        db.delete_user(user_id)
        return ("deleted: %s" % user_id, 200)


@api.route("/user/<string:user_id>/activity")
@token_auth.login_required
def get_user_activity(user_id):
    return jsonify(db.get_user_activity(user_id))


@api.route("/posts", methods=['GET'])
@token_auth.login_required
def get_featured_posts():
    limit = request.args.get("limit") or 5
    return jsonify(db.get_featured_posts(limit))


@api.route("/posts", methods=['POST'])
@token_auth.login_required
def create_post():
    post = request.json
    post['author'] = g.current_user
    post['author_name'] = db.get_user_name(g.current_user) # saves a join per read from now on
    post['creation_date'] = datetime.utcnow()
    try:
        post = db.store_post(post)
    except Exception as e:
        traceback.print_exc()
        abort(make_response(({"error": "Failed inserting post", "exception": str(e)}, 500)))
    return ("Post created: posts/%s" % post, 201)


@api.route("/posts/<string:post_id>", methods=['GET'])
@token_auth.login_required
def get_post(post_id):
    return db.get_post(post_id)

@api.route("/posts/<string:post_id>", methods=['POST'])
@token_auth.login_required
def add_comment(post_id):
    comment = request.json
    comment['author'] = g.current_user
    comment['author_name'] = db.get_user_name(g.current_user) # saves a join per read from now on
    comment['creation_date'] = datetime.utcnow()
    try:
        db.add_comment(post_id, comment)
    except Exception as e:
        traceback.print_exc()
        abort(make_response(({"error": "Failed inserting comment", "exception": str(e)}, 500)))
    return ("Comment created", 201)

# get posts by category
@api.route("/category/<string:category_id>")
@token_auth.login_required
def get_posts_by_category(category_id):
    posts = db.get_posts_by_category(category_id, request.args.get("page"), request.args.get("items_per_page"))
    if posts is None:
        abort(404)
    return jsonify(posts)